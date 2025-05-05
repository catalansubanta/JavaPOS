package com.javapos.controller;

import com.javapos.dao.UserDAO;
import com.javapos.model.User;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/profile/*")
public class ProfileController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;

    public void init() {
        userDAO = new UserDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        
        if (pathInfo == null || pathInfo.equals("/")) {
            // Show profile page
            request.getRequestDispatcher("/Pages/Admin/profile.jsp").forward(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        
        if (pathInfo == null || pathInfo.equals("/")) {
            // Update profile information
            updateProfile(request, response);
        } else if (pathInfo.equals("/password")) {
            // Change password
            changePassword(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    private void updateProfile(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user != null) {
            String fullName = request.getParameter("fullName");
            String phone = request.getParameter("phone");
            
            user.setFullName(fullName);
            user.setPhone(phone);
            
            if (userDAO.updateUserProfile(user)) {
                session.setAttribute("user", user);
                request.setAttribute("successMessage", "Profile updated successfully!");
            } else {
                request.setAttribute("errorMessage", "Failed to update profile. Please try again.");
            }
        }
        
        request.getRequestDispatcher("/Pages/Admin/profile.jsp").forward(request, response);
    }

    private void changePassword(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user != null) {
            String currentPassword = request.getParameter("currentPassword");
            String newPassword = request.getParameter("newPassword");
            
            // Verify current password
            User validatedUser = userDAO.validateUser(user.getUsername(), currentPassword);
            
            if (validatedUser != null) {
                user.setPassword(newPassword);
                
                if (userDAO.updateUserPassword(user)) {
                    request.setAttribute("successMessage", "Password updated successfully!");
                } else {
                    request.setAttribute("errorMessage", "Failed to update password. Please try again.");
                }
            } else {
                request.setAttribute("errorMessage", "Current password is incorrect.");
            }
        }
        
        request.getRequestDispatcher("/Pages/Admin/profile.jsp").forward(request, response);
    }
} 
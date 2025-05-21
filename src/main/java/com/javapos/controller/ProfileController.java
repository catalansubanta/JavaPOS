package com.javapos.controller;

import com.javapos.dao.UserDAO;
import com.javapos.model.User;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/profile")
public class ProfileController extends HttpServlet {
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User currentUser = (User) session.getAttribute("user");

        if (currentUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        request.setAttribute("user", currentUser);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/Pages/Profile/user-profile.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User currentUser = (User) session.getAttribute("user");

        if (currentUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");

        currentUser.setFullName(fullName);
        currentUser.setEmail(email);
        currentUser.setPhone(phone);
        if (password != null && !password.isEmpty()) {
            currentUser.setPassword(password);
            userDAO.updateUserPassword(currentUser);
        }

        boolean updated = userDAO.updateUserProfile(currentUser);
        if (updated) {
            session.setAttribute("user", currentUser); // update session
            request.setAttribute("message", "Profile updated successfully.");
        } else {
            request.setAttribute("error", "Failed to update profile.");
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher("/Pages/Profile/user-profile.jsp");
        dispatcher.forward(request, response);
    }
}

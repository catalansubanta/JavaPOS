package com.javapos.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.javapos.dao.UserDAO;
import com.javapos.model.User;

@WebServlet("/update-profile")
public class UpdateProfileController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;

    public void init() {
        userDAO = new UserDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");

        if (currentUser == null) {
            response.sendRedirect("Pages/login.jsp");
            return;
        }

        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");

        // Update user object
        currentUser.setFullName(fullName);
        currentUser.setEmail(email);
        currentUser.setPhone(phone);

        if (userDAO.updateUserProfile(currentUser)) {
            session.setAttribute("user", currentUser);
            response.sendRedirect("Pages/Profile/user-profile.jsp");
        } else {
            request.setAttribute("error", "Failed to update profile");
            request.getRequestDispatcher("Pages/Profile/edit-profile.jsp").forward(request, response);
        }
    }
}

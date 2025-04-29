package com.javapos.controller;

import com.javapos.dao.UserDAO;
import com.javapos.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/updateProfile")
public class UpdateProfileController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get form data
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");

        // Get session user
        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("userWithSession");

        if (user != null) {
            user.setEmail(email);
            user.setPhone(phone);

            try {
                boolean success = new UserDAO().updateUserProfile(user);
                if (success) {
                    session.setAttribute("userWithSession", user); // update session
                    response.sendRedirect(request.getContextPath() + "/Pages/Profile/user-profile.jsp");
                } else {
                    request.setAttribute("errorMessage", "Update failed. Please try again.");
                    request.getRequestDispatcher("/Pages/Profile/edit-profile.jsp").forward(request, response);
                }
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("errorMessage", "Error: " + e.getMessage());
                request.getRequestDispatcher("/Pages/Profile/edit-profile.jsp").forward(request, response);
            }

        } else {
            response.sendRedirect(request.getContextPath() + "/Pages/auth/login.jsp");
        }
    }
}

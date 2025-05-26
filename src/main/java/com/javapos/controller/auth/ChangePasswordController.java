package com.javapos.controller.auth;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.mindrot.jbcrypt.BCrypt;

import com.javapos.dao.UserDAO;
import com.javapos.model.User;

@WebServlet("/change-password")
public class ChangePasswordController extends HttpServlet {
    private UserDAO userDAO;

    public void init() {
        userDAO = new UserDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        String storedPassword = userDAO.getPasswordByUsername(user.getUsername());

        if (storedPassword == null || storedPassword.trim().isEmpty()) {
            request.setAttribute("error", "Stored password not found. Please contact admin.");
        } else {
            boolean passwordMatch = false;

            if (storedPassword.startsWith("$2a$")) {
                // Hashed password
                passwordMatch = BCrypt.checkpw(currentPassword, storedPassword);
            } else {
                // Plain text fallback
                passwordMatch = currentPassword.equals(storedPassword);
            }

            if (!passwordMatch) {
                request.setAttribute("error", "Current password is incorrect.");
            } else if (!newPassword.equals(confirmPassword)) {
                request.setAttribute("error", "New passwords do not match.");
            } else {
                // Hash and update new password
                String hashedNewPassword = BCrypt.hashpw(newPassword, BCrypt.gensalt());
                boolean success = userDAO.updatePassword(user.getUsername(), hashedNewPassword);
                if (success) {
                    request.setAttribute("success", "Password updated successfully.");
                } else {
                    request.setAttribute("error", "Failed to update password. Please try again.");
                }
            }
        }

        request.getRequestDispatcher("/Pages/Profile/edit-password.jsp").forward(request, response);
    }
}

package com.javapos.controller.auth;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.javapos.dao.UserDAO;
import com.javapos.model.User;
import com.javapos.utils.PasswordUtils;

@WebServlet("/register")
public class RegisterController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;

    public void init() {
        userDAO = new UserDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        // Get user input from request
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String role = request.getParameter("role");

        // Hash the password
        String hashedPassword = PasswordUtils.hash(password);

        // Check if the username, email, or phone already exists
        if (userDAO.isUsernameExists(username)) {
            request.setAttribute("error", "Username already exists");
            request.getRequestDispatcher("Pages/auth/register.jsp").forward(request, response);
            return;
        }

        if (userDAO.isEmailExists(email)) {
            request.setAttribute("error", "Email already exists");
            request.getRequestDispatcher("Pages/auth/register.jsp").forward(request, response);
            return;
        }

        if (userDAO.isPhoneExists(phone)) {
            request.setAttribute("error", "Phone number already exists");
            request.getRequestDispatcher("Pages/auth/register.jsp").forward(request, response);
            return;
        }

        // Create new user object with hashed password
        User user = new User(username, hashedPassword, fullName, email, phone, role, "active");

        // Attempt to register the user
        if (userDAO.registerUser(user)) {
            response.sendRedirect("Pages/auth/login.jsp");
        } else {
            request.setAttribute("error", "Registration failed");
            request.getRequestDispatcher("Pages/auth/register.jsp").forward(request, response);
        }
    }
}

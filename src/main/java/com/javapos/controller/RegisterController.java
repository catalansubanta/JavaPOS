package com.javapos.controller;

import com.javapos.dao.UserDAO;
import com.javapos.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/register")
public class RegisterController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        String fullName = request.getParameter("fullname");
        String email = request.getParameter("email");
        String username = request.getParameter("username");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        if (!password.equals(confirmPassword)) {
            request.setAttribute("errorMessage", "Passwords do not match!");
            request.getRequestDispatcher("/Pages/auth/register.jsp").forward(request, response);
            return;
        }

        UserDAO dao = new UserDAO();

        if (dao.isUsernameExists(username)) {
            request.setAttribute("errorMessage", "Username already exists!");
            request.getRequestDispatcher("/Pages/auth/register.jsp").forward(request, response);
            return;
        }

        if (dao.isEmailExists(email)) {
            request.setAttribute("errorMessage", "Email already exists!");
            request.getRequestDispatcher("/Pages/auth/register.jsp").forward(request, response);
            return;
        }

        if (dao.isPhoneExists(phone)) {
            request.setAttribute("errorMessage", "Phone number already exists!");
            request.getRequestDispatcher("/Pages/auth/register.jsp").forward(request, response);
            return;
        }

        User newUser = new User(fullName, email, username, phone, password, "waiter");

        if (dao.registerUser(newUser)) {
            response.sendRedirect("Pages/auth/login.jsp");
        } else {
            request.setAttribute("errorMessage", "Registration failed. Please try again.");
            request.getRequestDispatcher("/Pages/auth/register.jsp").forward(request, response);
        }
    }
}

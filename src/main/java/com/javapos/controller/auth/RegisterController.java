package com.javapos.controller.auth;

import com.javapos.dao.UserDAO;
import com.javapos.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/register")
public class RegisterController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            redirectToDashboard(request, response);
            return;
        }
        request.getRequestDispatcher("/Pages/auth/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        User user = new User();
        user.setUsername(username);
        user.setEmail(email);
        user.setPassword(password);
        user.setRole(role);

        if (userDAO.registerUser(user)) {
            response.sendRedirect(request.getContextPath() + "/Pages/auth/login.jsp");
        } else {
            request.setAttribute("error", "Registration failed. Please try again.");
            request.getRequestDispatcher("/Pages/auth/register.jsp").forward(request, response);
        }
    }

    private void redirectToDashboard(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        String role = user.getRole().toLowerCase();
        String dashboardPath;
        
        switch (role) {
            case "admin":
                dashboardPath = "/Pages/Admin/homepage.jsp";
                break;
            case "cashier":
                dashboardPath = "/Pages/Dashboard/cashier-dashboard.jsp";
                break;
            case "waiter":
                dashboardPath = "/Pages/Dashboard/waiter-dashboard.jsp";
                break;
            default:
                dashboardPath = "/error?message=Invalid role";
                break;
        }
        
        response.sendRedirect(request.getContextPath() + dashboardPath);
    }
} 
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

@WebServlet("/login")
public class LoginController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            redirectToDashboard(request, response);
        } else {
            request.getRequestDispatcher("/Pages/auth/login.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String loginId = request.getParameter("loginId");
        String password = request.getParameter("password");

        // Try to validate with email first
        User user = userDAO.validateUser(loginId, password);
        
        // If not found with email, try with username
        if (user == null) {
            user = userDAO.validateUserByUsername(loginId, password);
        }

        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            redirectToDashboard(request, response);
        } else {
            request.setAttribute("error", "Invalid email/username or password");
            request.getRequestDispatcher("/Pages/auth/login.jsp").forward(request, response);
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
                dashboardPath = "/Pages/Admin/home.jsp";
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
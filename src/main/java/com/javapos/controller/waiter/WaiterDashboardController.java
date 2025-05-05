package com.javapos.controller.waiter;

import com.javapos.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/waiter/dashboard")
public class WaiterDashboardController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/Pages/auth/login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        if (!"waiter".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/error?message=Unauthorized access");
            return;
        }

        request.getRequestDispatcher("/Pages/Dashboard/waiter-dashboard.jsp").forward(request, response);
    }
} 
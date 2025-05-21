package com.javapos.controller;

import com.javapos.dao.UserDAO;
import com.javapos.model.User;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/manage-users")
public class ManageUsersController extends HttpServlet {
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Use the existing method from your DAO
        List<User> users = userDAO.getAllUsers();

        // Set as attribute for use in JSP
        request.setAttribute("users", users);

        // Forward to the admin-users.jsp page
        RequestDispatcher dispatcher = request.getRequestDispatcher("/Pages/Admin/admin-users.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        String action = request.getParameter("action");
        int userId = Integer.parseInt(request.getParameter("userId"));

        if ("reset".equals(action)) {
            // Reset password to a default value
            userDAO.updateUserPassword(new User() {{
                setUserId(userId);
                setPassword("123456"); // Default password
            }});
        } else if ("deactivate".equals(action)) {
            // Optional: Implement deactivate functionality in DAO
        } else if ("updateRole".equals(action)) {
            String newRole = request.getParameter("role");
            // Optional: Implement role update functionality in DAO
        }

        // Redirect back to refresh the page
        response.sendRedirect(request.getContextPath() + "/admin/manage-users");
    }
}

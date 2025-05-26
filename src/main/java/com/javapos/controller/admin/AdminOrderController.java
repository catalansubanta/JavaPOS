package com.javapos.controller.admin;

import com.javapos.dao.OrderDAO;
import com.javapos.model.Order;
import com.javapos.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/orders")
public class AdminOrderController extends HttpServlet {

    private OrderDAO orderDAO;

    @Override
    public void init() throws ServletException {
        orderDAO = new OrderDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("=== AdminOrderController.doGet() invoked ===");
        
        User user = (User) request.getSession().getAttribute("loggedInUser");
        if (user == null) {
            System.out.println("No loggedInUser in session.");
            response.sendRedirect(request.getContextPath() + "/Pages/auth/login.jsp");
            return;
        }
        System.out.println("Logged in user: " + user.getUserId() + ", Role: " + user.getRole());
        
        if (!"admin".equalsIgnoreCase(user.getRole())) {
            System.out.println("User role is not admin. Redirecting.");
            response.sendRedirect(request.getContextPath() + "/Pages/auth/login.jsp");
            return;
        }

        List<Order> orders = orderDAO.getAllOrders();
        System.out.println("Fetched orders size: " + orders.size());

        request.setAttribute("orderList", orders);
        request.getRequestDispatcher("/Pages/Admin/admin-orders.jsp").forward(request, response);
    }
    
    
}

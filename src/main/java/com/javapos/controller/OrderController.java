package com.javapos.controller;

import com.javapos.dao.OrderDAO;
import com.javapos.dao.OrderItemDAO;
import com.javapos.model.Order;
import com.javapos.model.OrderItem;
import com.javapos.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.List;

@WebServlet("/waiter/orders")
public class OrderController extends HttpServlet {

    private OrderDAO orderDAO;
    private OrderItemDAO orderItemDAO;

    @Override
    public void init() throws ServletException {
        orderDAO = new OrderDAO();
        orderItemDAO = new OrderItemDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession(false).getAttribute("loggedInUser");
        if (user == null || !"waiter".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/Pages/auth/login.jsp");
            return;
        }

        String action = request.getParameter("action");
        if ("details".equalsIgnoreCase(action)) {
            showOrderDetails(request, response);
        } else {
            listOrders(request, response);
        }
    }

    private void listOrders(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession(false).getAttribute("loggedInUser");
        List<Order> orders = orderDAO.getOrdersByUserId(user.getUserId());
        request.setAttribute("orders", orders);
        request.getRequestDispatcher("/Pages/Waiter/waiter-my-orders.jsp").forward(request, response);
    }

    private void showOrderDetails(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String orderIdStr = request.getParameter("orderId");
        if (orderIdStr == null) {
            response.sendRedirect(request.getContextPath() + "/waiter/orders");
            return;
        }
        int orderId = Integer.parseInt(orderIdStr);
        List<OrderItem> orderItems = orderItemDAO.getOrderItemsByOrderId(orderId);
        request.setAttribute("orderItems", orderItems);
        request.getRequestDispatcher("/Pages/Orders/-order.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // You can add order submission logic here if needed
        response.sendRedirect(request.getContextPath() + "/waiter/orders");
    }
}

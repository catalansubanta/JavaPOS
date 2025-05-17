package com.javapos.controller.admin;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.javapos.dao.UserDAO;
import com.javapos.dao.OrderDAO;
import com.javapos.model.User;
import com.javapos.model.Order;


import java.io.IOException;
import java.util.List;

@WebServlet("/admin/dashboard")
public class AdminDashboardController extends HttpServlet {

    private OrderDAO orderDAO;
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        orderDAO = new OrderDAO();
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get recent 5 orders
        List<Order> recentOrders = orderDAO.getRecentOrders(5);

        // Get recent 5 users
        List<User> recentUsers = userDAO.getRecentUsers(5);

        // Get user role counts
        int adminCount = userDAO.countByRole("Admin");
        int cashierCount = userDAO.countByRole("Cashier");
        int waiterCount = userDAO.countByRole("Waiter");

        // Set attributes for JSP
        request.setAttribute("recentOrders", recentOrders);
        request.setAttribute("recentUsers", recentUsers);
        request.setAttribute("adminCount", adminCount);
        request.setAttribute("cashierCount", cashierCount);
        request.setAttribute("waiterCount", waiterCount);

        // Forward to JSP
        request.getRequestDispatcher("/Pages/Admin/admin-dashboard.jsp").forward(request, response);
    }
}

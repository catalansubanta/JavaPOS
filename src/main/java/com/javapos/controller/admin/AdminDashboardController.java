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

        List<Order> recentOrders = orderDAO.getRecentOrders(5);
        List<User> recentUsers = userDAO.getRecentUsers(5);

        double totalSales = orderDAO.getTotalSales();
        int totalOrders = orderDAO.getTotalOrderCount();
        int pendingOrders = orderDAO.getUnpaidOrdersCount();

        int adminCount = userDAO.countByRole("admin");
        int cashierCount = userDAO.countByRole("cashier");
        int waiterCount = userDAO.countByRole("waiter");

        // Set attributes for the JSP
        request.setAttribute("totalSales", totalSales);
        request.setAttribute("totalOrders", totalOrders);
        request.setAttribute("pendingOrders", pendingOrders);
        request.setAttribute("adminCount", adminCount);
        request.setAttribute("cashierCount", cashierCount);
        request.setAttribute("waiterCount", waiterCount);
        request.setAttribute("recentOrders", recentOrders);
        request.setAttribute("recentUsers", recentUsers);

        
        System.out.println("Total Sales: " + totalSales);
        System.out.println("Total Orders: " + totalOrders);
        System.out.println("Pending Orders: " + pendingOrders);
        System.out.println("Admins: " + adminCount);
        System.out.println("Cashiers: " + cashierCount);
        System.out.println("Waiters: " + waiterCount);
        System.out.println("Recent Orders size: " + recentOrders.size());
        System.out.println("Recent Users size: " + recentUsers.size());
        // Forward only once
        request.getRequestDispatcher("/Pages/Dashboard/admin-dashboard.jsp").forward(request, response);
    }

}

<%@ page import="com.javapos.model.User" %>
<%@ page import="com.javapos.dao.ItemDAO" %>
<%@ page import="com.javapos.dao.UserDAO" %>
<%@ page import="com.javapos.dao.OrderDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<%@ page import="java.lang.String" %>

<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"admin".equalsIgnoreCase(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/Pages/auth/login.jsp");
        return;
    }

    // Get statistics from database
    ItemDAO itemDAO = new ItemDAO();
    UserDAO userDAO = new UserDAO();
    OrderDAO orderDAO = new OrderDAO();

    int totalProducts = itemDAO.getTotalItems();
    double totalSales = orderDAO.getTotalSales();
    int totalUsers = userDAO.getTotalUsers();
    
    // Get user counts by role
    int adminCount = userDAO.getUsersByRole("admin").size();
    int cashierCount = userDAO.getUsersByRole("cashier").size();
    int waiterCount = userDAO.getUsersByRole("waiter").size();

    request.setAttribute("currentPage", "home");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Home - Restaurant POS</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        .stats-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 20px;
            padding: 20px;
        }

        .stat-card {
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }

        .stat-number {
            font-size: 24px;
            font-weight: bold;
            color: #4996d1;
            margin-top: 10px;
        }

        .chart-container {
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            margin: 20px;
        }

        .welcome-message {
            text-align: center;
            padding: 20px;
            margin: 20px;
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
    </style>
</head>
<body>
    <jsp:include page="/Pages/Common/header.jsp" />
    
    <div class="container">
        <div class="dashboard-header">
            <h1>Admin Dashboard</h1>
            <p>Welcome to your restaurant management system</p>
        </div>

        <div class="stats-container">
            <div class="stat-card">
                <i class="fas fa-box"></i>
                <div class="stat-info">
                    <h3>Total Products</h3>
                    <p>${totalProducts}</p>
                </div>
            </div>
            <div class="stat-card">
                <i class="fas fa-dollar-sign"></i>
                <div class="stat-info">
                    <h3>Total Sales</h3>
                    <p>$${totalSales}</p>
                </div>
            </div>
            <div class="stat-card">
                <i class="fas fa-users"></i>
                <div class="stat-info">
                    <h3>Total Users</h3>
                    <p>${totalUsers}</p>
                </div>
            </div>
        </div>

        <div class="dashboard-actions">
            <a href="${pageContext.request.contextPath}/admin/products" class="action-card">
                <i class="fas fa-boxes"></i>
                <span>Manage Products</span>
            </a>
            <a href="${pageContext.request.contextPath}/admin/users" class="action-card">
                <i class="fas fa-user-cog"></i>
                <span>Manage Users</span>
            </a>
            <a href="${pageContext.request.contextPath}/admin/orders" class="action-card">
                <i class="fas fa-clipboard-list"></i>
                <span>View Orders</span>
            </a>
            <a href="${pageContext.request.contextPath}/admin/reports" class="action-card">
                <i class="fas fa-chart-bar"></i>
                <span>Reports</span>
            </a>
        </div>

        <div class="chart-container">
            <canvas id="salesChart"></canvas>
        </div>

        <div class="chart-container">
            <canvas id="usersChart"></canvas>
        </div>
    </div>

    <jsp:include page="/Pages/Common/footer.jsp" />

    <script>
        // Sales Chart
        const salesCtx = document.getElementById('salesChart').getContext('2d');
        new Chart(salesCtx, {
            type: 'line',
            data: {
                labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'],
                datasets: [{
                    label: 'Monthly Sales',
                    data: [12000, 19000, 15000, 25000, 22000, 30000],
                    borderColor: 'rgb(75, 192, 192)',
                    tension: 0.1
                }]
            },
            options: {
                responsive: true,
                plugins: {
                    title: {
                        display: true,
                        text: 'Monthly Sales Overview'
                    }
                }
            }
        });

        // Users Chart
        const usersCtx = document.getElementById('usersChart').getContext('2d');
        new Chart(usersCtx, {
            type: 'bar',
            data: {
                labels: ['Admin', 'Cashier', 'Waiter'],
                datasets: [{
                    label: 'Users by Role',
                    data: [${adminCount}, ${cashierCount}, ${waiterCount}],
                    backgroundColor: [
                        'rgba(255, 99, 132, 0.5)',
                        'rgba(54, 162, 235, 0.5)',
                        'rgba(255, 206, 86, 0.5)'
                    ]
                }]
            },
            options: {
                responsive: true,
                plugins: {
                    title: {
                        display: true,
                        text: 'Users by Role'
                    }
                }
            }
        });
    </script>
</body>
</html> 
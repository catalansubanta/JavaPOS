<%@ page import="com.javapos.model.User" %>
<%@ page import="com.javapos.dao.ItemDAO" %>
<%@ page import="com.javapos.dao.UserDAO" %>
<%@ page import="com.javapos.dao.OrderDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

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
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Home - JavaPOS</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/dashboard.css">
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

<% request.setAttribute("currentPage", "Home"); %>
<jsp:include page="/Pages/Common/header.jsp" />

<div class="welcome-message">
    <h2>Welcome, <%= user.getFullName() %></h2>
    <p>Here's an overview of your restaurant's performance</p>
</div>

<div class="stats-container">
    <div class="stat-card">
        <h3>Total Products</h3>
        <p class="stat-number"><%= totalProducts %></p>
    </div>
    <div class="stat-card">
        <h3>Total Sales</h3>
        <p class="stat-number">Rs. <%= String.format("%.2f", totalSales) %></p>
    </div>
    <div class="stat-card">
        <h3>Total Users</h3>
        <p class="stat-number"><%= totalUsers %></p>
    </div>
</div>

<div class="chart-container">
    <canvas id="salesChart"></canvas>
</div>

<div class="chart-container">
    <canvas id="usersChart"></canvas>
</div>

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
    const userData = {
        admin: <%= adminCount %>,
        cashier: <%= cashierCount %>,
        waiter: <%= waiterCount %>
    };
    
    new Chart(usersCtx, {
        type: 'bar',
        data: {
            labels: ['Admin', 'Cashier', 'Waiter'],
            datasets: [{
                label: 'Users by Role',
                data: [userData.admin, userData.cashier, userData.waiter],
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

<jsp:include page="/Pages/Common/footer.jsp" />
</body>
</html> 
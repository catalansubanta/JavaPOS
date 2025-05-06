<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    request.setAttribute("currentPage", "dashboard");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard - Restaurant POS</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <jsp:include page="/Pages/Common/header.jsp" />
    
    <div class="container">
        <!-- Dashboard Header -->
        <div class="dashboard-header">
            <h1>Admin Dashboard</h1>
            <p>Manage your restaurant's operations from here</p>
        </div>

        <!-- Dashboard Action Buttons -->
        <div class="dashboard-actions">
            <a href="${pageContext.request.contextPath}/admin/products" class="action-card">
                <i class="fas fa-boxes"></i>
                <span>Products</span>
                <p>Manage your menu items and inventory</p>
            </a>
            <a href="${pageContext.request.contextPath}/admin/users" class="action-card">
                <i class="fas fa-users-cog"></i>
                <span>Users</span>
                <p>Manage user accounts and roles</p>
            </a>
            <a href="${pageContext.request.contextPath}/admin/orders" class="action-card">
                <i class="fas fa-clipboard-list"></i>
                <span>Orders</span>
                <p>View and manage orders</p>
            </a>
            <a href="${pageContext.request.contextPath}/admin/reports" class="action-card">
                <i class="fas fa-chart-bar"></i>
                <span>Reports</span>
                <p>View performance and sales reports</p>
            </a>
            <a href="${pageContext.request.contextPath}/admin/settings" class="action-card">
                <i class="fas fa-cog"></i>
                <span>Settings</span>
                <p>Configure system settings</p>
            </a>
            <a href="${pageContext.request.contextPath}/admin/backup" class="action-card">
                <i class="fas fa-database"></i>
                <span>Backup</span>
                <p>Backup and restore your data</p>
            </a>
        </div>

        <!-- Sales & Users Charts -->
        <div class="chart-container">
            <h3>Sales Overview</h3>
            <canvas id="salesChart"></canvas>
        </div>

        <div class="chart-container">
            <h3>User Distribution</h3>
            <canvas id="usersChart"></canvas>
        </div>

        <!-- Recent Orders -->
        <div class="recent-container">
            <div class="recent-header">
                <h3>Recent Orders</h3>
                <a href="${pageContext.request.contextPath}/admin/orders" class="btn">View All</a>
            </div>
            <table class="table">
                <thead>
                    <tr>
                        <th>Order ID</th>
                        <th>Customer</th>
                        <th>Amount</th>
                        <th>Status</th>
                        <th>Date</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${recentOrders}" var="order">
                        <tr>
                            <td>${order.orderId}</td>
                            <td>${order.customerName}</td>
                            <td>$${order.totalAmount}</td>
                            <td>${order.status}</td>
                            <td>${order.orderDate}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <!-- Recent Users -->
        <div class="recent-container">
            <div class="recent-header">
                <h3>Recent Users</h3>
                <a href="${pageContext.request.contextPath}/admin/users" class="btn">View All</a>
            </div>
            <table class="table">
                <thead>
                    <tr>
                        <th>User ID</th>
                        <th>Name</th>
                        <th>Role</th>
                        <th>Email</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${recentUsers}" var="user">
                        <tr>
                            <td>${user.userId}</td>
                            <td>${user.fullName}</td>
                            <td>${user.role}</td>
                            <td>${user.email}</td>
                            <td>${user.status}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

    </div>

    <jsp:include page="/Pages/Common/footer.jsp" />

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script>
        // Sales Overview Chart
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
                        text: 'Sales Overview'
                    }
                }
            }
        });

        // User Distribution Chart
        const usersCtx = document.getElementById('usersChart').getContext('2d');
        new Chart(usersCtx, {
            type: 'pie',
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
                        text: 'User Distribution'
                    }
                }
            }
        });
    </script>
</body>
</html>

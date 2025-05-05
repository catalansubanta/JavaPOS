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
        <div class="dashboard-header">
            <h1>Management Dashboard</h1>
            <p>Manage your restaurant's operations</p>
        </div>

        <div class="dashboard-actions">
            <a href="${pageContext.request.contextPath}/admin/products" class="action-card">
                <i class="fas fa-boxes"></i>
                <span>Products</span>
                <p>Manage menu items and inventory</p>
            </a>
            <a href="${pageContext.request.contextPath}/admin/users" class="action-card">
                <i class="fas fa-user-cog"></i>
                <span>Users</span>
                <p>Manage staff accounts and roles</p>
            </a>
            <a href="${pageContext.request.contextPath}/admin/orders" class="action-card">
                <i class="fas fa-clipboard-list"></i>
                <span>Orders</span>
                <p>View and manage all orders</p>
            </a>
            <a href="${pageContext.request.contextPath}/admin/reports" class="action-card">
                <i class="fas fa-chart-bar"></i>
                <span>Reports</span>
                <p>View sales and performance reports</p>
            </a>
            <a href="${pageContext.request.contextPath}/admin/settings" class="action-card">
                <i class="fas fa-cog"></i>
                <span>Settings</span>
                <p>Configure system settings</p>
            </a>
            <a href="${pageContext.request.contextPath}/admin/backup" class="action-card">
                <i class="fas fa-database"></i>
                <span>Backup</span>
                <p>Manage data backup and restore</p>
            </a>
        </div>

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
</body>
</html> 
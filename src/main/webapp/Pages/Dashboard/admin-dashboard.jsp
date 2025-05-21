<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpSession" %>
<%@ page import="javax.servlet.*, javax.servlet.http.*, javax.servlet.annotation.*" %>
<%@ page import="com.javapos.model.User" %>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    User user = (User) session.getAttribute("loggedInUser");
    if (user == null || !"admin".equals(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/Pages/auth/login.jsp");
        return;
    }
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
            <a href="${pageContext.request.contextPath}/Pages/Admin/admin-menu.jsp" class="action-card">
                <i class="fas fa-boxes"></i>
                <span>Menu</span>
                <p>Manage your menu items and inventory</p>
            </a>
            <a href="${pageContext.request.contextPath}/Pages/Admin/admin-users.jsp" class="action-card">
                <i class="fas fa-users-cog"></i>
                <span>Users</span>
                <p>Manage user accounts and roles</p>
            </a>
            <a href="${pageContext.request.contextPath}/Pages/Admin/admin-orders.jsp" class="action-card">
                <i class="fas fa-clipboard-list"></i>
                <span>Orders</span>
                <p>View and manage orders</p>
            </a>
            <a href="${pageContext.request.contextPath}/Pages/Admin/admin-report.jsp" class="action-card">
                <i class="fas fa-chart-bar"></i>
                <span>Reports</span>
                <p>View performance and sales reports</p>
            </a>
            <a href="${pageContext.request.contextPath}/Pages/Common/page-under.jsp" class="action-card">
                <i class="fas fa-cog"></i>
                <span>Settings</span>
                <p>Configure system settings</p>
            </a>
            <a href="${pageContext.request.contextPath}/Pages/Common/page-under.jsp" class="action-card">
                <i class="fas fa-database"></i>
                <span>Backup</span>
                <p>Backup and restore your data</p>
            </a>
        </div>

        <!-- admin-dashboard.jsp -->

<div class="stats-container">
  <div class="stat-card">
    <h3>Total Sales</h3>
    <p>Rs ${totalSales}</p>
  </div>
  <div class="stat-card">
    <h3>Total Orders</h3>
    <p>${totalOrders}</p>
  </div>
  <div class="stat-card">
    <h3>Pending Orders</h3>
    <p>${pendingOrders}</p>
  </div>
  <div class="stat-card">
    <h3>Admins</h3>
    <p>${adminCount}</p>
  </div>
  <div class="stat-card">
    <h3>Cashiers</h3>
    <p>${cashierCount}</p>
  </div>
  <div class="stat-card">
    <h3>Waiters</h3>
    <p>${waiterCount}</p>
  </div>
</div>

<hr>

<div class="recent-section">
  <div class="section-header" style="display: flex; justify-content: space-between; align-items: center;">
    <h3>Recent Orders</h3>
    <a href="${pageContext.request.contextPath}/Pages/Admin/admin-orders.jsp" class="btn">View All</a>
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
      <c:forEach var="order" items="${recentOrders}">
        <tr>
          <td>${order.orderId}</td>
          <td>${order.customerName}</td>
          <td>Rs ${order.totalAmount}</td>
          <td>${order.status}</td>
          <td>${order.orderDate}</td>
        </tr>
      </c:forEach>
    </tbody>
  </table>
</div>

<hr>

<div class="recent-section">
  <div class="section-header" style="display: flex; justify-content: space-between; align-items: center;">
    <h3>Recent Users</h3>
    <a href="${pageContext.request.contextPath}/Pages/Admin/admin-users.jsp" class="btn">View All</a>
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
      <c:forEach var="user" items="${recentUsers}">
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


    <jsp:include page="/Pages/Common/footer.jsp" />

</body>
</html>

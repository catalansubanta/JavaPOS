<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.javapos.model.User" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    User user = (User) session.getAttribute("loggedInUser");
    if (user == null || !"waiter".equals(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/Pages/auth/login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Waiter Dashboard - Restaurant POS</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <jsp:include page="/Pages/Common/header.jsp" />
    
    <div class="container">
        <!-- Dashboard Header -->
        <div class="dashboard-header">
            <h1>Welcome, <%= user.getFullName() %></h1>
            <p>Manage tables, orders, and your cart.</p>
        </div>

        <!-- Dashboard Action Buttons -->
        <div class="dashboard-actions">
            <a href="${pageContext.request.contextPath}/Pages/Waiter/waiter-tables.jsp" class="action-card">
                <i class="fas fa-chair"></i>
                <span>Tables</span>
                <p>View and manage tables</p>
            </a>
            <a href="${pageContext.request.contextPath}/Pages/Waiter/waiter-menu-list.jsp" class="action-card">
                <i class="fas fa-utensils"></i>
                <span>View Menu</span>
                <p>Browse the menu items</p>
            </a>
            
            <a href="${pageContext.request.contextPath}/Pages/Waiter/waiter-cart.jsp" class="action-card">
                <i class="fas fa-shopping-cart"></i>
                <span>My Cart</span>
                <p>View your current cart</p>
            </a>
            <a href="${pageContext.request.contextPath}/Pages/Waiter/waiter-orders.jsp" class="action-card">
                <i class="fas fa-receipt"></i>
                <span>My Orders</span>
                <p>Check your past orders</p>
            </a>
        </div>

        <hr>

        <!-- Stats section - example (you can populate these from servlet/controller) -->
        <div class="stats-container">
            <div class="stat-card">
                <h3>Total Orders Today</h3>
                <p>${totalOrdersToday}</p>
            </div>
            <div class="stat-card">
                <h3>Pending Orders</h3>
                <p>${pendingOrders}</p>
            </div>
            <div class="stat-card">
                <h3>Tables Served</h3>
                <p>${tablesServed}</p>
            </div>
        </div>

        <hr>

        

    <jsp:include page="/Pages/Common/footer.jsp" />
</body>
</html>

<%@ page import="com.javapos.model.User" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Cashier Dashboard - JavaPOS</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/dashboard.css">
</head>
<body>

<%
    User user = (User) session.getAttribute("userWithSession");
    if (user == null || !"cashier".equals(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/Pages/auth/login.jsp");
        return;
    }
%>

<% request.setAttribute("currentPage", "cashier-dashboard"); %>
<jsp:include page="/Pages/Common/header.jsp" />

<!-- Dashboard Content -->
<main class="dashboard-container">

    <h2 class="dashboard-title">Welcome to the Cashier Dashboard</h2>

    <p class="dashboard-subtitle">
        Hello, <strong><%= user.getFullName() %></strong><br>
        Select an action below to proceed:
    </p>

    <div class="dashboard-box">
        <a href="#" class="dashboard-btn">View Orders</a>
        <a href="#" class="dashboard-btn">Order Details</a>
        <a href="#" class="dashboard-btn">Pending Payments</a>
        <a href="#" class="dashboard-btn">Completed Payments</a>
        <a href="#" class="dashboard-btn">Process Payment</a>
        <a href="#" class="dashboard-btn">Search Orders</a>
    </div>

</main>

<!-- Include Footer -->
<jsp:include page="/Pages/Common/footer.jsp" />

</body>
</html>

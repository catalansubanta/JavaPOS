<%@ page import="com.javapos.model.User" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Waiter Dashboard - JavaPOS</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/dashboard.css">
</head>
<body>

<%
    User user = (User) session.getAttribute("userWithSession");
    if (user == null || !"waiter".equals(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/Pages/auth/login.jsp");
        return;
    }
%>

<% request.setAttribute("currentPage", "waiter-dashboard"); %>
<jsp:include page="/Pages/Common/header.jsp" />

<!-- Dashboard Content -->
<main class="dashboard-container">

    <h2 class="dashboard-title">Welcome to the Waiter Dashboard</h2>

    <p class="dashboard-subtitle">
        Hello, <strong><%= user.getFullName() %></strong><br>
        Select an action below to proceed:
    </p>

    <div class="dashboard-box">
        <a href="#" class="dashboard-btn">My Tables</a>
        <a href="#" class="dashboard-btn">View Menu</a>
        <a href="#" class="dashboard-btn">New Order</a>
        <a href="#" class="dashboard-btn">My Cart</a>
        <a href="#" class="dashboard-btn">My Orders</a>
    </div>

</main>

<!-- Include Footer -->
<jsp:include page="/Pages/Common/footer.jsp" />

</body>
</html>

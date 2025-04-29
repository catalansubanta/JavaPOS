<%@ page import="com.javapos.model.User" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard - JavaPOS</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/dashboard.css">
</head>
<body>

<%
    User user = (User) session.getAttribute("userWithSession");
    if (user == null || !"admin".equals(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/Pages/auth/login.jsp");
        return;
    }
%>

<% request.setAttribute("currentPage", "admin-ashboard"); %>
<jsp:include page="/Pages/Common/header.jsp" />

<!-- Dashboard Content -->
<main class="dashboard-container">

    <h2 class="dashboard-title">Welcome to the Admin Dashboard</h2>

    <p class="dashboard-subtitle">
        Hello, <strong><%= user.getFullName() %></strong><br>
        Choose any of the following actions to continue:
    </p>

    <div class="dashboard-box">
        <a href="<%= request.getContextPath() %>/Pages/Menu/menu-list.jsp" class="dashboard-btn">View Menu</a>
        <a href="#" class="dashboard-btn">Add New Item</a>
        <a href="#" class="dashboard-btn">Edit/Delete Items</a>
        <a href="#" class="dashboard-btn">View Orders</a>
        <a href="#" class="dashboard-btn">User Management</a>
        <a href="#" class="dashboard-btn">Reports</a>
    </div>

</main>

<!-- Include Footer -->
<jsp:include page="/Pages/Common/footer.jsp" />

</body>
</html>

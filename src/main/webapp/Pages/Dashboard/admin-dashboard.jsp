<%@ page import="com.javapos.model.User" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard - JavaPOS</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/dashboard.css">
    <style>
        .dashboard-container {
            max-width: 1200px;
            margin: 40px auto;
            padding: 20px;
        }

        .dashboard-box {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }

        .dashboard-btn {
            display: block;
            padding: 20px;
            background-color: #f8f9fa;
            border: 1px solid #dee2e6;
            border-radius: 8px;
            text-align: center;
            text-decoration: none;
            color: #212529;
            transition: all 0.3s ease;
        }

        .dashboard-btn:hover {
            background-color: #e9ecef;
            transform: translateY(-2px);
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }

        .dashboard-title {
            text-align: center;
            color: #333;
            margin-bottom: 1rem;
        }

        .dashboard-subtitle {
            text-align: center;
            color: #666;
            margin-bottom: 2rem;
        }
    </style>
</head>
<body>

<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"admin".equalsIgnoreCase(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/Pages/auth/login.jsp");
        return;
    }
%>

<% request.setAttribute("currentPage", "Dashboard"); %>
<jsp:include page="/Pages/Common/header.jsp" />

<main class="dashboard-container">
    <h2 class="dashboard-title">Admin Dashboard</h2>
    <p class="dashboard-subtitle">
        Hello, <strong><%= user.getFullName() %></strong><br>
        Choose any of the following actions to continue:
    </p>

    <div class="dashboard-box">
        <a href="<%= request.getContextPath() %>/Pages/Admin/sales.jsp" class="dashboard-btn">Sales Overview</a>
        <a href="<%= request.getContextPath() %>/Pages/Admin/users.jsp" class="dashboard-btn">User Management</a>
        <a href="<%= request.getContextPath() %>/Pages/Admin/orders.jsp" class="dashboard-btn">View Orders</a>
        <a href="<%= request.getContextPath() %>/Pages/Menu/add-items.jsp" class="dashboard-btn">Add New Item</a>
        <a href="<%= request.getContextPath() %>/Pages/Menu/edit-items.jsp" class="dashboard-btn">Edit/Delete Items</a>
        <a href="<%= request.getContextPath() %>/Pages/Admin/reports.jsp" class="dashboard-btn">Reports</a>
    </div>
</main>

<jsp:include page="/Pages/Common/footer.jsp" />
</body>
</html>

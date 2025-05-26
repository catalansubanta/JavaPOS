<%@ page import="com.javapos.model.User" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    User user = (User) session.getAttribute("loggedInUser");
    if (user == null || !"admin".equalsIgnoreCase(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/Pages/auth/login.jsp");
        return;
    }
%>
<% 
    String message = (String) request.getAttribute("message");
    String messageType = (String) request.getAttribute("messageType");
    if (message != null) {
%>
    <div class="alert <%= "success".equals(messageType) ? "alert-success" : "alert-danger" %>">
        <%= message %>
    </div>
<%
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add New User - Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>

<jsp:include page="/Pages/Common/header.jsp">
    <jsp:param name="currentPage" value="admin-users"/>
</jsp:include>

<div class="container">
    <div class="dashboard-header">
        <h1>Add New User</h1>
        <p class="text-muted">Enter the details to register a new user.</p>
        <br>
        <a href="${pageContext.request.contextPath}/Pages/Admin/admin-users.jsp" class="btn">
            <i class="fas fa-arrow-left"></i> Back to Users
            <br>
        </a>
    </div>

    <form action="${pageContext.request.contextPath}/user/add" method="post" class="form-card">
        <label>Full Name:</label>
        <input type="text" name="fullName" required>
        <br>
        <br>

        <label>Username:</label>
        <input type="text" name="username" required>
        <br>
        <br>

        <label>Email:</label>
        <input type="email" name="email" required>
        <br>
        <br>

        <label>Phone:</label>
        <input type="text" name="phone" required>
        <br>
        <br>

        <label>Password:</label>
        <input type="password" name="password" required>
        <br>
        <br>

        <label>Role:</label>
        <select name="role" required>
            <option value="">Select Role</option>
            <option value="admin">Admin</option>
            <option value="cashier">Cashier</option>
            <option value="waiter">Waiter</option>
        </select>
        <br>
        <br>

        <label>Status:</label>
        <select name="status" required>
            <option value="active" selected>Active</option>
            <option value="inactive">Inactive</option>
        </select>
        <br>
        <br>

        <button type="submit" class="btn"><i class="fas fa-user-plus"></i> Create User</button>
    </form>
</div>
<br>
<br>

<jsp:include page="/Pages/Common/footer.jsp"/>

</body>
</html>

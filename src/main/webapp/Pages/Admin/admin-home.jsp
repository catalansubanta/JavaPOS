<%@ page import="com.javapos.model.User" %>
<%@ page import="com.javapos.dao.ItemDAO" %>
<%@ page import="com.javapos.dao.UserDAO" %>
<%@ page import="com.javapos.dao.OrderDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"admin".equalsIgnoreCase(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/Pages/auth/login.jsp");
        return;
    }

    ItemDAO itemDAO = new ItemDAO();
    UserDAO userDAO = new UserDAO();
    OrderDAO orderDAO = new OrderDAO();

    int totalProducts = itemDAO.getTotalItems();
    double totalSales = orderDAO.getTotalSales();
    int totalUsers = userDAO.getTotalUsers();

    request.setAttribute("totalProducts", totalProducts);
    request.setAttribute("totalSales", totalSales);
    request.setAttribute("totalUsers", totalUsers);
    request.setAttribute("currentPage", "home");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Home - Restaurant POS</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <jsp:include page="/Pages/Common/header.jsp" />

    <div class="container">
        <div class="welcome-message">
            <h1>Welcome, Admin!</h1>
            <p class="muted-text">Here’s a quick overview of your restaurant system.</p>
        </div>

        <div class="stats-container">
            <div class="stat-card">
                <i class="fas fa-box fa-2x"></i>
                <div class="stat-info">
                    <h3>Total Products</h3>
                    <p> ${totalProducts} </p>
                </div>
            </div>
            <div class="stat-card">
                <i class="fas fa-coins fa-2x"></i>
                <div class="stat-info">
                    <h3>Total Sales</h3>
                    <p>Rs. ${totalSales} </p>
                </div>
            </div>
            <div class="stat-card">
                <i class="fas fa-users fa-2x"></i>
                <div class="stat-info">
                    <h3>Total Users</h3>
                    <p> ${totalUsers} </p>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="/Pages/Common/footer.jsp" />
</body>
</html>

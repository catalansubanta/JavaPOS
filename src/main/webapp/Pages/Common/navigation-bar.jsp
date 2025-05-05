<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String userType = (String) session.getAttribute("userType");
    String currentPage = request.getRequestURI();
%>

<nav class="nav-bar">
    <ul class="nav-list">
        <% if ("admin".equals(userType)) { %>
            <li class="nav-item <%= currentPage.contains("home-admin") ? "active" : "" %>">
                <a href="${pageContext.request.contextPath}/admin/home">Home</a>
            </li>
            <li class="nav-item <%= currentPage.contains("dashboard") ? "active" : "" %>">
                <a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a>
            </li>
            <li class="nav-item <%= currentPage.contains("product") ? "active" : "" %>">
                <a href="${pageContext.request.contextPath}/admin/products">Products</a>
            </li>
            <li class="nav-item <%= currentPage.contains("users") ? "active" : "" %>">
                <a href="${pageContext.request.contextPath}/admin/users">Users</a>
            </li>
        <% } else if ("cashier".equals(userType)) { %>
            <li class="nav-item <%= currentPage.contains("home-cashier") ? "active" : "" %>">
                <a href="${pageContext.request.contextPath}/cashier/home">Home</a>
            </li>
            <li class="nav-item <%= currentPage.contains("orders") ? "active" : "" %>">
                <a href="${pageContext.request.contextPath}/cashier/orders">Orders</a>
            </li>
            <li class="nav-item <%= currentPage.contains("payments") ? "active" : "" %>">
                <a href="${pageContext.request.contextPath}/cashier/payments">Payments</a>
            </li>
        <% } else if ("waiter".equals(userType)) { %>
            <li class="nav-item <%= currentPage.contains("home-waiter") ? "active" : "" %>">
                <a href="${pageContext.request.contextPath}/waiter/home">Home</a>
            </li>
            <li class="nav-item <%= currentPage.contains("tables") ? "active" : "" %>">
                <a href="${pageContext.request.contextPath}/waiter/tables">Tables</a>
            </li>
            <li class="nav-item <%= currentPage.contains("orders") ? "active" : "" %>">
                <a href="${pageContext.request.contextPath}/waiter/orders">Orders</a>
            </li>
        <% } %>
        <li class="nav-item <%= currentPage.contains("profile") ? "active" : "" %>">
            <a href="${pageContext.request.contextPath}/profile">Profile</a>
        </li>
    </ul>
</nav> 
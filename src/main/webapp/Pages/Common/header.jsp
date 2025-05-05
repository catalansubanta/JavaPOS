<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String currentPage = request.getParameter("currentPage");
    if (currentPage == null) {
        currentPage = "";
    }
%>
<header class="main-header">
    <div class="header-content">
        <div class="logo">
            <h1>Restaurant POS</h1>
        </div>
        
        <div class="user-info">
            <c:if test="${not empty sessionScope.user}">
                <span class="welcome">Welcome, ${sessionScope.user.fullName}</span>
                <a href="${pageContext.request.contextPath}/logout" class="btn btn-logout">Logout</a>
            </c:if>
        </div>
    </div>
    
    <nav class="main-nav">
        <c:if test="${not empty sessionScope.user}">
            <c:choose>
                <c:when test="${sessionScope.user.role eq 'admin'}">
                    <a href="${pageContext.request.contextPath}/admin/dashboard" 
                       class="nav-item ${currentPage eq 'dashboard' ? 'active' : ''}">Dashboard</a>
                    <a href="${pageContext.request.contextPath}/menu-items" 
                       class="nav-item ${currentPage eq 'menu-items' ? 'active' : ''}">Menu Items</a>
                    <a href="${pageContext.request.contextPath}/admin/users" 
                       class="nav-item ${currentPage eq 'users' ? 'active' : ''}">Users</a>
                </c:when>
                <c:when test="${sessionScope.user.role eq 'cashier'}">
                    <a href="${pageContext.request.contextPath}/cashier/dashboard" 
                       class="nav-item ${currentPage eq 'dashboard' ? 'active' : ''}">Dashboard</a>
                    <a href="${pageContext.request.contextPath}/cashier/orders" 
                       class="nav-item ${currentPage eq 'orders' ? 'active' : ''}">Orders</a>
                    <a href="${pageContext.request.contextPath}/cashier/payments" 
                       class="nav-item ${currentPage eq 'payments' ? 'active' : ''}">Payments</a>
                </c:when>
                <c:when test="${sessionScope.user.role eq 'waiter'}">
                    <a href="${pageContext.request.contextPath}/waiter/dashboard" 
                       class="nav-item ${currentPage eq 'dashboard' ? 'active' : ''}">Dashboard</a>
                    <a href="${pageContext.request.contextPath}/waiter/orders" 
                       class="nav-item ${currentPage eq 'orders' ? 'active' : ''}">Orders</a>
                    <a href="${pageContext.request.contextPath}/waiter/tables" 
                       class="nav-item ${currentPage eq 'tables' ? 'active' : ''}">Tables</a>
                </c:when>
            </c:choose>
            <a href="${pageContext.request.contextPath}/menu" 
               class="nav-item ${currentPage eq 'menu' ? 'active' : ''}">Menu</a>
            <a href="${pageContext.request.contextPath}/profile" 
               class="nav-item ${currentPage eq 'profile' ? 'active' : ''}">Profile</a>
        </c:if>
    </nav>
</header>

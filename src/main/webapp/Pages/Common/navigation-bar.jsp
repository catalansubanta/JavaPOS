<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.javapos.model.User" %> <!-- Import the User class -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <!-- JSTL Core Taglib -->

<%
String currentPage = request.getParameter("currentPage") != null ? request.getParameter("currentPage") : "";
String userType = "";
if (session.getAttribute("user") != null) {
    User user = (User) session.getAttribute("user");
    userType = user.getRole();
}
%>

<nav class="main-nav">
    <ul class="nav-list">
        
        <c:if test="${not empty sessionScope.user}">
            <c:set var="userType" value="${sessionScope.user.role}" />
        </c:if>
        
        <!-- Admin Navigation -->
        <c:if test="${userType == 'admin'}">
             <li class="nav-item ${currentPage.contains('admin-home') ? 'active' : ''}">
                    <a href="${pageContext.request.contextPath}/Pages/Admin/admin-home.jsp">Home</a>
                </li>
                <li class="nav-item ${currentPage.contains('admin-dashboard') ? 'active' : ''}">
                    <a href="${pageContext.request.contextPath}/Pages/Dashboard/admin-dashboard.jsp">Dashboard</a>
                </li>
                <li class="nav-item ${currentPage.contains('menu-list') ? 'active' : ''}">
                    <a href="${pageContext.request.contextPath}/Pages/Menu/menu-list.jsp">Menu</a>
                </li>
                <li class="nav-item ${currentPage.contains('users') ? 'active' : ''}">
                    <a href="${pageContext.request.contextPath}/Pages/Admin/users.jsp">Users</a>
                </li>
                <li class="nav-item ${currentPage.contains('view-order') ? 'active' : ''}">
                    <a href="${pageContext.request.contextPath}/Pages/Orders/view-order.jsp">Orders</a>
                </li>
        </c:if>

        <!-- Cashier Navigation -->
        <c:if test="${userType == 'cashier'}">
            <li class="nav-item ${currentPage.contains('home') ? 'active' : ''}">
                    <a href="${pageContext.request.contextPath}/cashier/home">Home</a>
                </li>
                <li class="nav-item ${currentPage.contains('orders') ? 'active' : ''}">
                    <a href="${pageContext.request.contextPath}/cashier/orders">Orders</a>
                </li>
                <li class="nav-item ${currentPage.contains('payments') ? 'active' : ''}">
                    <a href="${pageContext.request.contextPath}/cashier/payments">Payments</a>
                </li>
        </c:if>

        <!-- Waiter Navigation -->
        <c:if test="${userType == 'waiter'}">
            <li class="nav-item ${currentPage.contains('home') ? 'active' : ''}">
                    <a href="${pageContext.request.contextPath}/waiter/home">Home</a>
                </li>
                <li class="nav-item ${currentPage.contains('tables') ? 'active' : ''}">
                    <a href="${pageContext.request.contextPath}/waiter/tables">Tables</a>
                </li>
                <li class="nav-item ${currentPage.contains('orders') ? 'active' : ''}">
                    <a href="${pageContext.request.contextPath}/waiter/orders">Orders</a>
                </li>
        </c:if>

        <!-- Common Profile Link -->
        <li class="nav-item ${currentPage.contains('profile') ? 'active' : ''}">
            <a href="${pageContext.request.contextPath}/Pages/Profile/user-profile.jsp">Profile</a>
        </li>
    </ul>
</nav>

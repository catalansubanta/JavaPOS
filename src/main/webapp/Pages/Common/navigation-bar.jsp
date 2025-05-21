<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.javapos.model.User" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="javax.servlet.*, javax.servlet.http.*, javax.servlet.annotation.*" %>




<%
    String currentPage = request.getParameter("currentPage") != null ? request.getParameter("currentPage") : "";
    String userType = "";
    if (session.getAttribute("loggedInUser") != null) {
        User user = (User) session.getAttribute("loggedInUser");
        userType = user.getRole();
        request.setAttribute("userType", userType); // allow JSTL access
        request.setAttribute("currentPage", currentPage); // allow JSTL access
    }
%>
 
<div class="main-nav">
    <c:choose>
        <c:when test="${userType == 'admin'}">
            <a class="nav-btn ${currentPage.contains('admin-home') ? 'active' : ''}"
               href="${pageContext.request.contextPath}/Pages/Admin/admin-home.jsp">Home</a>
            <a class="nav-btn ${currentPage.contains('admin-dashboard') ? 'active' : ''}"
               href="${pageContext.request.contextPath}/Pages/Dashboard/admin-dashboard.jsp">Dashboard</a>
            <a class="nav-btn ${currentPage.contains('profile') ? 'active' : ''}"
               href="${pageContext.request.contextPath}/Pages/Profile/user-profile.jsp">Profile</a>
        </c:when>

        <c:when test="${userType == 'cashier'}">
            <a class="nav-btn ${currentPage.contains('cashier-dashboard') ? 'active' : ''}"
               href="${pageContext.request.contextPath}/Pages/Dashboard/cashier-dashboard.jsp">Dashboard</a>
            <a class="nav-btn ${currentPage.contains('orders') ? 'active' : ''}"
               href="${pageContext.request.contextPath}/Pages/Cashier/cashier-orders.jsp">Orders</a>
            <a class="nav-btn ${currentPage.contains('profile') ? 'active' : ''}"
               href="${pageContext.request.contextPath}/Pages/Profile/user-profile.jsp">Profile</a>
        </c:when>

        <c:when test="${userType == 'waiter'}">
            <a class="nav-btn ${currentPage.contains('waiter-dashboard') ? 'active' : ''}"
               href="${pageContext.request.contextPath}/Pages/Dashboard/waiter-dashboard.jsp">Dashboard</a>
            <a class="nav-btn ${currentPage.contains('cart') ? 'active' : ''}"
               href="${pageContext.request.contextPath}/Pages/Waiter/waiter-cart.jsp">Cart</a>
            <a class="nav-btn ${currentPage.contains('menu') ? 'active' : ''}"
               href="${pageContext.request.contextPath}/Pages/Waiter/waiter-menu-list.jsp">Menu</a>
            <a class="nav-btn ${currentPage.contains('profile') ? 'active' : ''}"
               href="${pageContext.request.contextPath}/Pages/Profile/user-profile.jsp">Profile</a>
        </c:when>
    </c:choose>
</div>

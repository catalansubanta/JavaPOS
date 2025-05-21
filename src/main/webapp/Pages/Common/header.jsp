<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.javapos.model.User" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<%
    String currentPage = request.getParameter("currentPage") != null ? request.getParameter("currentPage") : "";
    String userType = "";
    if (session.getAttribute("loggedInUser") != null) {
        User user = (User) session.getAttribute("loggedInUser");
        userType = user.getRole();
        request.setAttribute("userType", userType); 
        request.setAttribute("currentPage", currentPage); 
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Restaurant POS</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

<header class="main-header">
    <div class="header-content">
        <h1 class="logo">Restaurant POS</h1>
        <div class="user-info">
    <c:choose>
        <c:when test="${not empty sessionScope.loggedInUser}">
            <span>Welcome, ${sessionScope.loggedInUser.fullName}</span>
            <a href="${pageContext.request.contextPath}/logout" class="btn">Logout</a>
        </c:when>
        <c:otherwise>
            <a href="${pageContext.request.contextPath}/Pages/auth/login.jsp" class="btn">Login</a>
        </c:otherwise>
    </c:choose>
</div>

    <br>
    <jsp:include page="/Pages/Common/navigation-bar.jsp" />
</header>

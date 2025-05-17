<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.javapos.model.User" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    
    String userType = "";
    if (session.getAttribute("user") != null) {
        User user = (User) session.getAttribute("user");
        userType = user.getRole();
        request.setAttribute("userType", userType); 
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

        <c:if test="${not empty sessionScope.user}">
            <div class="user-info">
                <span>Welcome, ${sessionScope.user.fullName}</span>
                <a href="${pageContext.request.contextPath}/logout" class="btn">Logout</a>
            </div>
        </c:if>
    </div>

   
    <jsp:include page="/Pages/Common/navigation-bar.jsp" />
</header>

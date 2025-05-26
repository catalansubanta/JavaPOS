<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.javapos.model.User" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    User currentUser = (User) session.getAttribute("loggedInUser");
    request.setAttribute("currentUser", currentUser); 
    request.setAttribute("currentPage", "profile");
%>
<!DOCTYPE html>

<html>
<head>
    <meta charset="UTF-8">
    <title>Change Password</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
	 <jsp:include page="/Pages/Common/header.jsp" />
    <div class="container">
        <div class="dashboard-header">
            <h1>Change Password</h1>
        </div>
    <form action="${pageContext.request.contextPath}/change-password" method="post">
        <label>Current Password:</label><br>
        <input type="password" name="currentPassword" required><br>

        <label>New Password:</label><br>
        <input type="password" name="newPassword" required><br>

        <label>Confirm New Password:</label><br>
        <input type="password" name="confirmPassword" required><br><br>

        <input type="submit" value="Update Password">
    </form>

    <c:if test="${not empty error}">
        <p style="color:red;">${error}</p>
    </c:if>
    <c:if test="${not empty success}">
        <p style="color:green;">${success}</p>
    </c:if>
    
    <jsp:include page="/Pages/Common/footer.jsp" />
</body>
</html>

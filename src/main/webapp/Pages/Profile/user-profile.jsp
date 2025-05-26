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
    <title>User Profile</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <jsp:include page="/Pages/Common/header.jsp" />

    <div class="container">
        <div class="dashboard-header">
            <h1>My Profile</h1>
        </div>

        <div class="profile-details">
            <p><strong>Full Name:</strong> ${currentUser.fullName}</p>
            <br>
            <p><strong>Username:</strong> ${currentUser.username}</p>
            <br>
            <p><strong>Email:</strong> ${currentUser.email}</p>
            <br>
            <p><strong>Phone:</strong> ${currentUser.phone}</p>
            <br>
            <p><strong>Role:</strong> ${currentUser.role}</p>
            <br>

            <a href="${pageContext.request.contextPath}/Pages/Profile/edit-profile.jsp" class="btn">
                <i class="fas fa-edit"></i> Edit Profile
            </a>
            <a href="${pageContext.request.contextPath}/Pages/Profile/edit-password.jsp" class="btn">
                <i class="fas fa-edit"></i> Change Password
            </a>
        </div>
    </div>

    <jsp:include page="/Pages/Common/footer.jsp" />
</body>
</html>

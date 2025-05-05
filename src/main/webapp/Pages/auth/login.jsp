<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <title>Login - Restaurant POS</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/login.css">
</head>
<body class="auth-page">
	<div class="auth-container">
		<div class="auth-box">
            <h1>Restaurant POS</h1>
            <h2>Login</h2>

            <c:if test="${not empty error}">
                <div class="alert alert-danger">${error}</div>
            </c:if>

            <form action="${pageContext.request.contextPath}/login" method="post">
                <div class="form-group">
                    <label for="loginId">Email or Username</label>
                    <input type="text" id="loginId" name="loginId" required 
                           placeholder="Enter your email or username">
                </div>

                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" required 
                           placeholder="Enter your password">
                </div>

                <button type="submit" class="btn btn-primary">Login</button>
            </form>

            <div class="auth-links">
                <a href="${pageContext.request.contextPath}/register">Register</a>
            </div>
		</div>
	</div>
</body>
</html>

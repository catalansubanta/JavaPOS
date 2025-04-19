<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>Login</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="<%= request.getContextPath() %>/css/login.css">
</head>
<body>
	<div class="login-container">
		<div class="login-box">
			<h2>POS Login</h2>

			<!-- Error Message Display -->
			<% if (request.getAttribute("errorMessage") != null) { %>
				<p class="error"><%= request.getAttribute("errorMessage") %></p>
			<% } %>

			<!--SINGLE LOGIN FORM -->
			<form action="<%= request.getContextPath() %>/login" method="post">
				<label for="username">Username</label>
				<input type="text" id="username" name="username" required>

				<label for="password">Password</label>
				<input type="password" id="password" name="password" required>

				<button type="submit">Login</button>
			</form>

			<!--REGISTER LINK -->
			<p style="text-align:center; margin-top: 15px;">
				Don't have an account?
				<a href="<%= request.getContextPath() %>/Pages/auth/register.jsp">Register here</a>
			</p>
		</div>
	</div>
</body>
</html>

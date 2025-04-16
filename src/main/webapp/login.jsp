<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>Login</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="css/login.css">
</head>
<body>
	<div class="login-container">
		<div class="login-box">
			<h2>POS Login</h2>

			<!-- Error Message Display using scriptlets -->
			<% if (request.getAttribute("errorMessage") != null) { %>
				<p style="color:red;"><%= request.getAttribute("errorMessage") %></p>
			<% } %>

			<form action="login" method="post">
				<label>Username</label>
				<input type="text" name="username" required>

				<label>Password</label>
				<input type="password" name="password" required>

				<button type="submit">Login</button>
			</form>
		</div>
	</div>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <title>Login - JavaPOS</title>
   <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/login.css" />

    
</head>
<body class="login-page">
<div class="login-container">
<div class="login-box">
            <h2>Login to Resturant POS</h2>

            <% if (request.getAttribute("error") != null) { %>
                <div class="error-message">
                    <%= request.getAttribute("error") %>
                </div>
<% } %>

            <form action="<%= request.getContextPath() %>/login" method="post">
                <div class="form-group">
<label for="username">Username</label>
                    <input type="text" id="username" name="username" 
                           value="<%= request.getAttribute("username") != null ? request.getAttribute("username") : "" %>"
                           required>
                </div>

                <div class="form-group">
<label for="password">Password</label>
<input type="password" id="password" name="password" required>
                </div>

                <div class="form-group">
                    <button type="submit" class="login-btn">Login</button>
                </div>
</form>

            <div class="register-link">
                Don't have an account? <a href="<%= request.getContextPath() %>/Pages/auth/register.jsp">Register Here</a>
                
            </div>
</div>
</div>
</body>
</html>
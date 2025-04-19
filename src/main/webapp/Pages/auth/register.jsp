<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Register - JavaPOS</title>
  <link rel="stylesheet" href="<%= request.getContextPath() %>/css/register.css">
</head>
<body>
  <div class="register-container">
    <div class="register-box">
      <h2>Register</h2>

      <% if (request.getAttribute("errorMessage") != null) { %>
        <p class="error"><%= request.getAttribute("errorMessage") %></p>
      <% } %>

      <form action="<%= request.getContextPath() %>/register" method="post">
        <label>Full Name</label>
        <input type="text" name="fullname" required />

        <label>Email</label>
        <input type="email" name="email" required />

        <label>Username</label>
        <input type="text" name="username" required />

        <label>Phone</label>
        <input type="text" name="phone" required />

        <label>Password</label>
        <input type="password" name="password" required />

        <label>Confirm Password</label>
        <input type="password" name="confirmPassword" required />

        <button type="submit">Register</button>
      </form>

      <p>Already have an account? 
        <a href="<%= request.getContextPath() %>/Pages/auth/login.jsp">Login</a>
      </p>
    </div>
  </div>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Dashboard</title>
</head>
<body>
    <h2>Welcome to the Dashboard</h2>

    <% 
        String username = (String) session.getAttribute("username");
        if (username != null) {
    %>
        <p>Hello, <b><%= username %></b>!</p>
        <p><a href="logout">Logout</a></p>
    <% } else { %>
        <p style="color:red;">Unauthorized access. Please <a href="login.jsp">log in</a>.</p>
    <% } %>
</body>
</html>

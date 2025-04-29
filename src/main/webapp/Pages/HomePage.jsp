<%@ page import="com.javapos.model.User" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Home - JavaPOS</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/home.css">
</head>
<body>

<%
    User user = (User) session.getAttribute("userWithSession");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/Pages/auth/login.jsp");
        return;
    }
%>

<% request.setAttribute("currentPage", "HomePage"); %>
<jsp:include page="/Pages/Common/header.jsp" />

<!-- Main Welcome Content -->
<main class="home-container">
    <section class="welcome-box">
        <h2>Welcome to JavaPOS System</h2>
        <p>Hello, <strong><%= user.getFullName() %></strong>! You are logged in as 
           <strong><%= user.getRole().toUpperCase() %></strong>.</p>
    </section>
</main>

<!-- Include Footer -->
<jsp:include page="/Pages/Common/footer.jsp" />

</body>
</html>

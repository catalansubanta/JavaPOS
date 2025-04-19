<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.javapos.model.User" %>

<%
    User user = (User) session.getAttribute("userWithSession");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/Pages/auth/login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>JavaPOS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
  <div class="container-fluid">
    <a class="navbar-brand" href="#">JavaPOS</a>
    <div class="d-flex">
      <span class="navbar-text me-3 text-light">
        Hello, <b><%= user.getFullName() %></b> (<%= user.getRole() %>)
      </span>
      <a class="btn btn-outline-light" href="<%= request.getContextPath() %>/logout">Logout</a>
    </div>
  </div>
</nav>
<div class="container mt-4">

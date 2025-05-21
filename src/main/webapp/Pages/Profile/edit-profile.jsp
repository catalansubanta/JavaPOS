<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.javapos.model.User" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    User currentUser = (User) session.getAttribute("loggedInUser");
    request.setAttribute("currentPage", "profile");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Profile</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <jsp:include page="/Pages/Common/header.jsp" />

    <div class="container">
        <div class="dashboard-header">
            <h1>Edit Profile</h1>
        </div>

        <form action="${pageContext.request.contextPath}/profile" method="post" class="form">
            <input type="hidden" name="action" value="update">
            
            <label>Full Name</label>
            <input type="text" name="fullName" value="${currentUser.fullName}" required>

            <label>Email</label>
            <input type="email" name="email" value="${currentUser.email}" required>

            <label>Phone</label>
            <input type="text" name="phone" value="${currentUser.phone}" required>

            <button type="submit" class="btn"><i class="fas fa-save"></i> Save Changes</button>
        </form>
    </div>

    <jsp:include page="/Pages/Common/footer.jsp" />
</body>
</html>

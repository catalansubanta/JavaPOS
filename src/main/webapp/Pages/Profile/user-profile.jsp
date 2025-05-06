<%@ page import="com.javapos.model.User" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Profile</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>

<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/Pages/auth/login.jsp");
        return;
    }
%>


<!-- Header -->
<jsp:include page="/Pages/Common/header.jsp" />

<main>
    <div class="welcome-box">
        <h2 style="color: #4996D1;">Hello, <%= user.getFullName() %>!</h2>

        <div class="profile-box">
            <h4>Your Profile</h4>
            <p><strong>Username:</strong> <%= user.getUsername() %></p>
            <p><strong>Email:</strong> <%= user.getEmail() %></p>
            <p><strong>Phone:</strong> <%= user.getPhone() %></p>
            <p><strong>Role:</strong> <%= user.getRole() %></p>
            <br>
            <a href="edit-profile.jsp" class="btn">Edit Profile</a>
        </div>
    </div>
</main>

<!-- Footer -->
<jsp:include page="/Pages/Common/footer.jsp" />

</body>
</html>

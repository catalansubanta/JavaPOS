<%@ page import="com.javapos.model.User" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<%
    User user = (User) session.getAttribute("userWithSession");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/Pages/auth/login.jsp");
        return;
    }
%>

<jsp:include page="/Pages/Common/header.jsp" />

<div class="container mt-5">
    <h2 class="text-center">Welcome, <%= user.getFullName() %>!</h2>
    <p class="text-center">Your role: <b><%= user.getRole() %></b></p>

    <%
        String loggedInMsg = (String) session.getAttribute("alreadyLoggedInMessage");
        if (loggedInMsg != null) {
            session.removeAttribute("alreadyLoggedInMessage");
    %>
        <div class="alert alert-info text-center mt-3" role="alert">
            <%= loggedInMsg %>
        </div>
    <%
        }
    %>
</div>

<jsp:include page="/Pages/Common/footer.jsp" />

<!-- Optional JS to auto-hide alert -->
<script>
    setTimeout(() => {
        const alertBox = document.querySelector('.alert');
        if (alertBox) alertBox.remove();
    }, 3000);
</script>

</body>
</html>

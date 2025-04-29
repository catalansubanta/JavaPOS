<%@ page import="com.javapos.model.User" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Profile</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/dashboard.css">
</head>
<body>

<%
    User user = (User) session.getAttribute("userWithSession");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/Pages/auth/login.jsp");
        return;
    }
%>

<!-- Header -->
<jsp:include page="/Pages/Common/header.jsp" />

<main>
    <div class="welcome-box">
        <h2 style="color: #4996D1;">Edit Your Profile</h2>

        <div class="profile-box">
            <form action="<%= request.getContextPath() %>/updateProfile" method="post">
                <!-- Hidden ID field if needed -->
                <input type="hidden" name="userId" value="<%= user.getUserId() %>">

                <label for="username">Username:</label>
                <input type="text" id="username" name="username" value="<%= user.getUsername() %>" readonly>

                <label for="email">Email:</label>
                <input type="email" id="email" name="email" value="<%= user.getEmail() %>" required>

                <label for="phone">Phone:</label>
                <input type="text" id="phone" name="phone" value="<%= user.getPhone() %>" required>

                <!-- Optional: Add more fields like address, etc. -->

                <button type="submit" class="btn">Save Changes</button>
                <a href="<%= request.getContextPath() %>/Pages/Profile/user-profile.jsp" class="btn" style="background-color: #ccc; color: #333;">Cancel</a>
            </form>
        </div>
    </div>
</main>

<!-- Footer -->
<jsp:include page="/Pages/Common/footer.jsp" />

</body>
</html>

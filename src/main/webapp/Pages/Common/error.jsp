<%@ page isErrorPage="true" contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Error</title>
    <style>
        body {
            font-family: Arial;
            background-color: #f8d7da;
            color: #721c24;
            padding: 40px;
        }
        .error-box {
            background-color: #f1f1f1;
            border: 1px solid #721c24;
            padding: 20px;
            border-radius: 8px;
        }
    </style>
</head>
<body>
    <div class="error-box">
        <h2>Oops! Something went wrong.</h2>
        <p><strong>Error Message:</strong> <%= exception != null ? exception.getMessage() : "Unknown error." %></p>
        <p>Please contact support or try again later.</p>
        <a href="<%= request.getContextPath() %>/Pages/auth/login.jsp">Back to Login</a>
    </div>
    <jsp:include page="/Pages/Common/footer.jsp" />
</body>
</html>

<%@ page import="com.javapos.model.User" %>
<%@ page isErrorPage="true" contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Error</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #F0F8FF; /* Alice Blue */
            color: #721c24;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
        }

        .error-box {
            background-color: #fff;
            border: 2px solid #ff1313;
            padding: 30px;
            border-radius: 8px;
            width: 500px;
            max-width: 90%;
            text-align: center;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }

        h2 {
            color: #ff1313;
            margin-bottom: 10px;
        }

        a {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 16px;
            background-color: #4996D1;
            color: white;
            text-decoration: none;
            border-radius: 4px;
        }

        a:hover {
            background-color: #377bb3;
        }
    </style>
</head>
<body>

    <div class="error-box">
        <h2>Oops! Something went wrong.</h2>
        <p><strong>Error Message:</strong> <%= exception != null ? exception.getMessage() : "Unknown error occurred." %></p>
        <p>Please contact support or try again later.</p>
        <a href="<%= request.getContextPath() %>/Pages/auth/login.jsp">Back to Login</a>
    </div>

</body>
</html>

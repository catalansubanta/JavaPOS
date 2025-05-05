<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Error - JavaPOS</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/dashboard.css">
    <style>
        .error-container {
            max-width: 600px;
            margin: 100px auto;
            text-align: center;
            padding: 40px;
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }

        .error-icon {
            font-size: 64px;
            color: #dc3545;
            margin-bottom: 20px;
        }

        .error-message {
            font-size: 24px;
            color: #333;
            margin-bottom: 20px;
        }

        .error-details {
            color: #666;
            margin-bottom: 30px;
        }

        .error-actions {
            display: flex;
            justify-content: center;
            gap: 20px;
        }

        .btn {
            padding: 10px 20px;
            border-radius: 4px;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .btn-primary {
            background-color: #4996d1;
            color: white;
        }

        .btn-primary:hover {
            background-color: #3a7ab0;
        }

        .btn-secondary {
            background-color: #6c757d;
            color: white;
        }

        .btn-secondary:hover {
            background-color: #5a6268;
        }
    </style>
</head>
<body>

<% request.setAttribute("currentPage", "Error"); %>
<jsp:include page="/Pages/Common/header.jsp" />

<div class="error-container">
    <div class="error-icon">⚠️</div>
    <h1 class="error-message"><%= request.getAttribute("errorMessage") != null ? request.getAttribute("errorMessage") : "Oops! Something went wrong" %></h1>
    <p class="error-details"><%= request.getAttribute("errorDetails") != null ? request.getAttribute("errorDetails") : "We're sorry, but there was an error processing your request." %></p>
    
    <div class="error-actions">
        <a href="<%= request.getContextPath() %>/Pages/auth/login.jsp" class="btn btn-primary">Go to Login</a>
        <a href="javascript:history.back()" class="btn btn-secondary">Go Back</a>
    </div>
    </div>

<jsp:include page="/Pages/Common/footer.jsp" />
</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Error - Restaurant POS</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="container">
        <div class="error-container">
            <div class="error-icon">
                <c:choose>
                    <c:when test="${requestScope.errorType eq '404'}">
                        <i class="fas fa-exclamation-circle"></i>
                        <h1>404 - Page Not Found</h1>
                    </c:when>
                    <c:when test="${requestScope.errorType eq '403'}">
                        <i class="fas fa-lock"></i>
                        <h1>403 - Access Denied</h1>
                    </c:when>
                    <c:when test="${requestScope.errorType eq '500'}">
                        <i class="fas fa-exclamation-triangle"></i>
                        <h1>500 - Server Error</h1>
                    </c:when>
                    <c:otherwise>
                        <i class="fas fa-exclamation-circle"></i>
                        <h1>Oops! Something went wrong</h1>
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="error-message">
                <c:if test="${not empty requestScope.error}">
                    <p>${requestScope.error}</p>
                </c:if>
                <c:if test="${empty requestScope.error}">
                    <c:choose>
                        <c:when test="${requestScope.errorType eq '404'}">
                            <p>The page you are looking for might have been removed, had its name changed, or is temporarily unavailable.</p>
                        </c:when>
                        <c:when test="${requestScope.errorType eq '403'}">
                            <p>You don't have permission to access this resource. Please contact your administrator if you believe this is an error.</p>
                        </c:when>
                        <c:when test="${requestScope.errorType eq '500'}">
                            <p>An internal server error occurred. Our team has been notified and is working to fix the issue.</p>
                        </c:when>
                        <c:otherwise>
                            <p>An unexpected error occurred. Please try again later.</p>
                        </c:otherwise>
                    </c:choose>
                </c:if>
            </div>

            <div class="error-details">
                <c:if test="${not empty requestScope.errorDetails}">
                    <p class="error-details-text">${requestScope.errorDetails}</p>
                </c:if>
            </div>

            <div class="error-actions">
                <a href="${pageContext.request.contextPath}/" class="btn btn-primary">
                    <i class="fas fa-home"></i> Go to Home
                </a>
                <a href="javascript:history.back()" class="btn btn-secondary">
                    <i class="fas fa-arrow-left"></i> Go Back
                </a>
                <c:if test="${not empty sessionScope.user}">
                    <a href="${pageContext.request.contextPath}/contact" class="btn btn-info">
                        <i class="fas fa-envelope"></i> Contact Support
                    </a>
                </c:if>
            </div>
        </div>
    </div>
</body>
</html>

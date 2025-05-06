<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String currentPage = request.getParameter("currentPage");
    if (currentPage == null) {
        currentPage = "";
    }
%>

<header class="main-header">
    <div class="header-content">
        <div class="logo">
            <h1>Restaurant POS</h1>
        </div>
        
        <div class="user-info">
            <c:if test="${not empty sessionScope.user}">
                <span class="welcome">Welcome, ${sessionScope.user.fullName}</span>
                <a href="${pageContext.request.contextPath}/logout" class="btn btn-logout">Logout</a>
            </c:if>
        </div>
    </div>

    <!-- Include external navigation JSP -->
    <jsp:include page="/Pages/Common/navigation-bar.jsp" />
</header>

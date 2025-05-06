<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.javapos.model.User" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.lang.String" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    request.setAttribute("currentPage", "users");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Users - Restaurant POS</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <jsp:include page="/Pages/Common/header.jsp" />
    
    <div class="container">
        <div class="dashboard-header">
            <h1>Manage Users</h1>
            <div class="header-actions">
                <a href="${pageContext.request.contextPath}/admin/user-form" class="btn">
                    <i class="fas fa-plus"></i> Add New User
                </a>
            </div>
        </div>

        <c:if test="${not empty message}">
            <div class="alert alert-${messageType}">
                ${message}
            </div>
        </c:if>

        <div class="search-bar">
            <input type="text" id="searchInput" placeholder="Search users..." class="form-control">
            <button class="btn" onclick="searchUsers()">
                <i class="fas fa-search"></i> Search
            </button>
        </div>

        <div class="table-container">
            <table class="table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Role</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${users}" var="user">
                        <tr>
                            <td>${user.userId}</td>
                            <td>${user.name}</td>
                            <td>${user.email}</td>
                            <td>
                                <span class="role-badge ${user.role.toLowerCase()}">
                                    ${user.role}
                                </span>
                            </td>
                            <td>
                                <span class="status-badge ${user.status eq 'Active' ? 'active' : 'inactive'}">
                                    ${user.status}
                                </span>
                            </td>
                            <td>
                                <a href="${pageContext.request.contextPath}/admin/edit-user?id=${user.userId}" 
                                   class="btn-icon" title="Edit">
                                    <i class="fas fa-edit"></i>
                                </a>
                                <a href="#" onclick="deleteUser(${user.userId})" 
                                   class="btn-icon" title="Delete">
                                    <i class="fas fa-trash"></i>
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <div class="pagination">
            <c:if test="${currentPage > 1}">
                <a href="?page=${currentPage - 1}" class="btn">Previous</a>
            </c:if>
            <span>Page ${currentPage} of ${totalPages}</span>
            <c:if test="${currentPage < totalPages}">
                <a href="?page=${currentPage + 1}" class="btn">Next</a>
            </c:if>
        </div>
    </div>

    <jsp:include page="/Pages/Common/footer.jsp" />

    <script>
        function searchUsers() {
            const searchTerm = document.getElementById('searchInput').value;
            window.location.href = '?search=' + encodeURIComponent(searchTerm);
        }

        function deleteUser(userId) {
            if (confirm('Are you sure you want to delete this user?')) {
                window.location.href = '${pageContext.request.contextPath}/admin/delete-user?id=' + userId;
            }
        }
    </script>
</body>
</html> 
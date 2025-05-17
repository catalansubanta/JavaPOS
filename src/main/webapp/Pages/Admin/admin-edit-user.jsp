<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.javapos.model.User" %>
<%@ page import="java.lang.String" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="javax.servlet.*, javax.servlet.http.*, javax.servlet.annotation.*" %>

<%
    request.setAttribute("currentPage", "users");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${empty user ? 'Add New User' : 'Edit User'} - Restaurant POS</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <jsp:include page="/Pages/Common/header.jsp" />
    
    <div class="container">
        <div class="dashboard-header">
            <h1>${empty user ? 'Add New User' : 'Edit User'}</h1>
            <a href="${pageContext.request.contextPath}/admin/users" class="btn">
                <i class="fas fa-arrow-left"></i> Back to Users
            </a>
        </div>

        <c:if test="${not empty message}">
            <div class="alert alert-${messageType}">
                ${message}
            </div>
        </c:if>

        <div class="form-container">
            <form action="${pageContext.request.contextPath}/admin/save-user" method="post">
                <input type="hidden" name="userId" value="${user.userId}">
                
                <div class="form-group">
                    <label for="name">Full Name</label>
                    <input type="text" id="name" name="name" class="form-control" 
                           value="${user.name}" required>
                </div>

                <div class="form-group">
                    <label for="email">Email Address</label>
                    <input type="email" id="email" name="email" class="form-control" 
                           value="${user.email}" required>
                </div>

                <div class="form-group">
                    <label for="role">Role</label>
                    <select id="role" name="role" class="form-control" required>
                        <option value="">Select Role</option>
                        <option value="Admin" ${user.role eq 'Admin' ? 'selected' : ''}>
                            Admin
                        </option>
                        <option value="Cashier" ${user.role eq 'Cashier' ? 'selected' : ''}>
                            Cashier
                        </option>
                        <option value="Waiter" ${user.role eq 'Waiter' ? 'selected' : ''}>
                            Waiter
                        </option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="password">${empty user ? 'Password' : 'New Password'}</label>
                    <input type="password" id="password" name="password" class="form-control" 
                           ${empty user ? 'required' : ''}>
                    <small class="form-text text-muted">
                        ${empty user ? 'Enter a password for the new user' : 'Leave blank to keep current password'}
                    </small>
                </div>

                <div class="form-group">
                    <label for="confirmPassword">Confirm Password</label>
                    <input type="password" id="confirmPassword" name="confirmPassword" 
                           class="form-control" ${empty user ? 'required' : ''}>
                </div>

                <div class="form-group">
                    <label for="status">Status</label>
                    <select id="status" name="status" class="form-control" required>
                        <option value="Active" ${user.status eq 'Active' ? 'selected' : ''}>
                            Active
                        </option>
                        <option value="Inactive" ${user.status eq 'Inactive' ? 'selected' : ''}>
                            Inactive
                        </option>
                    </select>
                </div>

                <div class="form-actions">
                    <button type="button" class="btn btn-secondary" 
                            onclick="window.location.href='${pageContext.request.contextPath}/admin/users'">
                        Cancel
                    </button>
                    <button type="submit" class="btn">
                        ${empty user ? 'Add User' : 'Update User'}
                    </button>
                </div>
            </form>
        </div>
    </div>

    <jsp:include page="/Pages/Common/footer.jsp" />
    
<!-- need to change -->
    <script>
        document.querySelector('form').addEventListener('submit', function(e) {
            const password = document.getElementById('password').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            
            if (password && password !== confirmPassword) {
                e.preventDefault();
                alert('Passwords do not match!');
            }
        });
    </script>
</body>
</html> 
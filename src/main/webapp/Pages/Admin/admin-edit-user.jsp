<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.javapos.model.User" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    User editUser = (User) request.getAttribute("editUser");
    request.setAttribute("currentPage", "users");
    
    User user = (User) session.getAttribute("loggedInUser");
    if (user == null || !"admin".equalsIgnoreCase(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/Pages/auth/login.jsp");
        return;
    }
    
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit User - Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <jsp:include page="/Pages/Common/header.jsp" />

    <div class="container">
        <div class="dashboard-header">
            <h1>Edit User</h1>
        </div>

        <form action="${pageContext.request.contextPath}/manage-users" method="post" class="form">
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="userId" value="${editUser.userId}">

            <label>Full Name</label>
            <input type="text" name="fullName" value="${editUser.fullName}" required>

            <label>Email</label>
            <input type="email" name="email" value="${editUser.email}" required>

            <label>Phone</label>
            <input type="text" name="phone" value="${editUser.phone}" required>

            <label>Role</label>
            <select name="role" required>
                <option value="admin" ${editUser.role == 'admin' ? 'selected' : ''}>Admin</option>
                <option value="cashier" ${editUser.role == 'cashier' ? 'selected' : ''}>Cashier</option>
                <option value="waiter" ${editUser.role == 'waiter' ? 'selected' : ''}>Waiter</option>
            </select>

            <label>Status</label>
            <select name="status" required>
                <option value="Active" ${editUser.status == 'Active' ? 'selected' : ''}>Active</option>
                <option value="Inactive" ${editUser.status == 'Inactive' ? 'selected' : ''}>Inactive</option>
            </select>

            <button type="submit" class="btn"><i class="fas fa-save"></i> Update User</button>
        </form>
    </div>

    <jsp:include page="/Pages/Common/footer.jsp" />
</body>
</html>

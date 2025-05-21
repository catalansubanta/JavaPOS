<%@ page import="java.util.List" %>
<%@ page import="com.javapos.model.User" %>
<%@ page import="com.javapos.dao.UserDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    // Admin access only
    User user = (User) session.getAttribute("loggedInUser");
    if (user == null || !"admin".equalsIgnoreCase(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/Pages/auth/login.jsp");
        return;
    }

    UserDAO userDAO = new UserDAO();
    String roleFilter = request.getParameter("role");
    String statusFilter = request.getParameter("status");

    List<User> userList;

    if ((roleFilter != null && !roleFilter.isEmpty()) || (statusFilter != null && !statusFilter.isEmpty())) {
        userList = userDAO.filterUsers(roleFilter, statusFilter); // Implement this method
    } else {
        userList = userDAO.getAllUsers();
    }

    request.setAttribute("userList", userList);
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

<jsp:include page="/Pages/Common/header.jsp">
    <jsp:param name="currentPage" value="manage-users"/>
</jsp:include>

<div class="container">
    <div class="dashboard-header">
        <h1>Manage Users</h1>
        <p class="text-muted">Add, edit, or deactivate user accounts in the system.</p>
        <br>
        <a href="${pageContext.request.contextPath}/Pages/Admin/admin-add-user.jsp" class="btn">
            <i class="fas fa-user-plus"></i> Add New User
        </a>
    </div>

    <form method="get" action="${pageContext.request.contextPath}/Pages/Admin/admin-users.jsp" class="search-bar">
        <select name="role">
            <option value="">All Roles</option>
            <option value="admin" <c:if test="${param.role == 'admin'}">selected</c:if>>Admin</option>
            <option value="cashier" <c:if test="${param.role == 'cashier'}">selected</c:if>>Cashier</option>
            <option value="waiter" <c:if test="${param.role == 'waiter'}">selected</c:if>>Waiter</option>
        </select>
        <select name="status">
            <option value="">All Statuses</option>
            <option value="active" <c:if test="${param.status == 'active'}">selected</c:if>>Active</option>
            <option value="inactive" <c:if test="${param.status == 'inactive'}">selected</c:if>>Inactive</option>
        </select>
        <button type="submit" class="btn">Filter</button>
        <a href="${pageContext.request.contextPath}/Pages/Admin/admin-users.jsp" class="btn">Clear</a>
    </form>

    <div class="table-container">
        <table class="table">
            <thead>
                <tr>
                    <th>Username</th>
                    <th>Full Name</th>
                    <th>Role</th>
                    <th>Email</th>
                    <th>Phone</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${not empty userList}">
                        <c:forEach var="u" items="${userList}">
                            <tr>
                                <td>${u.username}</td>
                                <td>${u.fullName}</td>
                                <td>${u.role}</td>
                                <td>${u.email}</td>
                                <td>${u.phone}</td>
                                <td>
                                    <span class="${u.status == 'active' ? 'text-success' : 'text-danger'}">
                                        ${u.status}
                                    </span>
                                </td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/user/edit?id=${user.userId}" class="btn-icon" title="Edit">
    									<i class="fas fa-edit"></i>
									</a>
                                    <form action="${pageContext.request.contextPath}/user/deactivate" method="post" style="display:inline;">
    									<input type="hidden" name="userId" value="${user.userId}" />
    									<button type="submit" class="btn-icon" title="Deactivate"
        								onclick="return confirm('Are you sure you want to deactivate this user?');">
        									<i class="fas fa-user-slash" style="color: red;"></i>
    										</button>
									</form>

                                </td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="7" style="text-align: center;">No users found.</td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>
</div>

<jsp:include page="/Pages/Common/footer.jsp"/>

</body>
</html>

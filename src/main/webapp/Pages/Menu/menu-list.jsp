<%@ page import="java.util.List" %>
<%@ page import="com.javapos.model.Item" %>
<%@ page import="com.javapos.model.User" %>
<%@ page import="com.javapos.dao.ItemDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    User user = (User) session.getAttribute("loggedInUser");
    if (user == null || !"admin".equalsIgnoreCase(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/Pages/auth/login.jsp");
        return;
    }

    ItemDAO itemDAO = new ItemDAO();
    List<Item> items = itemDAO.getAllItems();

    request.setAttribute("currentPage", "menu-items");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Menu Items - Restaurant POS</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    
</head>
<body>
    <jsp:include page="/Pages/Common/header.jsp">
        <jsp:param name="currentPage" value="menu-items"/>
    </jsp:include>
    
    <div class="container">
        <div class="dashboard-header">
            <h1>Menu Items</h1>
            <div class="header-actions">
                <a href="${pageContext.request.contextPath}/menu-items/form" class="btn btn-primary">
                    <i class="fas fa-plus"></i> Add Menu Item
                </a>
            </div>
        </div>

        <div class="search-bar">
            <input type="text" id="searchInput" placeholder="Search menu items...">
            <button class="btn btn-primary" onclick="searchItems()">Search</button>
        </div>

        <div class="table-container">
            <table class="table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Category</th>
                        <th>Price</th>
                        <th>Stock</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${menuItems}" var="item">
                        <tr>
                            <td>${item.id}</td>
                            <td>${item.name}</td>
                            <td>${item.category}</td>
                            <td>$${item.price}</td>
                            <td>${item.stock}</td>
                            <td>
                                <span class="status-badge ${item.status eq 'active' ? 'active' : 'inactive'}">
                                    ${item.status}
                                </span>
                            </td>
                            <td>
                                <a href="${pageContext.request.contextPath}/menu-items/form?id=${item.id}" 
                                   class="btn-icon">
                                    <i class="fas fa-edit"></i>
                                </a>
                                <a href="#" onclick="deleteItem(${item.id})" class="btn-icon">
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
                <a href="?page=${currentPage - 1}" class="btn btn-secondary">Previous</a>
            </c:if>
            <span>Page ${currentPage} of ${totalPages}</span>
            <c:if test="${currentPage < totalPages}">
                <a href="?page=${currentPage + 1}" class="btn btn-secondary">Next</a>
            </c:if>
        </div>
    </div>

    <jsp:include page="/Pages/Common/footer.jsp"/>

<!-- need to change this  --> 

    <script>
        function searchItems() {
            const searchTerm = document.getElementById('searchInput').value;
            window.location.href = '?search=' + encodeURIComponent(searchTerm);
        }

        function deleteItem(itemId) {
            if (confirm('Are you sure you want to delete this menu item?')) {
                window.location.href = '?action=delete&id=' + itemId;
            }
        }
    </script>
</body>
</html> 
<%@ page import="java.util.List" %>
<%@ page import="com.javapos.model.Item" %>
<%@ page import="com.javapos.model.User" %>
<%@ page import="com.javapos.dao.ItemDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    // User role check (only admin or waiter allowed)
    User user = (User) session.getAttribute("user");
    if (user == null || (!"admin".equalsIgnoreCase(user.getRole()))) {
        response.sendRedirect(request.getContextPath() + "/Pages/auth/login.jsp");
        return;
    }

    ItemDAO itemDAO = new ItemDAO();
    String search = request.getParameter("search");
    String category = request.getParameter("category");

    List<Item> items;

    if ((search != null && !search.isEmpty()) || (category != null && !category.isEmpty())) {
        items = itemDAO.searchItems(search, category); // Implement this in your DAO
    } else {
        items = itemDAO.getAllItems();
    }

    request.setAttribute("menuItems", items);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Menu List - Resturant POS</title>
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
        <p class="text-muted">Browse, edit, or add items to the restaurant menu.</p>
        <br>
        <a href="${pageContext.request.contextPath}/Pages/Admin/admin-menu-add.jsp" class="btn">
            <i class="fas fa-plus"></i> Add New Item
        </a>
    </div>

    <form method="get" action="${pageContext.request.contextPath}/Pages/Admin/admin-menu.jsp" class="search-bar">
    <input type="text" name="search" placeholder="Item name..." value="${param.search != null ? param.search : ''}">
    <select name="category">
        <option value="">All</option>
        <option value="food" <c:if test="${param.category == 'food'}">selected</c:if>>Food</option>
        <option value="drink" <c:if test="${param.category == 'drink'}">selected</c:if>>Drink</option>
    </select>
    <button type="submit" class="btn">Filter</button>
    <a href="${pageContext.request.contextPath}/Pages/Admin/admin-menu.jsp" class="btn">Clear</a>
</form>



    <div class="table-container">
        <table class="table">
            <thead>
                <tr>
                    <th>Item Name</th>
                    <th>Category</th>
                    <th>Price ($)</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${not empty menuItems}">
                        <c:forEach var="item" items="${menuItems}">
                            <tr>
                                <td>${item.itemName}</td>
                                <td>${item.category}</td>
                                <td>${item.price}</td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/menu-items/form?id=${item.itemId}" class="btn-icon" title="Edit">
                                        <i class="fas fa-edit"></i>
                                    </a>
                                    <form action="${pageContext.request.contextPath}/menu-items/delete" method="post" style="display:inline;">
                                        <input type="hidden" name="id" value="${item.itemId}">
                                        <button type="submit" class="btn-icon" title="Delete"
    										onclick="return confirm('Are you sure you want to delete this item from the menu? This action cannot be undone.');">
    										<i class="fas fa-trash-alt" style="color: red;"></i>
										</button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="4" style="text-align: center;">No menu items found.</td>
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
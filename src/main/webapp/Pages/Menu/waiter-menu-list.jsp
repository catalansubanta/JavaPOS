<%@ page import="java.util.List" %>
<%@ page import="com.javapos.model.Item" %>
<%@ page import="com.javapos.model.User" %>
<%@ page import="com.javapos.dao.ItemDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    // Allow access only for waiters
    User user = (User) session.getAttribute("user");
    if (user == null || !"waiter".equalsIgnoreCase(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/Pages/auth/login.jsp");
        return;
    }

    ItemDAO itemDAO = new ItemDAO();

    String search = request.getParameter("search");
    List<Item> items;

    if (search != null && !search.trim().isEmpty()) {
        items = itemDAO.searchItemsByName(search.trim());
    } else {
        items = itemDAO.getAllItems();
    }

    request.setAttribute("menuItems", items);
    request.setAttribute("currentPage", "waiter-menu-items");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Waiter Menu - JavaPOS</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>

<jsp:include page="/Pages/Common/header.jsp">
    <jsp:param name="currentPage" value="waiter-menu-items"/>
</jsp:include>

<jsp:include page="/Pages/Common/navigation-bar.jsp"/>

<div class="container">
    <div class="dashboard-header">
        <h1>Menu Items</h1>
        <p class="text-muted">Browse and add items to the cart.</p>
    </div>

    <form method="get" action="waiter-menu-list.jsp" class="search-bar">
        <input type="text" name="search" placeholder="Search menu items..." value="${param.search != null ? param.search : ''}">
        <button type="submit" class="btn">Search</button>
        <a href="waiter-menu-list.jsp" class="btn">Clear</a>
    </form>

    <div class="items-grid">
        <c:choose>
            <c:when test="${not empty menuItems}">
                <c:forEach var="item" items="${menuItems}">
                    <div class="item-card">
                        <h3>${item.itemName}</h3>
                        <p><strong>Category:</strong> ${item.category}</p>
                        <p><strong>Price:</strong> $${item.price}</p>

                        <!-- Add to cart form -->
                        <form method="post" action="${pageContext.request.contextPath}/cart/add">
                            <input type="hidden" name="itemId" value="${item.itemId}" />
                            <label for="qty_${item.itemId}">Qty:</label>
                            <input type="number" id="qty_${item.itemId}" name="quantity" value="1" min="1" max="100" required />
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-cart-plus"></i> Add to Cart
                            </button>
                        </form>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <p>No menu items found.</p>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<jsp:include page="/Pages/Common/footer.jsp"/>

<style>
    /* simple grid for item cards */
    .items-grid {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
        gap: 20px;
    }
    .item-card {
        border: 1px solid #ccc;
        padding: 15px;
        border-radius: 6px;
        background: #f9f9f9;
    }
    .item-card h3 {
        margin-top: 0;
    }
    .item-card form {
        margin-top: 10px;
    }
    .item-card input[type="number"] {
        width: 60px;
        margin-right: 10px;
    }
</style>

</body>
</html>

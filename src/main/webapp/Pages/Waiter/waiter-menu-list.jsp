<%@ page import="java.util.List" %>
<%@ page import="com.javapos.model.Item" %>
<%@ page import="com.javapos.model.User" %>
<%@ page import="com.javapos.dao.ItemDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
   
    User user = (User) session.getAttribute("loggedInUser");
    if (user == null || !"waiter".equalsIgnoreCase(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/Pages/auth/login.jsp");
        return;
    }

    String search = request.getParameter("search");
    String category = request.getParameter("category");

    ItemDAO itemDAO = new ItemDAO();
    List<Item> items = itemDAO.searchItems(search, category);

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


<div class="container">
    <h1>Menu Items</h1>
    <p class="text-muted">Browse and add items to the cart.</p>
    
    		<a href="${pageContext.request.contextPath}/cart" class="btn btn-primary" style="float:right; margin-bottom: 20px;">
    		🛒 View Cart
		</a>

    <!-- Search & Category Filter -->
    <form method="get" action="${pageContext.request.contextPath}/Pages/Waiter/waiter-menu-list.jsp" class="search-bar">
        <input type="text" name="search" placeholder="Item name..." value="${param.search != null ? param.search : ''}">
        <select name="category">
            <option value="">All</option>
            <option value="food" <c:if test="${param.category == 'food'}">selected</c:if>>Food</option>
            <option value="drink" <c:if test="${param.category == 'drink'}">selected</c:if>>Drink</option>
        </select>
        <button type="submit" class="btn">Filter</button>
        <a href="${pageContext.request.contextPath}/Pages/Waiter/waiter-menu-list.jsp" class="btn">Clear</a>
    </form>

    <!-- Menu Items Grid -->
    <div class="items-grid">
        <c:choose>
            <c:when test="${not empty menuItems}">
                <c:forEach var="item" items="${menuItems}">
                    <div class="item-card">
                        <h3>${item.itemName}</h3>
                        <p><strong>Category:</strong> ${item.category}</p>
                        <p><strong>Price:</strong> Rs. ${item.price}</p>

                        <!-- Add to Cart -->
                        <form class="add-to-cart-form" method="post" action="${pageContext.request.contextPath}/cart">
    <input type="hidden" name="action" value="add" />
    <input type="hidden" name="itemId" value="${item.itemId}" />
    <input type="hidden" name="userId" value="${sessionScope.loggedInUser.userId}" />
    <input type="hidden" name="tableId" value="0" />
    <input type="hidden" name="orderType" value="takeaway" />
    <label for="qty_${item.itemId}">Qty:</label>
    <input type="number" id="qty_${item.itemId}" name="quantity" value="1" min="1" max="100" required />
    <button type="submit" class="btn btn-primary">
        <i class="fas fa-cart-plus"></i> Add to Cart
    </button>
</form>

                    </div>
                </c:forEach>
            </c:when>
        </c:choose>
    </div>
</div>

<jsp:include page="/Pages/Common/footer.jsp"/>
</body>
</html>

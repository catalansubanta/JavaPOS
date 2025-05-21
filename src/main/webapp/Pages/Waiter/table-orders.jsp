<%@ page import="java.util.List" %>
<%@ page import="com.javapos.model.User" %>
<%@ page import="com.javapos.model.Item" %>
<%@ page import="com.javapos.model.Cart" %>
<%@ page import="com.javapos.dao.ItemDAO" %>
<%@ page import="com.javapos.dao.CartDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    User user = (User) session.getAttribute("loggedInUser");
    if (user == null || !"waiter".equals(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/Pages/auth/login.jsp");
        return;
    }

    int tableId = 0;
    try {
        tableId = Integer.parseInt(request.getParameter("tableId"));
    } catch (NumberFormatException e) {
        request.setAttribute("errorType", "404");
        request.setAttribute("error", "Invalid table ID");
        request.getRequestDispatcher("/Pages/Common/error.jsp").forward(request, response);
        return;
    }

    String search = request.getParameter("search") != null ? request.getParameter("search") : "";

    ItemDAO itemDAO = new ItemDAO();
    List<Item> items = search.isEmpty() ? itemDAO.getAllItems() : itemDAO.searchItems(search, null);

    CartDAO cartDAO = new CartDAO();
    List<Cart> cartItems = cartDAO.getCartByUserId(user.getUserId());

    request.setAttribute("items", items);
    request.setAttribute("cartItems", cartItems);
    request.setAttribute("tableId", tableId);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Order for Table <%= tableId %></title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<jsp:include page="/Pages/Common/header.jsp" />

<div class="container">
<c:if test="${not empty sessionScope.cartMessage}">
        <div class="alert alert-success">${sessionScope.cartMessage}</div>
        <%
            session.removeAttribute("cartMessage");
        %>
    </c:if>
    <div class="dashboard-header">
        <h1>New Order - Table <%= tableId %></h1>
        <form method="get" action="${pageContext.request.contextPath}/Pages/Waiter/table-orders.jsp" class="search-bar">
    <input type="hidden" name="tableId" value="${param.tableId}" />
    
    <input type="text" name="search" placeholder="Item name..." value="${param.search != null ? param.search : ''}" />


    <button type="submit" class="btn">Filter</button>
    <a href="${pageContext.request.contextPath}/Pages/Waiter/table-orders.jsp?tableId=${param.tableId}" class="btn">Clear</a>
</form>

    </div>

    <div class="menu-grid">
        <c:forEach var="item" items="${items}">
            <div class="menu-card">
                <h3>${item.itemName}</h3>
                <p>Rs ${item.price}</p>
                <form method="post" action="${pageContext.request.contextPath}/cart">
                    <input type="hidden" name="action" value="add">
                    <input type="hidden" name="userId" value="${sessionScope.loggedInUser.userId}">
                    <input type="hidden" name="itemId" value="${item.itemId}">
                    <input type="hidden" name="tableId" value="${tableId}">
                    <input type="number" name="quantity" value="1" min="1" required>
                    <button type="submit">Add to Cart</button>
                </form>
            </div>
        </c:forEach>
    </div>

    <div class="cart-section">
        <h2>Cart</h2>
        <c:if test="${empty cartItems}">
            <p>Cart is empty.</p>
        </c:if>
        <c:if test="${not empty cartItems}">
            <table>
                <tr>
                    <th>Item</th>
                    <th>Qty</th>
                    <th>Price</th>
                </tr>
                <c:forEach var="cart" items="${cartItems}">
                    <tr>
                        <td>${cart.item.itemName}</td>
                        <td>${cart.quantity}</td>
                        <td>Rs ${cart.item.price * cart.quantity}</td>
                        <td>
            				<form method="post" action="${pageContext.request.contextPath}/cart" style="display:inline;">
                				<input type="hidden" name="action" value="remove" />
                				<input type="hidden" name="cartId" value="${cart.cartId}" />
                				<input type="hidden" name="tableId" value="${tableId}" />
                				<button type="submit" class="btn btn-danger btn-sm">Remove</button>

            				</form>
        				</td>
                    </tr>
                </c:forEach>
            </table>

            <form method="post" action="${pageContext.request.contextPath}/cart">
                <input type="hidden" name="action" value="submit">
                <input type="hidden" name="userId" value="${sessionScope.loggedInUser.userId}">
                <input type="hidden" name="orderType" value="dinein">
                <input type="hidden" name="tableId" value="${tableId}">
                <button type="submit" class="btn btn-success">Confirm Order</button>
            </form>
        </c:if>
    </div>
</div>

<jsp:include page="/Pages/Common/footer.jsp" />
</body>
</html>

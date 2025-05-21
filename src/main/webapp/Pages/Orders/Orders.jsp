<%@ page import="java.util.List" %>
<%@ page import="com.javapos.model.Cart" %>
<%@ page import="com.javapos.model.Item" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    com.javapos.model.User user = (com.javapos.model.User) session.getAttribute("loggedInUser");
    if (user == null || !"waiter".equalsIgnoreCase(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/Pages/auth/login.jsp");
        return;
    }

    List<Cart> cartItems = (List<Cart>) request.getAttribute("cartItems");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Confirm Order - JavaPOS</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<jsp:include page="/Pages/Common/header.jsp"/>

<div class="container">
    <h1>Confirm Your Order</h1>

    <c:if test="${not empty cartItems}">
        <table>
            <thead>
                <tr>
                    <th>Item</th>
                    <th>Category</th>
                    <th>Price</th>
                    <th>Quantity</th>
                    <th>Total</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="cart" items="${cartItems}">
                    <tr>
                        <td>${cart.item.itemName}</td>
                        <td>${cart.item.category}</td>
                        <td>$${cart.item.price}</td>
                        <td>${cart.quantity}</td>
                        <td>$${cart.item.price * cart.quantity}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <form method="post" action="${pageContext.request.contextPath}/waiter/cart">
            <input type="hidden" name="action" value="submitOrder" />
            <button type="submit">Submit Order</button>
        </form>
    </c:if>

    <c:if test="${empty cartItems}">
        <p>Your cart is empty.</p>
    </c:if>
</div>

<jsp:include page="/Pages/Common/footer.jsp"/>
</body>
</html>

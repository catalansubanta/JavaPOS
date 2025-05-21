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
    <title>Waiter Cart - JavaPOS</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<jsp:include page="/Pages/Common/header.jsp"/>

<div class="container">
    <h1>Your Cart</h1>

    <c:if test="${not empty cartItems}">
        <table>
            <thead>
                <tr>
                    <th>Item</th>
                    <th>Category</th>
                    <th>Price</th>
                    <th>Quantity</th>
                    <th>Total</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="cart" items="${cartItems}">
                    <tr>
                        <td>${cart.item.itemName}</td>
                        <td>${cart.item.category}</td>
                        <td>Rs. ${cart.item.price}</td>
                        <td>
                            <form method="post" action="${pageContext.request.contextPath}/cart" style="display:inline;">
                                <input type="hidden" name="action" value="update"/>
                                <input type="hidden" name="cartId" value="${cart.cartId}" />
                                <input type="number" name="quantity" value="${cart.quantity}" min="1" max="100" required/>
                                <button type="submit">Update</button>
                            </form>
                        </td>
                        <td>Rs. ${cart.item.price * cart.quantity}</td>
                        <td>
                            <form method="post" action="${pageContext.request.contextPath}/cart" style="display:inline;">
                                <input type="hidden" name="action" value="remove"/>
                                <input type="hidden" name="cartId" value="${cart.cartId}" />
                                <button type="submit">Remove</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <form method="post" action="${pageContext.request.contextPath}/cart">
    			<input type="hidden" name="action" value="submit" />
    				<input type="hidden" name="userId" value="${sessionScope.loggedInUser.userId}" />
    				<input type="hidden" name="orderType" value="takeaway" />
    				<button type="submit">Proceed to Confirm</button>
			</form>



        <form method="post" action="${pageContext.request.contextPath}/cart" style="margin-top:20px;">
            <input type="hidden" name="action" value="clear" />
            <button type="submit">Clear Cart</button>
        </form>
    </c:if>

    <c:if test="${empty cartItems}">
        <p>Your cart is empty.</p>
    </c:if>
</div>

<jsp:include page="/Pages/Common/footer.jsp"/>
</body>
</html>

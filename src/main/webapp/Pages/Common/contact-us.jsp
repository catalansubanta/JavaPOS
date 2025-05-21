<%@ page import="javax.servlet.http.HttpServletRequest" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    String messageSent = null;
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        // Here you would normally process/send the message.
        // But for now, just set the confirmation flag.
        messageSent = "Message sent, wait for the response.";
        request.setAttribute("messageSent", messageSent);
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Contact Us</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .contact-container {
            max-width: 700px;
            margin: 0 auto;
        }
        .contact-form {
            margin-bottom: 20px;
        }
        .confirmation {
            color: green;
            font-weight: bold;
            margin-bottom: 15px;
        }
        iframe {
            width: 100%;
            height: 400px;
            border: 0;
        }
    </style>
</head>
<body>
<jsp:include page="/Pages/Common/header.jsp" />

<div class="contact-container">
    <h1>Contact Us</h1>

    <c:if test="${not empty messageSent}">
        <div class="confirmation">${messageSent}</div>
    </c:if>

    <form method="post" class="contact-form">
        <label for="name">Name:</label><br/>
        <input type="text" id="name" name="name" required><br/><br/>

        <label for="email">Email:</label><br/>
        <input type="email" id="email" name="email" required><br/><br/>

        <label for="message">Message:</label><br/>
        <textarea id="message" name="message" rows="5" required></textarea><br/><br/>

        <button type="submit">Send Message</button>
    </form>

    <h2>Our Location</h2>
    <iframe 
        src="https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d5285.182855523165!2d83.99735688839246!3d28.207979884921276!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x399595f0fdf0a767%3A0xc0aac0ce9a25e75f!2sGrandline%20Juice%20Caf%C3%A9!5e0!3m2!1sen!2snp!4v1747534229046!5m2!1sen!2snp" 
        allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade">
    </iframe>
</div>

<jsp:include page="/Pages/Common/footer.jsp" />
</body>
</html>

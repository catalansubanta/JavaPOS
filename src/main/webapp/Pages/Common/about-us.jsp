<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>About Us - Grandline POS</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .container {
            max-width: 900px;
            margin: 40px auto;
            text-align: center;
        }
        .team-grid {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 30px;
            margin-top: 30px;
        }
        .team-member {
            width: 180px;
            border: 1px solid #ddd;
            border-radius: 10px;
            padding: 15px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
            background: #fff;
        }
        .team-member img {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            object-fit: cover;
            margin-bottom: 10px;
            border: 3px solid #007BFF;
        }
        .team-member h3 {
            margin: 8px 0 4px;
            font-size: 1.1em;
            color: #333;
        }
        .team-member p {
            font-size: 0.9em;
            color: #666;
            margin: 0;
        }
    </style>
</head>
<body>
<jsp:include page="/Pages/Common/header.jsp" />

<div class="container">
    <!-- Add the Grandline image/logo here -->
    <img src="${pageContext.request.contextPath}/images/grandline-logo.jpg" 
         alt="Grandline POS Logo" 
         style="max-width: 300px; display: block; margin: 0 auto 20px; border-radius: 10px;">

    <h1>About Us</h1>
    <p class="description">
        Welcome to the Grandline Restaurant POS System — a comprehensive solution designed to streamline and simplify your restaurant management.
        This system is proudly managed and developed by our dedicated team members, passionate about delivering quality software:
    </p>
    
    <div class="team-grid">
        <div class="team-member">
            <img src="${pageContext.request.contextPath}/images/team/subanta.jpg" alt="Subanta Poudel">
            <h3>Subanta Poudel</h3>
            <p>Project Manager</p>
        </div>
        <div class="team-member">
            <img src="${pageContext.request.contextPath}/images/team/saksham.jpg" alt="Saksham Thakuri">
            <h3>Saksham Thakuri</h3>
            <p>Lead Developer</p>
        </div>
        <div class="team-member">
            <img src="${pageContext.request.contextPath}/images/team/shreeram.jpg" alt="Shree Ram Shrestha">
            <h3>Shree Ram Shrestha</h3>
            <p>Backend Developer</p>
        </div>
        <div class="team-member">
            <img src="${pageContext.request.contextPath}/images/team/ritik.jpg" alt="Ritik Kunwar">
            <h3>Ritik Kunwar</h3>
            <p>Frontend Developer</p>
        </div>
        <div class="team-member">
            <img src="${pageContext.request.contextPath}/images/team/parshant.jpg" alt="Parshant GC">
            <h3>Parshant GC</h3>
            <p>QA Specialist</p>
        </div>
    </div>
</div>

<jsp:include page="/Pages/Common/footer.jsp" />
</body>
</html>

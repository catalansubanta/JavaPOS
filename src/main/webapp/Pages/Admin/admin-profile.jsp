<%@ page import="com.javapos.model.User" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"admin".equalsIgnoreCase(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/Pages/auth/login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Under Construction</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

</head>
<body>

<% request.setAttribute("currentPage", "Profile"); %>
<jsp:include page="/Pages/Common/header.jsp" />

<div class="profile-container">
    <div class="profile-card">
        <div class="profile-header">
            <h2>Profile Information</h2>
            <p>Manage your account details</p>
        </div>

        <form id="profileForm" action="<%= request.getContextPath() %>/profile" method="post">
            <div class="profile-info">
                <div class="info-group">
                    <label for="fullName">Full Name</label>
                    <input type="text" id="fullName" name="fullName" value="<%= user.getFullName() %>" disabled>
                </div>

                <div class="info-group">
                    <label for="username">Username</label>
                    <input type="text" id="username" name="username" value="<%= user.getUsername() %>" disabled>
                </div>

                <div class="info-group">
                    <label for="phone">Phone Number</label>
                    <input type="tel" id="phone" name="phone" value="<%= user.getPhone() %>" disabled>
                </div>
            </div>

            <div class="button-group">
                <button type="button" class="btn btn-warning" onclick="enableEditing()">Edit Information</button>
                <button type="button" class="btn btn-secondary" onclick="showPasswordModal()">Change Password</button>
                <button type="submit" class="btn btn-primary" style="display: none;" id="saveBtn">Save Changes</button>
                <button type="button" class="btn btn-secondary" style="display: none;" onclick="cancelEditing()" id="cancelBtn">Cancel</button>
            </div>
        </form>
    </div>
</div>

<!-- Password Change Modal -->
<div id="passwordModal" class="password-modal">
    <div class="password-modal-content">
        <span class="close" onclick="closePasswordModal()">&times;</span>
        <h3>Change Password</h3>
        <form id="passwordForm" action="<%= request.getContextPath() %>/profile/password" method="post">
            <div class="info-group">
                <label for="currentPassword">Current Password</label>
                <input type="password" id="currentPassword" name="currentPassword" required>
            </div>
            <div class="info-group">
                <label for="newPassword">New Password</label>
                <input type="password" id="newPassword" name="newPassword" required>
            </div>
            <div class="info-group">
                <label for="confirmPassword">Confirm New Password</label>
                <input type="password" id="confirmPassword" name="confirmPassword" required>
            </div>
            <div class="button-group">
                <button type="button" class="btn btn-secondary" onclick="closePasswordModal()">Cancel</button>
                <button type="submit" class="btn btn-primary">Update Password</button>
            </div>
        </form>
    </div>
</div>

<script>
function enableEditing() {
    document.getElementById('fullName').disabled = false;
    document.getElementById('phone').disabled = false;
    document.getElementById('saveBtn').style.display = 'inline-block';
    document.getElementById('cancelBtn').style.display = 'inline-block';
    document.querySelector('.btn-warning').style.display = 'none';
}

function cancelEditing() {
    document.getElementById('fullName').disabled = true;
    document.getElementById('phone').disabled = true;
    document.getElementById('saveBtn').style.display = 'none';
    document.getElementById('cancelBtn').style.display = 'none';
    document.querySelector('.btn-warning').style.display = 'inline-block';
    
    // Reset form values
    document.getElementById('fullName').value = '<%= user.getFullName() %>';
    document.getElementById('phone').value = '<%= user.getPhone() %>';
}

function showPasswordModal() {
    document.getElementById('passwordModal').style.display = 'block';
}

function closePasswordModal() {
    document.getElementById('passwordModal').style.display = 'none';
    document.getElementById('passwordForm').reset();
}

// Close modal when clicking outside
window.onclick = function(event) {
    if (event.target == document.getElementById('passwordModal')) {
        closePasswordModal();
    }
}

// Password validation
document.getElementById('passwordForm').onsubmit = function(e) {
    e.preventDefault();
    const newPassword = document.getElementById('newPassword').value;
    const confirmPassword = document.getElementById('confirmPassword').value;
    
    if (newPassword !== confirmPassword) {
        alert('New passwords do not match!');
        return;
    }
    
    this.submit();
}
</script>

<jsp:include page="/Pages/Common/footer.jsp" />
</body>
</html> 
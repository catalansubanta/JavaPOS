package com.javapos.controller;

import com.javapos.dao.UserDAO;
import com.javapos.model.User;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import com.javapos.utils.PasswordUtils;

@WebServlet("/user/add")
public class AddUserController extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    String username = request.getParameter("username");
	    String password = request.getParameter("password");
	    String fullName = request.getParameter("fullName");
	    String email = request.getParameter("email");
	    String phone = request.getParameter("phone");
	    String role = request.getParameter("role");
	    String status = request.getParameter("status");
	    
	    if (status == null || status.isEmpty()) {
	        status = "active"; 
	    }
	    
	    UserDAO userDAO = new UserDAO();

        
        if (userDAO.isUsernameExists(username)) {
            request.setAttribute("message", "Username already exists.");
            request.setAttribute("messageType", "error");
            request.getRequestDispatcher("/Pages/Admin/admin-add-user.jsp").forward(request, response);
            return;
        }

        if (userDAO.isEmailExists(email)) {
            request.setAttribute("message", "Email already exists.");
            request.setAttribute("messageType", "error");
            request.getRequestDispatcher("/Pages/Admin/admin-add-user.jsp").forward(request, response);
            return;
        }

        if (userDAO.isPhoneExists(phone)) {
            request.setAttribute("message", "Phone number already exists.");
            request.setAttribute("messageType", "error");
            request.getRequestDispatcher("/Pages/Admin/admin-add-user.jsp").forward(request, response);
            return;
        }
	    
	    String hashedPassword = PasswordUtils.hash(password);

	    User user = new User(username, password, fullName, email, phone, role, status);
	    

	    boolean success = userDAO.registerUser(user);

	    if (success) {
	        request.setAttribute("message", "User added successfully.");
	        request.setAttribute("messageType", "success");
	    } else {
	        request.setAttribute("message", "Failed to add user.");
	        request.setAttribute("messageType", "error");
	    }

	    request.getRequestDispatcher("/Pages/Admin/admin-add-user.jsp").forward(request, response);
	}
}

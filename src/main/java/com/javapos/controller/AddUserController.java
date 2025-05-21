package com.javapos.controller;

import com.javapos.dao.UserDAO;
import com.javapos.model.User;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

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
	        status = "active"; // default status
	    }

	    User user = new User(username, password, fullName, email, phone, role, status);
	    UserDAO userDAO = new UserDAO();

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

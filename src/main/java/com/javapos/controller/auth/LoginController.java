package com.javapos.controller.auth;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.javapos.dao.UserDAO;
import com.javapos.model.User;

@WebServlet("/login")
public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UserDAO userDAO;

	public void init() {
		userDAO = new UserDAO();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String username = request.getParameter("username");
		String password = request.getParameter("password");

		System.out.println("Login attempt - Username: " + username);

		// Validate input
		if (username == null || username.trim().isEmpty() || 
			password == null || password.trim().isEmpty()) {
			request.setAttribute("error", "Username and password are required");
			request.getRequestDispatcher("/Pages/auth/login.jsp").forward(request, response);
			return;
		}

		User user = userDAO.validateUser(username, password);
		System.out.println("User validation result: " + (user != null ? "Success" : "Failed"));

		if (user != null) {
				HttpSession session = request.getSession();
			session.setAttribute("user", user);
			session.setAttribute("role", user.getRole());
			System.out.println("User role: " + user.getRole());

			String redirectPath = "";
			switch (user.getRole().toLowerCase()) {
					case "admin":
					redirectPath = "/Pages/Admin/admin-home.jsp";
						break;
					case "cashier":
					redirectPath = "/Pages/Dashboard/cashier-dashboard.jsp";
						break;
					case "waiter":
					redirectPath = "/Pages/Dashboard/waiter-dashboard.jsp";
						break;
					default:
					request.setAttribute("error", "Invalid user role");
					request.getRequestDispatcher("/Pages/auth/login.jsp").forward(request, response);
					return;
				}

			System.out.println("Redirecting to: " + redirectPath);
			String contextPath = request.getContextPath();
			System.out.println("Context path: " + contextPath);
			response.sendRedirect(contextPath + redirectPath);
			return;
			} else {
			request.setAttribute("error", "Invalid username or password");
			request.setAttribute("username", username);
			request.getRequestDispatcher("/Pages/auth/login.jsp").forward(request, response);
		}
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		// If user is already logged in, redirect to appropriate page
		HttpSession session = request.getSession(false);
		if (session != null && session.getAttribute("user") != null) {
			String role = (String) session.getAttribute("role");
			String redirectPath = "";
			
			switch (role.toLowerCase()) {
				case "admin":
					redirectPath = "/Pages/Admin/home.jsp";
					break;
				case "cashier":
					redirectPath = "/Pages/Dashboard/cashier-dashboard.jsp";
					break;
				case "waiter":
					redirectPath = "/Pages/Dashboard/waiter-dashboard.jsp";
					break;
				default:
				request.getRequestDispatcher("/Pages/auth/login.jsp").forward(request, response);
					return;
			}
			
			response.sendRedirect(request.getContextPath() + redirectPath);
		} else {
			request.getRequestDispatcher("/Pages/auth/login.jsp").forward(request, response);
		}
	}
}

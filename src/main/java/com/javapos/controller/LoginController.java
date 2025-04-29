package com.javapos.controller;

import com.javapos.dao.UserDAO;
import com.javapos.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/login")
public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String username = request.getParameter("username");
		String password = request.getParameter("password");

		UserDAO dao = new UserDAO();

		try {
			if (dao.checkLogin(username, password)) {
				//Fetch full user info
				User user = dao.getUser(username);

				//Create session and store user
				HttpSession session = request.getSession();
				session.setAttribute("userWithSession", user);
				session.setMaxInactiveInterval(30 * 60); // 30 min timeout

				//Redirect to role-based dashboard
				switch (user.getRole()) {
					case "admin":
						response.sendRedirect(request.getContextPath() + "/Pages/HomePage.jsp");
						break;
					case "cashier":
						response.sendRedirect(request.getContextPath() + "/Pages/Dashboard/dashboard.jsp");
						break;
					case "waiter":
						response.sendRedirect(request.getContextPath() + "/Pages/Dashboard/dashboard.jsp");
						break;
					default:
						response.sendRedirect(request.getContextPath() + "/Pages/HomePage.jsp");
						break;
				}

			} else {
				//Invalid credentials
				request.setAttribute("errorMessage", "Invalid username or password");
				request.getRequestDispatcher("/Pages/auth/login.jsp").forward(request, response);
			}
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("errorMessage", "Login failed due to an internal error.");
			request.getRequestDispatcher("/Pages/auth/login.jsp").forward(request, response);
		}
	}
}

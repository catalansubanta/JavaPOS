package com.javapos.filter;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.*;
import java.io.IOException;

@WebFilter(urlPatterns = { "/Pages/*" })  // Applies to all pages inside /Pages/
public class AuthenticationFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        System.out.println("AuthenticationFilter initialized");
    }

    @Override
    public void destroy() {
        System.out.println("AuthenticationFilter destroyed");
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        String uri = req.getRequestURI();
        HttpSession session = req.getSession(false);
        Object user = (session != null) ? session.getAttribute("userWithSession") : null;
        boolean isLoggedIn = user != null;

        // Allow unauthenticated access to auth pages
        boolean isAuthPage = uri.contains("auth/login.jsp") || uri.contains("auth/register.jsp")
                || uri.contains("/login") || uri.contains("/register");

        if (isAuthPage) {
            if (isLoggedIn) {
                session.setAttribute("alreadyLoggedInMessage", "You're already logged in!");
                res.sendRedirect(req.getContextPath() + "/Pages/Dashboard/dashboard.jsp");
            } else {
                chain.doFilter(request, response); // Allow login/register access
            }
            return;
        }

        // For all other protected pages
        if (isLoggedIn) {
            chain.doFilter(request, response);
        } else {
            res.sendRedirect(req.getContextPath() + "/Pages/auth/login.jsp");
        }
    }
}

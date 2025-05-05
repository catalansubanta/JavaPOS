package com.javapos.filter;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebFilter("/*")
public class AccessFilter implements Filter {
    
    private static final String[] PUBLIC_PATHS = {
        "/login",
        "/register",
        "/error",
        "/assets/"
    };

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);
        
        String requestPath = httpRequest.getRequestURI().substring(httpRequest.getContextPath().length());
        
        // Check if the path is public
        boolean isPublicPath = false;
        for (String path : PUBLIC_PATHS) {
            if (requestPath.startsWith(path)) {
                isPublicPath = true;
                break;
            }
        }
        
        // Allow access to public paths
        if (isPublicPath) {
            chain.doFilter(request, response);
            return;
        }
        
        // Check if user is logged in
        if (session == null || session.getAttribute("userID") == null) {
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login");
            return;
        }
        
        // Check role-based access
        String userType = (String) session.getAttribute("userType");
        if (userType != null) {
            if (requestPath.startsWith("/admin/") && !"admin".equals(userType)) {
                httpResponse.sendRedirect(httpRequest.getContextPath() + "/error?message=Unauthorized access");
                return;
            }
            if (requestPath.startsWith("/cashier/") && !"cashier".equals(userType)) {
                httpResponse.sendRedirect(httpRequest.getContextPath() + "/error?message=Unauthorized access");
                return;
            }
            if (requestPath.startsWith("/waiter/") && !"waiter".equals(userType)) {
                httpResponse.sendRedirect(httpRequest.getContextPath() + "/error?message=Unauthorized access");
                return;
            }
        }
        
        chain.doFilter(request, response);
    }

    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialization code if needed
    }

    public void destroy() {
        // Cleanup code if needed
    }
} 
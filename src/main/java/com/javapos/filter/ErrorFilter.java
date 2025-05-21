package com.javapos.filter;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;

@WebFilter("/*")
public class ErrorFilter implements Filter {

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        try {
            chain.doFilter(request, response);
        } catch (Exception e) {
            request.setAttribute("errorType", "500");
            request.setAttribute("error", "An internal server error occurred.");
            request.setAttribute("errorDetails", e.getMessage());
            request.getRequestDispatcher("/Pages/Common/error.jsp").forward(request, response);
        }
    }

    public void init(FilterConfig filterConfig) throws ServletException {}
    public void destroy() {}
}

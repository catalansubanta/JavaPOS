package com.javapos.controller;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import java.io.IOException;

@WebServlet("/error")
public class ErrorHandler extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        handleError(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        handleError(request, response);
    }

    private void handleError(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Get error attributes
        Integer statusCode = (Integer) request.getAttribute("javax.servlet.error.status_code");
        String errorMessage = (String) request.getAttribute("javax.servlet.error.message");
        String requestUri = (String) request.getAttribute("javax.servlet.error.request_uri");
        Throwable throwable = (Throwable) request.getAttribute("javax.servlet.error.exception");

        // Set error type based on status code
        String errorType = "general";
        if (statusCode != null) {
            switch (statusCode) {
                case 404:
                    errorType = "404";
                    break;
                case 403:
                    errorType = "403";
                    break;
                case 500:
                    errorType = "500";
                    break;
            }
        }

        // Set error details
        StringBuilder errorDetails = new StringBuilder();
        if (throwable != null) {
            errorDetails.append("Exception: ").append(throwable.getClass().getName()).append("\n");
            errorDetails.append("Message: ").append(throwable.getMessage()).append("\n");
            for (StackTraceElement element : throwable.getStackTrace()) {
                errorDetails.append(element.toString()).append("\n");
            }
        }

        // Set attributes for the error page
        request.setAttribute("errorType", errorType);
        request.setAttribute("error", errorMessage);
        request.setAttribute("errorDetails", errorDetails.toString());
        request.setAttribute("requestUri", requestUri);

        // Forward to error page
        RequestDispatcher dispatcher = request.getRequestDispatcher("/Pages/Common/error.jsp");
        dispatcher.forward(request, response);
    }
} 
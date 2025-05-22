package com.tourism.servlet;

import com.tourism.model.User;
import com.tourism.service.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;


public class LoginServlet extends HttpServlet {
    private UserService userService;
    
    @Override
    public void init() {
        userService = new UserService();
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Get parameters from request
        String email = request.getParameter("username"); // Using username field from form
        String password = request.getParameter("password");
        
        // Attempt to login
        User user = userService.loginUser(email, password);
        
        if (user != null) {
            // Login successful
            // Make sure we have the complete user data
            user = userService.getUserByEmail(email);
            
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            
            // Redirect to home page
            response.sendRedirect("Home.jsp");
        } else {
            // Login failed
            request.setAttribute("errorMessage", "Invalid email or password");
            request.getRequestDispatcher("Login.jsp").forward(request, response);
        }
    }
}

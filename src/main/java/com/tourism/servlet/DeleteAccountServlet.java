package com.tourism.servlet;

import com.tourism.model.User;
import com.tourism.service.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;


public class DeleteAccountServlet extends HttpServlet {
    private UserService userService;
    
    @Override
    public void init() {
        userService = new UserService();
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Get the current user from session
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");
        
        if (currentUser == null) {
            response.sendRedirect("Login.jsp");
            return;
        }
        
        // Delete the user
        boolean success = userService.deleteUser(currentUser.getEmail());
        
        // Invalidate the session
        session.invalidate();
        
        // Redirect to login page after invalidating session
        // Messages set via request.setAttribute will not be available on Login.jsp after a redirect.
        // The redirection itself indicates the process is complete.
        response.sendRedirect("Login.jsp");
    }
}
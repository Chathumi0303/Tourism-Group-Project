package com.tourism.servlet;

import com.tourism.model.User;
import com.tourism.service.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;

public class UpdateProfileServlet extends HttpServlet {
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
        
        // Get updated information from form
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String phone = request.getParameter("phone");
        String dob = request.getParameter("dob");
        String address = request.getParameter("address");
        String travelPreference = request.getParameter("travelPreference");
        
        // Server-side validation
        boolean isValid = true;
        String errorMessage = "";
        
        // Validate first name
        if (firstName == null || firstName.trim().isEmpty()) {
            isValid = false;
            errorMessage = "First name is required";
        } else if (firstName.trim().length() < 2) {
            isValid = false;
            errorMessage = "First name must be at least 2 characters";
        } else if (!firstName.matches("[A-Za-z\\s]+")) {
            isValid = false;
            errorMessage = "First name must contain only letters";
        }
        
        // Validate last name
        if (isValid && (lastName == null || lastName.trim().isEmpty())) {
            isValid = false;
            errorMessage = "Last name is required";
        } else if (isValid && lastName.trim().length() < 2) {
            isValid = false;
            errorMessage = "Last name must be at least 2 characters";
        } else if (isValid && !lastName.matches("[A-Za-z\\s]+")) {
            isValid = false;
            errorMessage = "Last name must contain only letters";
        }
        
        // Validate phone (if provided)
        if (isValid && phone != null && !phone.trim().isEmpty()) {
            if (!phone.matches("^\\+?[0-9]{10,15}$")) {
                isValid = false;
                errorMessage = "Please enter a valid phone number (10-15 digits)";
            }
        }
        
        // If validation fails, return to profile page with error
        if (!isValid) {
            request.setAttribute("errorMessage", errorMessage);
            request.getRequestDispatcher("Profile.jsp").forward(request, response);
            return;
        }
        
        // Update user object
        currentUser.setFirstName(firstName.trim());
        currentUser.setLastName(lastName.trim());
        currentUser.setPhone(phone != null ? phone.trim() : "");
        currentUser.setDob(dob != null && !dob.isEmpty() ? dob : null);
        currentUser.setAddress(address != null ? address.trim() : null);
        currentUser.setTravelPreference(travelPreference);
        
        // Update user in file
        boolean success = userService.updateUser(currentUser);
        
        if (success) {
            // Update session with updated user
            session.setAttribute("user", currentUser);
            
            // Add success message
            request.setAttribute("successMessage", "Profile updated successfully");
        } else {
            // Add error message
            request.setAttribute("errorMessage", "Failed to update profile");
        }
        
        // Forward back to profile page
        request.getRequestDispatcher("Profile.jsp").forward(request, response);
    }
}

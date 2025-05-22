package com.tourism.servlet;

import com.tourism.model.User;
import com.tourism.service.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.regex.Pattern;

public class RegisterServlet extends HttpServlet {
    private UserService userService;

    // Validation patterns
    private static final Pattern NAME_PATTERN = Pattern.compile("^[A-Za-z ]{2,}$");
    private static final Pattern EMAIL_PATTERN = Pattern.compile("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$");
    private static final Pattern PHONE_PATTERN = Pattern.compile("^[0-9]{10}$");
    private static final Pattern PASSWORD_PATTERN = Pattern.compile("^(?=.*[A-Za-z])(?=.*\\d)(?=.*[@$!%*#?&])[A-Za-z\\d@$!%*#?&]{8,}$");

    @Override
    public void init() {
        userService = new UserService();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get parameters from request
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        // Validate input
        String errorMessage = validateInput(firstName, lastName, email, phone, password, confirmPassword);

        if (errorMessage != null) {
            // Validation failed, return to registration page with error
            request.setAttribute("errorMessage", errorMessage);
            request.getRequestDispatcher("Register.jsp").forward(request, response);
            return;
        }

        // Create user object
        User user = new User(firstName, lastName, email, phone, password);

        // Register user
        boolean success = userService.registerUser(user);

        if (success) {
            // Set session attribute
            HttpSession session = request.getSession();
            session.setAttribute("user", user);

            // Redirect to home page
            response.sendRedirect("Home.jsp");
        } else {
            // Set error message and forward back to register page
            request.setAttribute("errorMessage", "Email already exists");
            request.getRequestDispatcher("Register.jsp").forward(request, response);
        }
    }

    /**
     * Validates user input for registration
     * @return null if validation passes, error message otherwise
     */
    private String validateInput(String firstName, String lastName, String email, String phone,
                                String password, String confirmPassword) {
        // Check for null or empty values
        if (firstName == null || firstName.trim().isEmpty() ||
            lastName == null || lastName.trim().isEmpty() ||
            email == null || email.trim().isEmpty() ||
            password == null || password.trim().isEmpty() ||
            confirmPassword == null || confirmPassword.trim().isEmpty()) {
            return "All required fields must be filled";
        }

        // Validate first name
        if (!NAME_PATTERN.matcher(firstName).matches()) {
            return "First name must contain only letters and be at least 2 characters long";
        }

        // Validate last name
        if (!NAME_PATTERN.matcher(lastName).matches()) {
            return "Last name must contain only letters and be at least 2 characters long";
        }

        // Validate email
        if (!EMAIL_PATTERN.matcher(email).matches()) {
            return "Please enter a valid email address";
        }

        // Validate phone (if provided)
        if (phone != null && !phone.trim().isEmpty() && !PHONE_PATTERN.matcher(phone).matches()) {
            return "Phone number must be 10 digits";
        }

        // Validate password
        if (!PASSWORD_PATTERN.matcher(password).matches()) {
            return "Password must be at least 8 characters with at least one letter, one number, and one special character";
        }

        // Check if passwords match
        if (!password.equals(confirmPassword)) {
            return "Passwords don't match";
        }

        return null; // Validation passed
    }
}
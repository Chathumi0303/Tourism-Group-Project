package com.tourism.servlet;

import com.tourism.service.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;

public class ForgotPasswordServlet extends HttpServlet {
    private UserService userService;
    
    @Override
    public void init() {
        userService = new UserService();
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        String email = request.getParameter("email");
        
        if (action == null || email == null || email.isEmpty()) {
            request.setAttribute("errorMessage", "Invalid request");
            request.getRequestDispatcher("ForgotPassword.jsp").forward(request, response);
            return;
        }
        
        if (action.equals("sendOTP")) {
            // Generate and send OTP
            String otp = userService.generateOTP(email);
            
            if (otp == null) {
                request.setAttribute("errorMessage", "Email not found");
                request.getRequestDispatcher("ForgotPassword.jsp").forward(request, response);
                return;
            }
            
            // Store email in session for verification
            HttpSession session = request.getSession();
            session.setAttribute("resetEmail", email);
            
            request.setAttribute("successMessage", "OTP sent to console. Please check the server logs.");
            request.setAttribute("showOTPForm", true);
            request.getRequestDispatcher("ForgotPassword.jsp").forward(request, response);
            
        } else if (action.equals("verifyOTP")) {
            // Verify OTP and reset password
            String otp = request.getParameter("otp");
            String newPassword = request.getParameter("newPassword");
            String confirmPassword = request.getParameter("confirmPassword");
            
            // Get email from session
            HttpSession session = request.getSession();
            String resetEmail = (String) session.getAttribute("resetEmail");
            
            if (resetEmail == null || !resetEmail.equals(email)) {
                request.setAttribute("errorMessage", "Session expired. Please try again.");
                request.getRequestDispatcher("ForgotPassword.jsp").forward(request, response);
                return;
            }
            
            if (otp == null || otp.isEmpty() || newPassword == null || newPassword.isEmpty() || 
                confirmPassword == null || !newPassword.equals(confirmPassword)) {
                request.setAttribute("errorMessage", "Invalid input. Please try again.");
                request.setAttribute("showOTPForm", true);
                request.getRequestDispatcher("ForgotPassword.jsp").forward(request, response);
                return;
            }
            
            // Validate OTP
            boolean isValidOTP = userService.validateOTP(email, otp);
            
            if (!isValidOTP) {
                request.setAttribute("errorMessage", "Invalid OTP. Please try again.");
                request.setAttribute("showOTPForm", true);
                request.getRequestDispatcher("ForgotPassword.jsp").forward(request, response);
                return;
            }
            
            // Reset password
            boolean success = userService.resetPassword(email, newPassword);
            
            if (success) {
                // Clear session
                session.removeAttribute("resetEmail");
                
                request.setAttribute("successMessage", "Password reset successfully. You can now login with your new password.");
                request.getRequestDispatcher("Login.jsp").forward(request, response);
            } else {
                request.setAttribute("errorMessage", "Failed to reset password. Please try again.");
                request.getRequestDispatcher("ForgotPassword.jsp").forward(request, response);
            }
        }
    }
}
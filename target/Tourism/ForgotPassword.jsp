<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tourism Package Management - Forgot Password</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f5f7fa;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-image: linear-gradient(135deg, #72EDF2 10%, #5151E5 100%);
        }

        .forgot-container {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            width: 380px;
            padding: 40px;
            text-align: center;
        }

        .logo {
            width: 120px;
            margin-bottom: 20px;
        }

        h1 {
            color: #2c3e50;
            font-size: 24px;
            margin-bottom: 30px;
        }

        .input-group {
            margin-bottom: 20px;
            text-align: left;
        }

        label {
            display: block;
            margin-bottom: 8px;
            color: #7f8c8d;
            font-weight: 500;
        }

        input {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
            transition: border 0.3s;
            box-sizing: border-box;
        }

        input:focus {
            border-color: #3498db;
            outline: none;
        }

        .btn {
            background-color: #3498db;
            color: white;
            border: none;
            padding: 12px 20px;
            width: 100%;
            border-radius: 5px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: background-color 0.3s;
            margin-top: 10px;
        }

        .btn:hover {
            background-color: #2980b9;
        }

        .options {
            display: flex;
            justify-content: space-between;
            margin-top: 20px;
            font-size: 14px;
        }

        .options a {
            color: #3498db;
            text-decoration: none;
        }

        .options a:hover {
            text-decoration: underline;
        }

        .success-message {
            color: #27ae60;
            margin-top: 15px;
            text-align: center;
            padding: 10px;
            background: #e3f7e8;
            border-radius: 5px;
        }

        .error-message {
            color: #e74c3c;
            margin-top: 15px;
            text-align: center;
            padding: 10px;
            background: #fae5e5;
            border-radius: 5px;
        }
    </style>
</head>
<body>
<div class="forgot-container">
    <img src="./assets/loho.png" alt="Tourism Package System Logo" class="logo">
    <h1>Forgot Password</h1>

    <% if(request.getAttribute("successMessage") != null) { %>
        <div class="success-message">
            <%= request.getAttribute("successMessage") %>
        </div>
    <% } %>
    
    <% if(request.getAttribute("errorMessage") != null) { %>
        <div class="error-message">
            <%= request.getAttribute("errorMessage") %>
        </div>
    <% } %>

    <% if(request.getAttribute("showOTPForm") != null && (Boolean)request.getAttribute("showOTPForm")) { %>
        <!-- OTP Verification Form -->
        <form action="forgotPassword" method="post">
            <input type="hidden" name="action" value="verifyOTP">
            <input type="hidden" name="email" value="<%= request.getParameter("email") %>">
            
            <div class="input-group">
                <label for="otp">Enter OTP</label>
                <input type="text" id="otp" name="otp" placeholder="Enter the OTP sent to your email" required>
            </div>
            
            <div class="input-group">
                <label for="newPassword">New Password</label>
                <input type="password" id="newPassword" name="newPassword" placeholder="Enter your new password" required>
            </div>
            
            <div class="input-group">
                <label for="confirmPassword">Confirm Password</label>
                <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Confirm your new password" required>
            </div>
            
            <button type="submit" class="btn">Reset Password</button>
        </form>
    <% } else { %>
        <!-- Email Form -->
        <form action="forgotPassword" method="post">
            <input type="hidden" name="action" value="sendOTP">
            
            <div class="input-group">
                <label for="email">Email Address</label>
                <input type="email" id="email" name="email" placeholder="Enter your registered email" required>
            </div>
            
            <button type="submit" class="btn">Send OTP</button>
        </form>
    <% } %>

    <div class="options">
        <a href="Login.jsp">Back to Login</a>
        <a href="Register.jsp">Create Account</a>
    </div>
</div>

<script>
    // Password match validation
    document.addEventListener('DOMContentLoaded', function() {
        const newPasswordInput = document.getElementById('newPassword');
        const confirmPasswordInput = document.getElementById('confirmPassword');
        
        if (confirmPasswordInput) {
            confirmPasswordInput.addEventListener('input', function() {
                if (newPasswordInput.value !== confirmPasswordInput.value) {
                    confirmPasswordInput.setCustomValidity("Passwords don't match");
                } else {
                    confirmPasswordInput.setCustomValidity('');
                }
            });
            
            newPasswordInput.addEventListener('input', function() {
                if (newPasswordInput.value !== confirmPasswordInput.value) {
                    confirmPasswordInput.setCustomValidity("Passwords don't match");
                } else {
                    confirmPasswordInput.setCustomValidity('');
                }
            });
        }
    });
</script>
</body>
</html>
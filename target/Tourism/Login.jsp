<%--
  Created by IntelliJ IDEA.
  User: Venura
  Date: 03/05/2025
  Time: 14:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tourism Package Management - Login</title>
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

        .login-container {
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
        }

        input:focus {
            border-color: #3498db;
            outline: none;
        }

        .login-btn {
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

        .login-btn:hover {
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

        .divider {
            margin: 25px 0;
            border-top: 1px solid #ecf0f1;
            position: relative;
        }

        .divider-text {
            background-color: white;
            padding: 0 10px;
            position: absolute;
            top: -10px;
            left: 50%;
            transform: translateX(-50%);
            color: #95a5a6;
            font-size: 12px;
        }

        .social-login {
            display: flex;
            justify-content: center;
            gap: 15px;
        }

        .social-btn {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: transform 0.3s;
        }

        .social-btn:hover {
            transform: translateY(-3px);
        }

        .google {
            background-color: #db4437;
            color: white;
        }

        .facebook {
            background-color: #4267B2;
            color: white;
        }

        .apple {
            background-color: #000000;
            color: white;
        }
    </style>
</head>
<body>
<div class="login-container">
    <img src="./assets/loho.png" alt="Tourism Package System Logo" class="logo">
    <h1>Tourism Package Management</h1>

    <form id="loginForm" action="login" method="post">
        <div class="input-group">
            <label for="username">Username or Email</label>
            <input type="text" id="username" name="username" placeholder="Enter your username or email" required>
        </div>

        <div class="input-group">
            <label for="password">Password</label>
            <input type="password" id="password" name="password" placeholder="Enter your password" required>
        </div>

        <button type="submit" class="login-btn">Login</button>

        <div class="options">
            <a href="ForgotPassword.jsp">Forgot password?</a>
            <a href="Register.jsp">Register new account</a>
        </div>
        
        <% if(request.getAttribute("successMessage") != null) { %>
            <div class="success-message" style="color: #27ae60; margin-top: 15px; text-align: center; padding: 10px; background: #e3f7e8; border-radius: 5px;">
                <%= request.getAttribute("successMessage") %>
            </div>
        <% } %>
        
        <% if(request.getAttribute("errorMessage") != null) { %>
            <div class="error-message" style="color: #e74c3c; margin-top: 15px; text-align: center; padding: 10px; background: #fae5e5; border-radius: 5px;">
                <%= request.getAttribute("errorMessage") %>
            </div>
        <% } %>
    </form>

    <div class="divider">
        <span class="divider-text">OR CONTINUE WITH</span>
    </div>

    <div class="social-login">
        <div class="social-btn google">
            <i class="fab fa-google"></i>
        </div>
        <div class="social-btn facebook">
            <i class="fab fa-facebook-f"></i>
        </div>
        <div class="social-btn apple">
            <i class="fab fa-apple"></i>
        </div>
    </div>
</div>

<!-- Font Awesome for icons -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" crossorigin="anonymous"></script>

<script>
    document.getElementById('loginForm').addEventListener('submit', function(e) {
        // We'll let the form submit naturally to the servlet
        // Just log for debugging
        console.log('Login attempted');
    });
</script>
<script src="https://kit.fontawesome.com/54047f67ad.js" crossorigin="anonymous"></script>
</body>
</html>

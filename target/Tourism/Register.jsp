
<%--
  Created by IntelliJ IDEA.
  User: Venura
  Date: 03/05/2025
  Time: 15:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tourism Package Management - Sign Up</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f5f7fa;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            background-image: linear-gradient(135deg, #72EDF2 10%, #5151E5 100%);
        }

        .signup-container {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            width: 420px;
            padding: 40px;
            margin: 20px 0;
        }

        .logo {
            width: 120px;
            margin-bottom: 15px;
            display: block;
            margin-left: auto;
            margin-right: auto;
        }

        h1 {
            color: #2c3e50;
            font-size: 24px;
            margin-bottom: 25px;
            text-align: center;
        }

        .form-row {
            display: flex;
            gap: 15px;
            margin-bottom: 20px;
        }

        .form-group {
            flex: 1;
            margin-bottom: 0;
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
            font-size: 14px;
        }

        input, select {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 15px;
            transition: border 0.3s;
            box-sizing: border-box;
        }

        input:focus, select:focus {
            border-color: #3498db;
            outline: none;
        }

        .signup-btn {
            background-color: #27ae60;
            color: white;
            border: none;
            padding: 13px 20px;
            width: 100%;
            border-radius: 5px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: background-color 0.3s;
            margin-top: 10px;
        }

        .signup-btn:hover {
            background-color: #2ecc71;
        }

        .login-link {
            text-align: center;
            margin-top: 20px;
            font-size: 14px;
        }

        .login-link a {
            color: #3498db;
            text-decoration: none;
            font-weight: 500;
        }

        .login-link a:hover {
            text-decoration: underline;
        }

        .terms {
            font-size: 12px;
            color: #95a5a6;
            margin-top: 20px;
            text-align: center;
            line-height: 1.5;
        }

        .terms a {
            color: #3498db;
            text-decoration: none;
        }

        .terms a:hover {
            text-decoration: underline;
        }

        .password-strength {
            height: 4px;
            background-color: #ecf0f1;
            border-radius: 2px;
            margin-top: 5px;
            overflow: hidden;
        }

        .strength-meter {
            height: 100%;
            width: 0%;
            background-color: #e74c3c;
            transition: width 0.3s, background-color 0.3s;
        }

        .password-hint {
            font-size: 12px;
            color: #95a5a6;
            margin-top: 5px;
        }

        .error-message {
            text-align: center;
            color: #e74c3c;
            margin-top: 15px;
            font-size: 14px;
        }

        .field-error {
            color: #e74c3c;
            font-size: 12px;
            margin-top: 5px;
            display: none;
        }

        input.invalid {
            border-color: #e74c3c;
        }

        @media (max-width: 480px) {
            .signup-container {
                width: 90%;
                padding: 25px;
            }

            .form-row {
                flex-direction: column;
                gap: 0;
            }
        }
    </style>
</head>
<body>
<div class="signup-container">
    <img src="./assets/loho.png" alt="Tourism Package System Logo" class="logo">
    <h1>Create Your Account</h1>

    <form id="signupForm" action="register" method="post">
        <div class="form-row">
            <div class="form-group">
                <div class="input-group">
                    <label for="firstName">First Name</label>
                    <input type="text" id="firstName" name="firstName" placeholder="Enter your first name" required minlength="2" pattern="[A-Za-z ]+" title="Please enter a valid name (letters only)">
                    <div id="firstNameError" class="field-error">Please enter a valid first name (letters only)</div>
                </div>
            </div>
            <div class="form-group">
                <div class="input-group">
                    <label for="lastName">Last Name</label>
                    <input type="text" id="lastName" name="lastName" placeholder="Enter your last name" required minlength="2" pattern="[A-Za-z ]+" title="Please enter a valid name (letters only)">
                    <div id="lastNameError" class="field-error">Please enter a valid last name (letters only)</div>
                </div>
            </div>
        </div>

        <div class="input-group">
            <label for="email">Email Address</label>
            <input type="email" id="email" name="email" placeholder="Enter your email address" required pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$" title="Please enter a valid email address">
            <div id="emailError" class="field-error">Please enter a valid email address</div>
        </div>

        <div class="input-group">
            <label for="phone">Phone Number</label>
            <input type="tel" id="phone" name="phone" placeholder="Enter your phone number" pattern="[0-9]{10}" title="Please enter a 10-digit phone number">
            <div id="phoneError" class="field-error">Please enter a valid 10-digit phone number</div>
        </div>

        <div class="input-group">
            <label for="password">Password</label>
            <input type="password" id="password" name="password" placeholder="Create a password" required minlength="8" title="Password must be at least 8 characters">
            <div class="password-strength">
                <div class="strength-meter" id="strengthMeter"></div>
            </div>
            <div class="password-hint">
                Use 8 or more characters with a mix of letters, numbers & symbols
            </div>
            <div id="passwordError" class="field-error">Password must be at least 8 characters with letters, numbers & symbols</div>
        </div>

        <div class="input-group">
            <label for="confirmPassword">Confirm Password</label>
            <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Confirm your password" required>
            <div id="confirmPasswordError" class="field-error">Passwords don't match</div>
        </div>

        <button type="submit" class="signup-btn">Create Account</button>

        <% if(request.getAttribute("errorMessage") != null) { %>
            <div class="error-message">
                <%= request.getAttribute("errorMessage") %>
            </div>
        <% } %>
    </form>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Get all form elements
        const form = document.getElementById('signupForm');
        const firstName = document.getElementById('firstName');
        const lastName = document.getElementById('lastName');
        const email = document.getElementById('email');
        const phone = document.getElementById('phone');
        const password = document.getElementById('password');
        const confirmPassword = document.getElementById('confirmPassword');

        // Get all error elements
        const firstNameError = document.getElementById('firstNameError');
        const lastNameError = document.getElementById('lastNameError');
        const emailError = document.getElementById('emailError');
        const phoneError = document.getElementById('phoneError');
        const passwordError = document.getElementById('passwordError');
        const confirmPasswordError = document.getElementById('confirmPasswordError');

        // Validation functions
        function validateName(input, errorElement) {
            const nameRegex = /^[A-Za-z ]{2,}$/;
            const isValid = nameRegex.test(input.value);

            if (!isValid && input.value.trim() !== '') {
                input.classList.add('invalid');
                errorElement.style.display = 'block';
                return false;
            } else {
                input.classList.remove('invalid');
                errorElement.style.display = 'none';
                return true;
            }
        }

        function validateEmail(input, errorElement) {
            const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
            const isValid = emailRegex.test(input.value);

            if (!isValid && input.value.trim() !== '') {
                input.classList.add('invalid');
                errorElement.style.display = 'block';
                return false;
            } else {
                input.classList.remove('invalid');
                errorElement.style.display = 'none';
                return true;
            }
        }

        function validatePhone(input, errorElement) {
            // Allow empty phone (not required) or valid 10-digit number
            const phoneRegex = /^[0-9]{10}$/;
            const isValid = input.value.trim() === '' || phoneRegex.test(input.value);

            if (!isValid) {
                input.classList.add('invalid');
                errorElement.style.display = 'block';
                return false;
            } else {
                input.classList.remove('invalid');
                errorElement.style.display = 'none';
                return true;
            }
        }

        function validatePassword(input, errorElement) {
            // At least 8 characters with at least one letter, one number, and one special character
            const passwordRegex = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$/;
            const isValid = passwordRegex.test(input.value);

            if (!isValid && input.value.trim() !== '') {
                input.classList.add('invalid');
                errorElement.style.display = 'block';
                return false;
            } else {
                input.classList.remove('invalid');
                errorElement.style.display = 'none';
                return true;
            }
        }

        function validateConfirmPassword(passwordInput, confirmInput, errorElement) {
            const isValid = passwordInput.value === confirmInput.value;

            if (!isValid && confirmInput.value.trim() !== '') {
                confirmInput.classList.add('invalid');
                errorElement.style.display = 'block';
                return false;
            } else {
                confirmInput.classList.remove('invalid');
                errorElement.style.display = 'none';
                return true;
            }
        }

        // Add input event listeners for real-time validation
        firstName.addEventListener('input', function() {
            validateName(firstName, firstNameError);
        });

        lastName.addEventListener('input', function() {
            validateName(lastName, lastNameError);
        });

        email.addEventListener('input', function() {
            validateEmail(email, emailError);
        });

        phone.addEventListener('input', function() {
            validatePhone(phone, phoneError);
        });

        password.addEventListener('input', function() {
            validatePassword(password, passwordError);
            if (confirmPassword.value.trim() !== '') {
                validateConfirmPassword(password, confirmPassword, confirmPasswordError);
            }

            // Password strength indicator
            const strengthMeter = document.getElementById('strengthMeter');
            let strength = 0;

            // Check for length
            if (password.value.length >= 8) strength += 25;
            if (password.value.length >= 12) strength += 25;

            // Check for character variety
            if (/[A-Z]/.test(password.value)) strength += 15;
            if (/[0-9]/.test(password.value)) strength += 15;
            if (/[^A-Za-z0-9]/.test(password.value)) strength += 20;

            // Update meter
            strengthMeter.style.width = strength + '%';

            // Update color
            if (strength < 50) {
                strengthMeter.style.backgroundColor = '#e74c3c'; // Red
            } else if (strength < 75) {
                strengthMeter.style.backgroundColor = '#f39c12'; // Orange
            } else {
                strengthMeter.style.backgroundColor = '#27ae60'; // Green
            }
        });

        confirmPassword.addEventListener('input', function() {
            validateConfirmPassword(password, confirmPassword, confirmPasswordError);
        });

        // Form submission validation
        form.addEventListener('submit', function(e) {
            // Validate all fields
            const isFirstNameValid = validateName(firstName, firstNameError);
            const isLastNameValid = validateName(lastName, lastNameError);
            const isEmailValid = validateEmail(email, emailError);
            const isPhoneValid = validatePhone(phone, phoneError);
            const isPasswordValid = validatePassword(password, passwordError);
            const isConfirmPasswordValid = validateConfirmPassword(password, confirmPassword, confirmPasswordError);

            // Prevent form submission if any validation fails
            if (!isFirstNameValid || !isLastNameValid || !isEmailValid || !isPhoneValid ||
                !isPasswordValid || !isConfirmPasswordValid) {
                e.preventDefault();
                return;
            }

            console.log('Signup submitted:', {
                firstName: firstName.value,
                lastName: lastName.value,
                email: email.value,
                phone: phone.value
            });
        });
    });
</script>
</body>
</html>

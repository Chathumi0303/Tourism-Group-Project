<%--
  Created by IntelliJ IDEA.
  User: Venura
  Date: 03/05/2025
  Time: 16:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.tourism.model.User" %>
<%
    // Get the user from the session
    User user = null;
    if(session.getAttribute("user") != null) {
        user = (User)session.getAttribute("user");
    } else {
        // Redirect to login if not logged in
        response.sendRedirect("Login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile | TourismPro</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        /* Global Styles */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background-color: #f5f7fa;
            color: #333;
            line-height: 1.6;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }

        /* Header */
        .profile-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 1px solid #e0e0e0;
        }

        .header-left {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .btn-home {
            background: #f1c40f;
            color: #2c3e50;
            display: flex;
            align-items: center;
            gap: 8px;
            text-decoration: none;
        }

        .btn-home:hover {
            background: #f39c12;
        }

        .profile-header h1 {
            font-size: 28px;
            color: #2c3e50;
        }

        .btn {
            padding: 8px 16px;
            border-radius: 5px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            border: none;
        }

        .btn-edit {
            background: #3498db;
            color: white;
        }

        .btn-edit:hover {
            background: #2980b9;
        }

        /* Profile Layout */
        .profile-container {
            display: flex;
            gap: 30px;
        }

        /* Sidebar */
        .profile-sidebar {
            width: 250px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
            height: fit-content;
        }

        .profile-pic {
            display: flex;
            flex-direction: column;
            align-items: center;
            margin-bottom: 20px;
        }

        .profile-avatar {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            background-color: #3498db;
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            font-size: 36px;
            margin-bottom: 10px;
        }

        .profile-avatar h3 {
            margin-top: 10px;
            color: #2c3e50;
        }

        .profile-avatar p {
            color: #7f8c8d;
            font-size: 14px;
        }

        .profile-menu {
            margin-top: 20px;
        }

        .profile-menu a {
            display: block;
            padding: 12px 10px;
            color: #2c3e50;
            text-decoration: none;
            border-radius: 5px;
            margin-bottom: 5px;
            transition: all 0.3s;
        }

        .profile-menu a:hover, .profile-menu a.active {
            background: #f8f9fa;
            color: #3498db;
            font-weight: 600;
        }

        .profile-menu a i {
            margin-right: 10px;
            width: 20px;
            text-align: center;
        }

        /* Main Content */
        .profile-content {
            flex: 1;
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            padding: 25px;
        }

        .tab-content {
            display: none;
        }

        .tab-content.active {
            display: block;
        }

        /* Personal Info Section */
        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: #2c3e50;
        }

        .form-group input, .form-group select, .form-group textarea {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 15px;
            transition: border 0.3s;
        }

        .form-group input:focus, .form-group select:focus, .form-group textarea:focus {
            border-color: #3498db;
            outline: none;
        }

        .form-row {
            display: flex;
            gap: 15px;
        }

        .form-row .form-group {
            flex: 1;
        }

        .btn-save {
            background: #27ae60;
            color: white;
            padding: 12px 25px;
            font-size: 16px;
        }

        .btn-save:hover {
            background: #2ecc71;
        }

        /* Bookings Section */
        .booking-card {
            border: 1px solid #e0e0e0;
            border-radius: 8px;
            padding: 15px;
            margin-bottom: 15px;
            display: flex;
            gap: 20px;
        }

        .booking-img {
            width: 150px;
            height: 100px;
            border-radius: 5px;
            overflow: hidden;
        }

        .booking-img img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .booking-details {
            flex: 1;
        }

        .booking-details h3 {
            margin-bottom: 5px;
            color: #2c3e50;
        }

        .booking-meta {
            display: flex;
            gap: 15px;
            margin-bottom: 10px;
            color: #7f8c8d;
            font-size: 14px;
        }

        .booking-status {
            display: inline-block;
            padding: 3px 10px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
        }

        .status-confirmed {
            background: #e3f7e8;
            color: #27ae60;
        }

        .status-pending {
            background: #fff4e5;
            color: #f39c12;
        }

        .booking-actions {
            margin-top: 10px;
        }

        .booking-actions a {
            color: #3498db;
            text-decoration: none;
            margin-right: 15px;
            font-weight: 500;
        }

        .booking-actions a:hover {
            text-decoration: underline;
        }

        /* Responsive Adjustments */
        @media (max-width: 768px) {
            .profile-container {
                flex-direction: column;
            }

            .profile-sidebar {
                width: 100%;
            }

            .form-row {
                flex-direction: column;
                gap: 0;
            }

            .booking-card {
                flex-direction: column;
            }

            .booking-img {
                width: 100%;
                height: 180px;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <!-- Profile Header -->
    <div class="profile-header">
        <div class="header-left">
            <a href="Home.jsp" class="btn btn-home">
                <i class="fas fa-arrow-left"></i> Back to Home
            </a>
            <h1>My Profile</h1>
        </div>
        <button class="btn btn-edit">
            <i class="fas fa-edit"></i> Edit Profile
        </button>
    </div>

    <!-- Profile Layout -->
    <div class="profile-container">
        <!-- Sidebar -->
        <div class="profile-sidebar">
            <div class="profile-pic">
                <% 
                    String initials = user.getFirstName().substring(0, 1) + user.getLastName().substring(0, 1);
                %>
                <div class="profile-avatar"><%= initials.toUpperCase() %></div>
                <h3><%= user.getFirstName() + " " + user.getLastName() %></h3>
                <p>Travel Enthusiast</p>
            </div>

            <div class="profile-menu">
                <a href="#" class="active" data-tab="personal">
                    <i class="fas fa-user"></i> Personal Info
                </a>
                <a href="logout" data-tab="logout">
                    <i class="fas fa-sign-out-alt"></i> Logout
                </a>
            </div>
        </div>

        <!-- Main Content -->
        <div class="profile-content">
            <!-- Personal Info Tab -->
            <div class="tab-content active" id="personal">
                <h2>Personal Information</h2>
                
                <% if(request.getAttribute("successMessage") != null) { %>
                    <div class="success-message" style="color: #27ae60; margin-top: 10px; padding: 10px; background: #e3f7e8; border-radius: 5px;">
                        <%= request.getAttribute("successMessage") %>
                    </div>
                <% } %>
                
                <% if(request.getAttribute("errorMessage") != null) { %>
                    <div class="error-message" style="color: #e74c3c; margin-top: 10px; padding: 10px; background: #fae5e5; border-radius: 5px;">
                        <%= request.getAttribute("errorMessage") %>
                    </div>
                <% } %>
                
                <form style="margin-top: 20px;" action="updateProfile" method="post">
                    <div class="form-row">
                        <div class="form-group">
                            <label>First Name</label>
                            <input type="text" name="firstName" value="<%= user.getFirstName() %>" required minlength="2" maxlength="50" pattern="[A-Za-z\s]+" title="Please enter a valid first name (letters only)">
                        </div>
                        <div class="form-group">
                            <label>Last Name</label>
                            <input type="text" name="lastName" value="<%= user.getLastName() %>" required minlength="2" maxlength="50" pattern="[A-Za-z\s]+" title="Please enter a valid last name (letters only)">
                        </div>
                    </div>

                    <div class="form-group">
                        <label>Email</label>
                        <input type="email" name="email" value="<%= user.getEmail() %>" readonly>
                    </div>

                    <div class="form-group">
                        <label>Phone Number</label>
                        <input type="tel" name="phone" value="<%= user.getPhone() %>" pattern="^\+?[0-9]{10,15}$" title="Please enter a valid phone number (10-15 digits)">
                    </div>

                    <div class="form-group">
                        <label>Date of Birth</label>
                        <input type="date" name="dob" value="<%= user.getDob() != null ? user.getDob() : "" %>" max="<%= java.time.LocalDate.now().minusYears(18) %>">
                    </div>

                    <div class="form-group">
                        <label>Address</label>
                        <textarea name="address" rows="3" maxlength="200"><%= user.getAddress() != null ? user.getAddress() : "" %></textarea>
                    </div>

                    <div class="form-group">
                        <label>Travel Preferences</label>
                        <select name="travelPreference">
                            <option value="Adventure" <%= "Adventure".equals(user.getTravelPreference()) ? "selected" : "" %>>Adventure</option>
                            <option value="Luxury" <%= "Luxury".equals(user.getTravelPreference()) ? "selected" : "" %>>Luxury</option>
                            <option value="Cultural" <%= "Cultural".equals(user.getTravelPreference()) ? "selected" : "" %>>Cultural</option>
                            <option value="Beach" <%= "Beach".equals(user.getTravelPreference()) ? "selected" : "" %>>Beach</option>
                        </select>
                    </div>

                    <button type="submit" class="btn btn-save">
                        <i class="fas fa-save"></i> Save Changes
                    </button>
                </form>
            </div>

            <!-- Bookings Tab -->
            <div class="tab-content" id="bookings">
                <h2>My Bookings</h2>

                <div class="booking-card">
                    <div class="booking-img">
                        <img src="https://images.unsplash.com/photo-1503917988258-f87a78e3c995?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80" alt="Bali Vacation">
                    </div>
                    <div class="booking-details">
                        <h3>Bali Paradise Getaway</h3>
                        <div class="booking-meta">
                            <span><i class="fas fa-calendar-alt"></i> June 10 - 17, 2023</span>
                            <span><i class="fas fa-users"></i> 2 Adults</span>
                        </div>
                        <span class="booking-status status-confirmed">Confirmed</span>
                        <div class="booking-actions">
                            <a href="#"><i class="fas fa-file-invoice"></i> View Invoice</a>
                            <a href="#"><i class="fas fa-exchange-alt"></i> Modify Booking</a>
                            <a href="#" style="color: #e74c3c;"><i class="fas fa-times"></i> Cancel</a>
                        </div>
                    </div>
                </div>

                <div class="booking-card">
                    <div class="booking-img">
                        <img src="https://images.unsplash.com/photo-1520250497591-112f2f40a3f4?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80" alt="European Tour">
                    </div>
                    <div class="booking-details">
                        <h3>European Adventure</h3>
                        <div class="booking-meta">
                            <span><i class="fas fa-calendar-alt"></i> August 5 - 19, 2023</span>
                            <span><i class="fas fa-users"></i> 4 Adults</span>
                        </div>
                        <span class="booking-status status-pending">Pending Payment</span>
                        <div class="booking-actions">
                            <a href="#"><i class="fas fa-credit-card"></i> Complete Payment</a>
                            <a href="#"><i class="fas fa-exchange-alt"></i> Modify Booking</a>
                        </div>
                    </div>
                </div>
            </div>


            <div class="tab-content" id="settings">
                <h2>Account Settings</h2>
                
                <div style="margin-top: 30px;">
                    <h3>Delete Account</h3>
                    <p style="color: #7f8c8d; margin: 10px 0;">
                        Warning: This action cannot be undone. All your data will be permanently deleted.
                    </p>
                    
                    <form action="deleteAccount" method="post" onsubmit="return confirmDelete()">
                        <button type="submit" class="btn" style="background: #e74c3c; color: white;">
                            <i class="fas fa-trash"></i> Delete My Account
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    // Tab switching functionality
    document.querySelectorAll('.profile-menu a').forEach(link => {
        link.addEventListener('click', function(e) {
            e.preventDefault();

            // Remove active class from all links and tabs
            document.querySelectorAll('.profile-menu a').forEach(item => {
                item.classList.remove('active');
            });
            document.querySelectorAll('.tab-content').forEach(tab => {
                tab.classList.remove('active');
            });

            // Add active class to clicked link and corresponding tab
            this.classList.add('active');
            const tabId = this.getAttribute('data-tab');
            document.getElementById(tabId).classList.add('active');
        });
    });

    // Function to generate a color based on a string (name)
    function stringToColor(str) {
        let hash = 0;
        for (let i = 0; i < str.length; i++) {
            hash = str.charCodeAt(i) + ((hash << 5) - hash);
        }
        let color = '#';
        for (let i = 0; i < 3; i++) {
            let value = (hash >> (i * 8)) & 0xFF;
            color += ('00' + value.toString(16)).substr(-2);
        }
        return color;
    }

    // Apply colors to avatars
    document.addEventListener('DOMContentLoaded', function() {
        const avatar = document.querySelector('.profile-avatar');
        if (avatar) {
            const name = avatar.textContent.trim();
            avatar.style.backgroundColor = stringToColor(name);
        }
    });
</script>
</body>
</html>

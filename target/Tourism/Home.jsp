
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Tourism Package Management - Home</title>
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
      background-color: #f8f9fa;
      color: #333;
      line-height: 1.6;
    }

    .container {
      max-width: 1200px;
      margin: 0 auto;
      padding: 0 20px;
    }

    /* Header & Navigation */
    header {
      background: linear-gradient(135deg, #3498db, #2c3e50);
      color: white;
      padding: 15px 0;
      box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    }

    .navbar {
      display: flex;
      justify-content: space-between;
      align-items: center;
    }

    .logo {
      font-size: 24px;
      font-weight: 700;
      display: flex;
      align-items: center;
    }

    .logo i {
      margin-right: 10px;
      color: #f1c40f;
    }

    .nav-links {
      display: flex;
      gap: 25px;
    }

    .nav-links a {
      color: white;
      text-decoration: none;
      font-weight: 500;
      transition: color 0.3s;
    }

    .nav-links a:hover {
      color: #f1c40f;
    }

    .user-actions {
      display: flex;
      gap: 15px;
    }

    .btn {
      padding: 8px 16px;
      border-radius: 5px;
      font-weight: 600;
      cursor: pointer;
      transition: all 0.3s;
    }

    .btn-login {
      background: transparent;
      border: 1px solid white;
      color: white;
    }

    .btn-login:hover {
      background: rgba(255, 255, 255, 0.1);
    }

    .btn-signup {
      background: #f1c40f;
      border: 1px solid #f1c40f;
      color: #2c3e50;
    }

    .btn-signup:hover {
      background: #f39c12;
      border-color: #f39c12;
    }

    .avatar {
      width: 40px;
      height: 40px;
      border-radius: 50%;
      background-color: #3498db;
      color: white;
      display: flex;
      align-items: center;
      justify-content: center;
      font-weight: bold;
      font-size: 16px;
      margin-right: 10px;
      text-decoration: none;
    }

    .avatar:hover {
      background-color: #2980b9;
    }

    .user-email {
      color: white;
      font-size: 14px;
      margin-right: 10px;
      align-items: center;
      display: flex;
      justify-content: center;
    }

    .btn-logout {
      background: #e74c3c;
      border: 1px solid #e74c3c;
      color: white;
    }

    .btn-logout:hover {
      background: #c0392b;
      border-color: #c0392b;
    }

    /* Hero Section */
    .hero {
      background: url('https://images.unsplash.com/photo-1506929562872-bb421503ef21?ixlib=rb-4.0.3&auto=format&fit=crop&w=1350&q=80') no-repeat center center/cover;
      height: 500px;
      display: flex;
      align-items: center;
      text-align: center;
      color: white;
      position: relative;
    }

    .hero::before {
      content: '';
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background: rgba(0, 0, 0, 0.5);
    }

    .hero-content {
      position: relative;
      z-index: 1;
      width: 100%;
      padding: 0 20px;
    }

    .hero h1 {
      font-size: 48px;
      margin-bottom: 20px;
    }

    .hero p {
      font-size: 18px;
      margin-bottom: 30px;
      max-width: 700px;
      margin-left: auto;
      margin-right: auto;
    }

    .search-bar {
      display: flex;
      max-width: 800px;
      margin: 0 auto;
      background: white;
      border-radius: 50px;
      overflow: hidden;
      box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
    }

    .search-bar input {
      flex: 1;
      padding: 15px 20px;
      border: none;
      outline: none;
      font-size: 16px;
    }

    .search-bar button {
      background: #f1c40f;
      color: #2c3e50;
      border: none;
      padding: 15px 30px;
      font-weight: 600;
      cursor: pointer;
      transition: background 0.3s;
    }

    .search-bar button:hover {
      background: #f39c12;
    }

    /* Featured Packages */
    .section-title {
      text-align: center;
      margin: 50px 0 30px;
      font-size: 32px;
      color: #2c3e50;
    }

    .packages-grid {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
      gap: 25px;
      margin-bottom: 50px;
    }

    .package-card {
      background: white;
      border-radius: 10px;
      overflow: hidden;
      box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
      transition: transform 0.3s;
    }

    .package-card:hover {
      transform: translateY(-10px);
    }

    .package-img {
      height: 200px;
      overflow: hidden;
    }

    .package-img img {
      width: 100%;
      height: 100%;
      object-fit: cover;
      transition: transform 0.5s;
    }

    .package-card:hover .package-img img {
      transform: scale(1.1);
    }

    .package-info {
      padding: 20px;
    }

    .package-info h3 {
      margin-bottom: 10px;
      color: #2c3e50;
    }

    .package-info p {
      color: #7f8c8d;
      margin-bottom: 15px;
    }

    .logo {
      width: 40px;
      object-fit: cover;
      margin-left: 10px;
    }

    .package-price {
      font-size: 20px;
      font-weight: 700;
      color: #e74c3c;
      margin-bottom: 15px;
    }

    .package-meta {
      display: flex;
      justify-content: space-between;
      color: #7f8c8d;
      font-size: 14px;
    }

    .btn-book {
      display: block;
      width: 100%;
      padding: 10px;
      background: #3498db;
      color: white;
      border: none;
      border-radius: 5px;
      font-weight: 600;
      cursor: pointer;
      transition: background 0.3s;
      margin-top: 15px;
    }

    .btn-book:hover {
      background: #2980b9;
    }

    /* Footer */
    footer {
      background: #2c3e50;
      color: white;
      padding: 50px 0 20px;
    }

    .footer-content {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
      gap: 30px;
      margin-bottom: 30px;
    }

    .footer-column h3 {
      margin-bottom: 20px;
      font-size: 18px;
    }

    .footer-column ul {
      list-style: none;
    }

    .footer-column ul li {
      margin-bottom: 10px;
    }

    .footer-column ul li a {
      color: #bdc3c7;
      text-decoration: none;
      transition: color 0.3s;
    }

    .footer-column ul li a:hover {
      color: #f1c40f;
    }

    .social-links {
      display: flex;
      gap: 15px;
      margin-top: 15px;
    }

    .social-links a {
      color: white;
      font-size: 20px;
      transition: color 0.3s;
    }

    .social-links a:hover {
      color: #f1c40f;
    }

    .copyright {
      text-align: center;
      padding-top: 20px;
      border-top: 1px solid #34495e;
      color: #bdc3c7;
      font-size: 14px;
    }

    /* Responsive Adjustments */
    @media (max-width: 768px) {
      .navbar {
        flex-direction: column;
        gap: 15px;
      }

      .nav-links {
        flex-wrap: wrap;
        justify-content: center;
      }

      .hero h1 {
        font-size: 36px;
      }

      .search-bar {
        flex-direction: column;
        border-radius: 10px;
      }

      .search-bar input, .search-bar button {
        width: 100%;
        border-radius: 0;
      }
    }
  </style>
</head>
<body>
<!-- Header & Navigation -->
<header>
  <div class="container">
    <nav class="navbar">
      <div class="logo">
        <img src="./assets/loho.png" alt="Tourism Package System Logo" class="logo">
        <span>TourismPro</span>
      </div>
      <div class="nav-links">
        <a href="#">Home</a>
        <a href="#">Packages</a>
        <a href="#">Destinations</a>
        <a href="#">About Us</a>
        <a href="#">Contact</a>
      </div>
      <div class="user-actions">
        <% if(session.getAttribute("user") != null) { 
             com.tourism.model.User user = (com.tourism.model.User)session.getAttribute("user");
             String initials = user.getFirstName().substring(0, 1) + user.getLastName().substring(0, 1);
        %>
          <span class="user-email"><%= user.getEmail() %></span>
          <a href="Profile.jsp" class="avatar"><%= initials.toUpperCase() %></a>
          <button onclick="window.location.href='logout'" class="btn btn-logout">Logout</button>
        <% } else { %>
          <button onclick="window.location.href='Login.jsp'" class="btn btn-login">Login</button>
          <button onclick="window.location.href='Register.jsp'" class="btn btn-signup">Sign Up</button>
        <% } %>
      </div>
    </nav>
  </div>
</header>

<!-- Hero Section -->
<section class="hero">
  <div class="hero-content">
    <h1>Discover Your Dream Vacation</h1>
    <p>Explore the best travel packages curated for adventure seekers, luxury travelers, and everyone in between.</p>
    <div class="search-bar">
      <input type="text" placeholder="Search destinations, packages, or activities...">
      <button>Search</button>
    </div>
  </div>
</section>

<!-- Featured Packages -->
<div class="container">
  <h2 class="section-title">Featured Packages</h2>
  <div class="packages-grid">
    <!-- Package 1 -->
    <div class="package-card">
      <div class="package-img">
        <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSMUZOAN05C2hm5Gqt8yhTartYGJVXbf_7ggazTizOkKnxJG8ohS8_mrzoKA827wZiPYCo&usqp=CAU" alt="Bali Vacation">
      </div>
      <div class="package-info">
        <h3>Misty Highlands Retreat</h3>
        <p>04-days in scenic beauty of Nuwara Eliya .</p>
        <div class="package-meta">
          <span><i class="fas fa-calendar-alt"></i> 4 Days</span>
          <span><i class="fas fa-users"></i> 2-4 People</span>
        </div>
        <div class="package-price">Rs.20,000pp</div>
        <button class="btn-book">Book Now</button>
      </div>
    </div>

    <!-- Package 2 -->
    <div class="package-card">
      <div class="package-img">
        <img src="https://www.trawell.in/blog/wp-content/uploads/2017/07/Srilanka_Main-730x410.jpg" alt="European Tour">
      </div>
      <div class="package-info">
        <h3>Coastal Bliss Escape</h3>
        <p>04-day Scenic beauty sun-soaked beaches.</p>
        <div class="package-meta">
          <span><i class="fas fa-calendar-alt"></i> 4 Days</span>
          <span><i class="fas fa-users"></i> Solo or Group</span>
        </div>
        <div class="package-price">Rs.15,000pp</div>
        <button class="btn-book">Book Now</button>
      </div>
    </div>

    <!-- Package 3 -->
    <div class="package-card">
      <div class="package-img">
        <img src="https://ttgasia.2017.ttgasia.com/wp-content/uploads/sites/2/2024/01/ColomboSri-Lanka1_640.jpeg " alt="Safari Tour">
      </div>
      <div class="package-info">
        <h3>Colombo City Pulse</h3>
        <p>02-day Experience of colombo.       </p>
        <div class="package-meta">
          <span><i class="fas fa-calendar-alt"></i> 10 Days</span>
          <span><i class="fas fa-users"></i> 4-6 People</span>
        </div>
        <div class="package-price">Rs.10,000pp</div>
        <button class="btn-book">Book Now</button>
      </div>
    </div>
  </div>
</div>

<!-- Footer -->
<footer>
  <div class="container">
    <div class="footer-content">
      <div class="footer-column">
        <h3>TourismPro</h3>
        <p>Your trusted partner in creating unforgettable travel experiences.</p>
        <div class="social-links">
          <a href="#"><i class="fab fa-facebook-f"></i></a>
          <a href="#"><i class="fab fa-twitter"></i></a>
          <a href="#"><i class="fab fa-instagram"></i></a>
          <a href="#"><i class="fab fa-linkedin-in"></i></a>
        </div>
      </div>
      <div class="footer-column">
        <h3>Quick Links</h3>
        <ul>
          <li><a href="#">Home</a></li>
          <li><a href="#">Packages</a></li>
          <li><a href="#">Destinations</a></li>
          <li><a href="#">Special Offers</a></li>
        </ul>
      </div>
      <div class="footer-column">
        <h3>Support</h3>
        <ul>
          <li><a href="#">FAQs</a></li>
          <li><a href="#">Contact Us</a></li>
          <li><a href="#">Privacy Policy</a></li>
          <li><a href="#">Terms & Conditions</a></li>
        </ul>
      </div>
      <div class="footer-column">
        <h3>Newsletter</h3>
        <p>Subscribe for travel deals and updates.</p>
        <form>
          <input type="email" placeholder="Your Email" style="width: 100%; padding: 10px; margin-bottom: 10px; border-radius: 5px; border: none;">
          <button type="submit" style="background: #f1c40f; color: #2c3e50; border: none; padding: 10px 15px; border-radius: 5px; cursor: pointer;">Subscribe</button>
        </form>
      </div>
    </div>
    <div class="copyright">
      <p>&copy; 2023 TourismPro. All Rights Reserved.</p>
    </div>
  </div>
</footer>
<script>
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
        const avatars = document.querySelectorAll('.avatar');
        avatars.forEach(avatar => {
            const name = avatar.textContent.trim();
            avatar.style.backgroundColor = stringToColor(name);
        });
    });
</script>
</body>
</html>

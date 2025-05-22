<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TravelEase - Package Management</title>
    <link rel="stylesheet" href="TravelPackage/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
<header>
    <div class="container">
        <div class="logo">
            <i class="fas fa-plane"></i>
            <h1>TravelEase</h1>
        </div>
        <nav>
            <ul>
                <li><a href="#" class="active">Home</a></li>
                <li><a href="packageManagement.jsp">Packages</a></li>
                <li><a href="#destinations">Destinations</a></li>
                <li><a href="#about">About</a></li>
                <li><a href="#contact">Contact</a></li>
            </ul>
        </nav>
        <div class="auth-buttons">
            <button id="loginBtn">Login</button>
            <button id="registerBtn">Register</button>
        </div>
    </div>
</header>

<section class="hero">
    <div class="container">
        <h2>Discover Your Perfect Getaway</h2>
        <p>Explore our exclusive travel packages tailored just for you</p>
        <div class="search-box">
            <input type="text" placeholder="Search destinations...">
            <button><i class="fas fa-search"></i></button>
        </div>
    </div>
</section>

<section id="packages" class="packages">
    <div class="container">
        <h2>Featured Packages</h2>
        <div class="package-filters">
            <button class="filter-btn active" data-filter="all">All</button>
            <button class="filter-btn" data-filter="beach">Beach</button>
            <button class="filter-btn" data-filter="mountain">Mountain</button>
            <button class="filter-btn" data-filter="city">City</button>
            <button class="filter-btn" data-filter="adventure">Adventure</button>
        </div>
        <div class="package-grid" id="packageContainer">
            <!-- Packages will be loaded here via JavaScript -->
        </div>
    </div>
</section>

<section id="destinations" class="destinations">
    <div class="container">
        <h2>Popular Destinations</h2>
        <div class="destination-grid">
            <div class="destination-card">
                <img src="https://images.unsplash.com/photo-1503917988258-f87a78e3c995" alt="Paris">
                <h3>Sri Lankan, Colombo</h3>
                <p>The city of love and lights</p>
            </div>
            <div class="destination-card">
                <img src="https://www.dongasrilanka.com/wp-content/uploads/2022/12/galle-fort-image-2.webp" alt="Tokyo">
                <h3>Sri Lankan , Galle Fort </h3>
                <p>Where tradition meets innovation</p>
            </div>
            <div class="destination-card">
                <img src="https://images.unsplash.com/photo-1518391846015-55a9cc003b25" alt="New York">
                <h3>Sri Lankan , Port City</h3>
                <p>The city that never sleeps</p>
            </div>
        </div>
    </div>
</section>

<section class="testimonials">
    <div class="container">
        <h2>What Our Customers Say</h2>
        <div class="testimonial-slider">
            <div class="testimonial active">
                <p>"The travel package was perfectly organized. Everything went smoothly from start to finish!"</p>
                <div class="author">- Sarah Johnson</div>
            </div>
            <div class="testimonial">
                <p>"Amazing experience! The team at TravelEase made our vacation unforgettable."</p>
                <div class="author">- Dilmi Sanjana</div>
            </div>
            <div class="testimonial">
                <p>"Best travel agency I've worked with. Highly recommend their services."</p>
                <div class="author">- Koshitha Sampath</div>
            </div>
        </div>
        <div class="slider-controls">
            <button id="prevTestimonial"><i class="fas fa-chevron-left"></i></button>
            <button id="nextTestimonial"><i class="fas fa-chevron-right"></i></button>
        </div>
    </div>
</section>

<section id="contact" class="contact">
    <div class="container">
        <h2>Contact Us</h2>
        <div class="contact-container">
            <div class="contact-info">
                <h3>Get in Touch</h3>
                <p><i class="fas fa-map-marker-alt"></i> 234 Travel Street, Colombo City</p>
                <p><i class="fas fa-phone"></i> +94761384627</p>
                <p><i class="fas fa-envelope"></i> info@travelease.com</p>
            </div>
            <form class="contact-form">
                <input type="text" placeholder="Your Name" required>
                <input type="email" placeholder="Your Email" required>
                <textarea placeholder="Your Message" required></textarea>
                <button type="submit">Send Message</button>
            </form>
        </div>
    </div>
</section>

<footer>
    <div class="container">
        <div class="footer-content">
            <div class="footer-section">
                <h3>TravelEase</h3>
                <p>Your journey begins with us. We provide the best travel experiences around the globe.</p>
            </div>
            <div class="footer-section">
                <h3>Quick Links</h3>
                <ul>
                    <li><a href="#">Home</a></li>
                    <li><a href="packageManagement.jsp">Packages</a></li>
                    <li><a href="#destinations">Destinations</a></li>
                    <li><a href="#about">About Us</a></li>
                </ul>
            </div>
            <div class="footer-section">
                <h3>Follow Us</h3>
                <div class="social-icons">
                    <a href="#"><i class="fab fa-facebook"></i></a>
                    <a href="#"><i class="fab fa-twitter"></i></a>
                    <a href="#"><i class="fab fa-instagram"></i></a>
                    <a href="#"><i class="fab fa-linkedin"></i></a>
                </div>
            </div>
        </div>
        <div class="footer-bottom">
            <p>&copy; 2023 TravelEase. All rights reserved.</p>
        </div>
    </div>
</footer>

<!-- Modal for Login -->
<div class="modal" id="loginModal">
    <div class="modal-content">
        <span class="close">&times;</span>
        <h2>Login</h2>
        <form id="loginForm">
            <input type="email" placeholder="Email" required>
            <input type="password" placeholder="Password" required>
            <button type="submit">Login</button>
        </form>
        <p>Don't have an account? <a href="#" id="showRegister">Register</a></p>
    </div>
</div>

<!-- Modal for Registration -->
<div class="modal" id="registerModal">
    <div class="modal-content">
        <span class="close">&times;</span>
        <h2>Register</h2>
        <form id="registerForm">
            <input type="text" placeholder="Full Name" required>
            <input type="email" placeholder="Email" required>
            <input type="password" placeholder="Password" required>
            <input type="password" placeholder="Confirm Password" required>
            <button type="submit">Register</button>
        </form>
        <p>Already have an account? <a href="#" id="showLogin">Login</a></p>
    </div>
</div>

<script src="TravelPackage/js/script.js"></script>
</body>
</html>
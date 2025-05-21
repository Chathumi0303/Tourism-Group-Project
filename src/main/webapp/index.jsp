<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Explore World - Tourism Package Management</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            min-height: 100vh;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }

        header {
            background: linear-gradient(to right, #3a7bd5, #00d2ff);
            color: white;
            padding: 20px 0;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            position: relative;
            overflow: hidden;
            margin-bottom: 30px;
            animation: headerFade 1s ease-in-out;
        }

        @keyframes headerFade {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        header::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, rgba(255,255,255,0) 70%);
            animation: rotate 20s linear infinite;
        }

        @keyframes rotate {
            from {
                transform: rotate(0deg);
            }
            to {
                transform: rotate(360deg);
            }
        }

        .header-content {
            position: relative;
            z-index: 1;
            text-align: center;
        }

        nav {
            display: flex;
            justify-content: center;
            padding: 15px 0;
        }

        nav a {
            color: white;
            text-decoration: none;
            margin: 0 15px;
            font-weight: 500;
            position: relative;
            padding: 5px 0;
            transition: all 0.3s ease;
        }

        nav a::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 0;
            height: 2px;
            background-color: white;
            transition: width 0.3s ease;
        }

        nav a:hover::after {
            width: 100%;
        }

        .hero {
            text-align: center;
            padding: 60px 0;
            position: relative;
        }

        .hero h2 {
            font-size: 2.5rem;
            margin-bottom: 20px;
            color: #333;
            animation: slideUp 1s ease-out;
        }

        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .hero p {
            font-size: 1.2rem;
            color: #555;
            max-width: 700px;
            margin: 0 auto 30px;
            animation: slideUp 1s ease-out 0.2s both;
        }

        .search-bar {
            max-width: 600px;
            margin: 0 auto;
            display: flex;
            overflow: hidden;
            border-radius: 50px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            animation: slideUp 1s ease-out 0.4s both;
        }

        .search-bar input {
            flex: 1;
            padding: 15px 20px;
            border: none;
            outline: none;
            font-size: 1rem;
        }

        .search-bar button {
            padding: 15px 30px;
            background: linear-gradient(to right, #3a7bd5, #00d2ff);
            border: none;
            color: white;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .search-bar button:hover {
            background: linear-gradient(to right, #00d2ff, #3a7bd5);
        }

        .featured-packages {
            margin-top: 60px;
            animation: fadeIn 1s ease-out 0.6s both;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
            }
            to {
                opacity: 1;
            }
        }

        .section-title {
            text-align: center;
            margin-bottom: 30px;
            font-size: 2rem;
            color: #333;
            position: relative;
        }

        .section-title::after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 50%;
            transform: translateX(-50%);
            width: 100px;
            height: 3px;
            background: linear-gradient(to right, #3a7bd5, #00d2ff);
        }

        .package-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 30px;
        }

        .package-card {
            background: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
        }

        .package-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.2);
        }

        .package-image {
            height: 200px;
            background-size: cover;
            background-position: center;
            position: relative;
        }

        .package-price {
            position: absolute;
            top: 15px;
            right: 15px;
            background: linear-gradient(to right, #3a7bd5, #00d2ff);
            color: white;
            padding: 5px 15px;
            border-radius: 20px;
            font-weight: bold;
        }

        .package-content {
            padding: 20px;
        }

        .package-title {
            font-size: 1.2rem;
            margin-bottom: 10px;
            color: #333;
        }

        .package-description {
            color: #666;
            margin-bottom: 15px;
            font-size: 0.9rem;
        }

        .package-meta {
            display: flex;
            justify-content: space-between;
            color: #777;
            font-size: 0.9rem;
        }

        .view-btn {
            display: inline-block;
            margin-top: 15px;
            padding: 10px 20px;
            background: linear-gradient(to right, #3a7bd5, #00d2ff);
            color: white;
            border-radius: 5px;
            text-decoration: none;
            transition: all 0.3s ease;
        }

        .view-btn:hover {
            background: linear-gradient(to right, #00d2ff, #3a7bd5);
        }

        .cta-section {
            margin-top: 80px;
            text-align: center;
            padding: 60px 0;
            background: linear-gradient(135deg, rgba(58, 123, 213, 0.1) 0%, rgba(0, 210, 255, 0.1) 100%);
            border-radius: 10px;
            animation: fadeIn 1s ease-out 0.8s both;
        }

        .cta-section h3 {
            font-size: 2rem;
            margin-bottom: 20px;
            color: #333;
        }

        .cta-section p {
            max-width: 600px;
            margin: 0 auto 30px;
            color: #555;
        }

        .cta-buttons {
            display: flex;
            justify-content: center;
            gap: 20px;
        }

        .cta-btn {
            padding: 12px 30px;
            border-radius: 50px;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .primary-btn {
            background: linear-gradient(to right, #3a7bd5, #00d2ff);
            color: white;
        }

        .primary-btn:hover {
            background: linear-gradient(to right, #00d2ff, #3a7bd5);
        }

        .secondary-btn {
            background: white;
            color: #3a7bd5;
            border: 2px solid #3a7bd5;
        }

        .secondary-btn:hover {
            background: rgba(58, 123, 213, 0.1);
        }

        footer {
            margin-top: 80px;
            background: linear-gradient(to right, #3a7bd5, #00d2ff);
            color: white;
            padding: 40px 0;
            border-radius: 10px 10px 0 0;
        }

        .footer-content {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 40px;
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
        }

        .footer-section h4 {
            font-size: 1.2rem;
            margin-bottom: 20px;
            position: relative;
            padding-bottom: 10px;
        }

        .footer-section h4::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 50px;
            height: 2px;
            background: white;
        }

        .footer-section p, .footer-section a {
            color: rgba(255, 255, 255, 0.8);
            margin-bottom: 10px;
            display: block;
            text-decoration: none;
            transition: all 0.3s ease;
        }

        .footer-section a:hover {
            color: white;
            transform: translateX(5px);
        }

        .social-links {
            display: flex;
            gap: 15px;
            margin-top: 20px;
        }

        .social-links a {
            display: inline-block;
            width: 40px;
            height: 40px;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: all 0.3s ease;
        }

        .social-links a:hover {
            background: rgba(255, 255, 255, 0.2);
            transform: translateY(-5px);
        }

        .copyright {
            text-align: center;
            padding-top: 30px;
            margin-top: 30px;
            border-top: 1px solid rgba(255, 255, 255, 0.1);
            font-size: 0.9rem;
        }

        @media (max-width: 768px) {
            .hero h2 {
                font-size: 1.8rem;
            }

            .hero p {
                font-size: 1rem;
            }

            .package-grid {
                grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            }

            .footer-content {
                grid-template-columns: 1fr;
                text-align: center;
            }

            .footer-section h4::after {
                left: 50%;
                transform: translateX(-50%);
            }

            .social-links {
                justify-content: center;
            }

        }

        /* Animation for package cards */
        .package-card {
            opacity: 0;
            transform: translateY(20px);
            animation: cardAppear 0.5s ease-out forwards;
        }

        @keyframes cardAppear {
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .package-card:nth-child(1) { animation-delay: 0.6s; }
        .package-card:nth-child(2) { animation-delay: 0.8s; }
        .package-card:nth-child(3) { animation-delay: 1s; }
        .package-card:nth-child(4) { animation-delay: 1.2s; }
        .package-card:nth-child(5) { animation-delay: 1.4s; }
        .package-card:nth-child(6) { animation-delay: 1.6s; }
    </style>
</head>
<body>
<div class="container">
    <header>
        <div class="header-content">
            <h1>Explore World</h1>
            <p>Discover amazing destinations with our premium travel packages</p>
            <nav>
                <a href="index.jsp">Home</a>
                <a href="packages.jsp">Packages</a>
                <a href="destinations.jsp">Destinations</a>
                <a href="guides.jsp">Tour Guides</a>
                <a href="about.jsp">About Us</a>
                <a href="contact.jsp">Contact</a>
            </nav>
        </div>
    </header>

    <section class="hero">
        <h2>Your Journey Begins Here</h2>
        <p>Explore our handpicked selection of tourism packages designed to create unforgettable experiences with expert guides to make your trip memorable.</p>
        <div class="search-bar">
            <input type="text" placeholder="Search for destinations, packages, or guides...">
            <button type="submit">Search</button>
        </div>
    </section>

    <section class="featured-packages">
        <h3 class="section-title">Featured Packages</h3>
        <div class="package-grid">
            <%-- Ideally, these would be populated from a database using JSTL --%>
            <%-- Example of how you would use JSTL to loop through packages from a database --%>
            <%--
            <c:forEach var="package" items="${featuredPackages}">
                <div class="package-card">
                    <div class="package-image" style="background-image: url('${package.imageUrl}')">
                        <div class="package-price">$${package.price}</div>
                    </div>
                    <div class="package-content">
                        <h4 class="package-title">${package.title}</h4>
                        <p class="package-description">${package.description}</p>
                        <div class="package-meta">
                            <span>${package.duration} days</span>
                            <span>${package.groupSize} people</span>
                        </div>
                        <a href="package-details.jsp?id=${package.id}" class="view-btn">View Details</a>
                    </div>
                </div>
            </c:forEach>
            --%>

            <%-- Static examples for demonstration --%>
            <div class="package-card">
                <div class="package-image" style="background-image: url('images/paris.jpg')">
                    <div class="package-price">$1,299</div>
                </div>
                <div class="package-content">
                    <h4 class="package-title">Romantic Paris Getaway</h4>
                    <p class="package-description">Experience the magic of Paris with our premium package including Eiffel Tower visit and Seine River cruise.</p>
                    <div class="package-meta">
                        <span>7 days</span>
                        <span>Small group</span>
                    </div>
                    <a href="package-details.jsp?id=1" class="view-btn">View Details</a>
                </div>
            </div>

            <div class="package-card">
                <div class="package-image" style="background-image: url('images/bali.jpg')">
                    <div class="package-price">$1,499</div>
                </div>
                <div class="package-content">
                    <h4 class="package-title">Bali Beach Paradise</h4>
                    <p class="package-description">Relax on pristine beaches, visit ancient temples, and immerse yourself in Balinese culture.</p>
                    <div class="package-meta">
                        <span>10 days</span>
                        <span>All inclusive</span>
                    </div>
                    <a href="package-details.jsp?id=2" class="view-btn">View Details</a>
                </div>
            </div>

            <div class="package-card">
                <div class="package-image" style="background-image: url('images/tokyo.jpg')">
                    <div class="package-price">$1,899</div>
                </div>
                <div class="package-content">
                    <h4 class="package-title">Tokyo Adventure</h4>
                    <p class="package-description">Explore the vibrant city of Tokyo with expert guides, including visits to Mt. Fuji and traditional villages.</p>
                    <div class="package-meta">
                        <span>9 days</span>
                        <span>Cultural tour</span>
                    </div>
                    <a href="package-details.jsp?id=3" class="view-btn">View Details</a>
                </div>
            </div>

            <div class="package-card">
                <div class="package-image" style="background-image: url('images/safari.jpg')">
                    <div class="package-price">$2,499</div>
                </div>
                <div class="package-content">
                    <h4 class="package-title">African Safari</h4>
                    <p class="package-description">Witness the majestic wildlife of Africa on our premium safari tour with luxury accommodations.</p>
                    <div class="package-meta">
                        <span>12 days</span>
                        <span>Wildlife tour</span>
                    </div>
                    <a href="package-details.jsp?id=4" class="view-btn">View Details</a>
                </div>
            </div>

            <div class="package-card">
                <div class="package-image" style="background-image: url('images/santorini.jpg')">
                    <div class="package-price">$1,699</div>
                </div>
                <div class="package-content">
                    <h4 class="package-title">Greek Islands Cruise</h4>
                    <p class="package-description">Hop between the stunning Greek islands, enjoying crystal clear waters and authentic cuisine.</p>
                    <div class="package-meta">
                        <span>8 days</span>
                        <span>Island hopping</span>
                    </div>
                    <a href="package-details.jsp?id=5" class="view-btn">View Details</a>
                </div>
            </div>

            <div class="package-card">
                <div class="package-image" style="background-image: url('images/machu-picchu.jpg')">
                    <div class="package-price">$2,199</div>
                </div>
                <div class="package-content">
                    <h4 class="package-title">Peru & Machu Picchu</h4>
                    <p class="package-description">Trek to the ancient ruins of Machu Picchu and explore the rich culture of Peru.</p>
                    <div class="package-meta">
                        <span>11 days</span>
                        <span>Adventure tour</span>
                    </div>
                    <a href="package-details.jsp?id=6" class="view-btn">View Details</a>
                </div>
            </div>
        </div>
    </section>
    <jsp:include page="destinations-section.jsp"/>
    <section class="cta-section">
        <h3>Ready for Your Next Adventure?</h3>
        <p>Join thousands of satisfied travelers who have experienced our premium tourism packages and professional guide services.</p>
        <div class="cta-buttons">
            <a href="packages.jsp" class="cta-btn primary-btn">View All Packages</a>
            <a href="contact.jsp" class="cta-btn secondary-btn">Contact Us</a>
        </div>
    </section>

    <footer>
        <div class="footer-content">
            <div class="footer-section">
                <h4>About Us</h4>
                <p>Explore World is a premium tourism package provider with over 15 years of experience creating unforgettable travel experiences.</p>
                <div class="social-links">
                    <a href="#"><i class="fab fa-facebook-f"></i></a>
                    <a href="#"><i class="fab fa-twitter"></i></a>
                    <a href="#"><i class="fab fa-instagram"></i></a>
                    <a href="#"><i class="fab fa-pinterest"></i></a>
                </div>
            </div>

            <div class="footer-section">
                <h4>Useful Links</h4>
                <a href="about.jsp">About Us</a>
                <a href="services.jsp">Services</a>
                <a href="terms.jsp">Terms & Conditions</a>
                <a href="privacy.jsp">Privacy Policy</a>
            </div>

            <div class="footer-section">
                <h4>Contact Us</h4>
                <p>Email: info@exploreworld.com</p>
                <p>Phone: +1 (123) 456-7890</p>
                <p>Address: 123 Travel Street, Tourism City</p>
            </div>

            <div class="footer-section">
                <h4>Newsletter</h4>
                <p>Subscribe to our newsletter for the latest updates and offers.</p>
                <form action="newsletter-signup" method="post">
                    <input type="email" name="email" placeholder="Your email address" style="padding:10px; width:100%; margin-bottom:10px; border-radius:5px; border:none;">
                    <button type="submit" class="view-btn" style="width:100%;">Subscribe</button>
                </form>
            </div>
        </div>

        <div class="copyright">
            <p>&copy; <%= new java.util.Date().getYear() + 1900 %> Explore World. All rights reserved.</p>
        </div>
    </footer>
</div>

<%-- For the icon font used in social links --%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
</body>
</html>

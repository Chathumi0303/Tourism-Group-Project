document.addEventListener('DOMContentLoaded', function() {
    // Package data
    const packages = [
        {
            id: 1,
            title: "Tropical Paradise Getaway",
            description: "Enjoy 7 days in a luxury beachfront resort with all-inclusive amenities.",
            price: "RS.120,000",
            duration: "7 days",
            category: "beach",
            image: "https://images.unsplash.com/photo-1551524559-8af4e6624178"
        },
        {
            id: 2,
            title: "Sri Lankan Adventure",
            description: "Explore 4 European capitals in 10 days with guided tours and premium accommodations.",
            price: "RS.300,000",
            duration: "10 days",
            category: "city",
            image: "https://images.unsplash.com/photo-1499856871958-5b9627545d1a"
        },
        {
            id: 3,
            title: "Mountain Retreat",
            description: "5-day hiking experience in the Swiss Alps with cozy mountain lodges.",
            price: "RS.90,000",
            duration: "5 days",
            category: "mountain",
            image: "https://images.unsplash.com/photo-1519681393784-d120267933ba"
        },
        {
            id: 4,
            title: "Safari Expedition",
            description: "8-day African safari with wildlife viewing and luxury tent accommodations.",
            price: "RS.280,000",
            duration: "8 days",
            category: "adventure",
            image: "https://images.unsplash.com/photo-1523805009345-7448845a9e53"
        },
        {
            id: 5,
            title: "Ocean Cruise",
            description: "7-night cruise visiting 5 tropical islands with all meals included.",
            price: "RS.76,000",
            duration: "7 days",
            category: "beach",
            image: "https://images.unsplash.com/photo-1544551763-46a013bb70d5"
        },
        {
            id: 6,
            title: "Asian Cultural Tour",
            description: "12-day journey through Japan, South Korea, and China with cultural experiences.",
            price: "RS.350,000",
            duration: "12 days",
            category: "city",
            image: "https://images.unsplash.com/photo-1492571350019-22de08371fd3"
        },
        {
            id: 7,
            title: "Sigiriya Mountain Adventure",
            description: "6-day outdoor adventure including hiking, rafting, and camping.",
            price: "RS.42,000",
            duration: "6 days",
            category: "adventure",
            image: "https://images.unsplash.com/photo-1464822759023-fed622ff2c3b"
        },
        {
            id: 8,
            title: "Island Hopping in Greece",
            description: "9-day tour of Greek islands with luxury yacht accommodations.",
            price: "RS.45,000",
            duration: "9 days",
            category: "beach",
            image: "https://images.unsplash.com/photo-1533107862482-0e6974b06ec4"
        }
    ];

    // DOM Elements
    const packageContainer = document.getElementById('packageContainer');
    const filterButtons = document.querySelectorAll('.filter-btn');
    const loginBtn = document.getElementById('loginBtn');
    const registerBtn = document.getElementById('registerBtn');
    const loginModal = document.getElementById('loginModal');
    const registerModal = document.getElementById('registerModal');
    const closeButtons = document.querySelectorAll('.close');
    const showRegister = document.getElementById('showRegister');
    const showLogin = document.getElementById('showLogin');
    const testimonialSlides = document.querySelectorAll('.testimonial');
    const prevTestimonial = document.getElementById('prevTestimonial');
    const nextTestimonial = document.getElementById('nextTestimonial');
    let currentSlide = 0;

    // Initialize the page
    function init() {
        displayPackages('all');
        setupEventListeners();
        showTestimonial(currentSlide);
    }

    // Display packages based on filter
    function displayPackages(category) {
        packageContainer.innerHTML = '';

        const filteredPackages = category === 'all'
            ? packages
            : packages.filter(pkg => pkg.category === category);

        filteredPackages.forEach(pkg => {
            const packageCard = document.createElement('div');
            packageCard.className = 'package-card';
            packageCard.innerHTML = `
                <div class="package-img">
                    <img src="${pkg.image}" alt="${pkg.title}">
                </div>
                <div class="package-info">
                    <h3>${pkg.title}</h3>
                    <p>${pkg.description}</p>
                    <div class="package-meta">
                        <span class="package-price">${pkg.price}</span>
                        <span class="package-duration">
                            <i class="far fa-clock"></i> ${pkg.duration}
                        </span>
                    </div>
                    <div class="package-actions">
                        <button class="details-btn">Details</button>
                        <button class="book-btn">Book Now</button>
                    </div>
                </div>
            `;
            packageContainer.appendChild(packageCard);
        });

        // Add event listeners to new buttons
        document.querySelectorAll('.details-btn').forEach(btn => {
            btn.addEventListener('click', () => {
                alert('Package details would be shown here');
            });
        });

        document.querySelectorAll('.book-btn').forEach(btn => {
            btn.addEventListener('click', () => {
                alert('Booking process would start here');
            });
        });
    }

    // Setup event listeners
    function setupEventListeners() {
        // Filter buttons
        filterButtons.forEach(button => {
            button.addEventListener('click', () => {
                filterButtons.forEach(btn => btn.classList.remove('active'));
                button.classList.add('active');
                const filter = button.getAttribute('data-filter');
                displayPackages(filter);
            });
        });

        // Modal controls
        loginBtn.addEventListener('click', () => {
            loginModal.style.display = 'flex';
        });

        registerBtn.addEventListener('click', () => {
            registerModal.style.display = 'flex';
        });

        closeButtons.forEach(button => {
            button.addEventListener('click', () => {
                loginModal.style.display = 'none';
                registerModal.style.display = 'none';
            });
        });

        showRegister.addEventListener('click', (e) => {
            e.preventDefault();
            loginModal.style.display = 'none';
            registerModal.style.display = 'flex';
        });

        showLogin.addEventListener('click', (e) => {
            e.preventDefault();
            registerModal.style.display = 'none';
            loginModal.style.display = 'flex';
        });

        // Close modal when clicking outside
        window.addEventListener('click', (e) => {
            if (e.target === loginModal) {
                loginModal.style.display = 'none';
            }
            if (e.target === registerModal) {
                registerModal.style.display = 'none';
            }
        });

        // Form submissions
        document.getElementById('loginForm').addEventListener('submit', (e) => {
            e.preventDefault();
            alert('Login functionality would be implemented here');
            loginModal.style.display = 'none';
        });

        document.getElementById('registerForm').addEventListener('submit', (e) => {
            e.preventDefault();
            alert('Registration functionality would be implemented here');
            registerModal.style.display = 'none';
        });

        // Testimonial slider
        prevTestimonial.addEventListener('click', () => {
            currentSlide = (currentSlide - 1 + testimonialSlides.length) % testimonialSlides.length;
            showTestimonial(currentSlide);
        });

        nextTestimonial.addEventListener('click', () => {
            currentSlide = (currentSlide + 1) % testimonialSlides.length;
            showTestimonial(currentSlide);
        });

        // Auto-rotate testimonials
        setInterval(() => {
            currentSlide = (currentSlide + 1) % testimonialSlides.length;
            showTestimonial(currentSlide);
        }, 5000);
    }

    // Show testimonial slide
    function showTestimonial(index) {
        testimonialSlides.forEach(slide => {
            slide.classList.remove('active');
        });
        testimonialSlides[index].classList.add('active');
    }

    // Smooth scrolling for navigation links
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function(e) {
            e.preventDefault();

            const targetId = this.getAttribute('href');
            if (targetId === '#') return;

            const targetElement = document.querySelector(targetId);
            if (targetElement) {
                window.scrollTo({
                    top: targetElement.offsetTop - 70,
                    behavior: 'smooth'
                });
            }
        });
    });

    // Initialize the application
    init();
});
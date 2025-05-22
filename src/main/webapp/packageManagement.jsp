<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>TravelEase - Package Management</title>
    <style>
        /* Basic Reset */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background-color: #f5f5f5;
            color: #333;
            line-height: 1.6;
        }

        .container {
            width: 90%;
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 15px;
        }

        /* Header Styles */
        header {
            background-color: #2c3e50;
            color: white;
            padding: 20px 0;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }

        .logo {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .logo i {
            font-size: 24px;
        }

        .logo h1 {
            font-size: 24px;
            font-weight: 600;
        }

        nav ul {
            display: flex;
            list-style: none;
            gap: 20px;
        }

        nav a {
            color: white;
            text-decoration: none;
            font-weight: 500;
            transition: color 0.3s;
        }

        nav a:hover, nav a.active {
            color: #3498db;
        }

        .auth-buttons button {
            background-color: #e74c3c;
            color: white;
            border: none;
            padding: 8px 15px;
            border-radius: 4px;
            cursor: pointer;
            font-weight: 500;
            transition: background-color 0.3s;
        }

        .auth-buttons button:hover {
            background-color: #c0392b;
        }

        /* Main Content Styles */
        main {
            padding: 30px 0;
        }

        .package-management h2 {
            margin-bottom: 20px;
            color: #2c3e50;
            font-size: 28px;
        }

        .management-actions {
            margin-bottom: 20px;
        }

        .btn-primary {
            background-color: #3498db;
            color: white;
            border: none;
            padding: 10px 15px;
            border-radius: 4px;
            cursor: pointer;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 5px;
            transition: background-color 0.3s;
        }

        .btn-primary:hover {
            background-color: #2980b9;
        }

        /* Table Styles */
        .package-table-container {
            overflow-x: auto;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        .package-table {
            width: 100%;
            border-collapse: collapse;
        }

        .package-table th, .package-table td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #e0e0e0;
        }

        .package-table th {
            background-color: #f8f9fa;
            font-weight: 600;
            color: #2c3e50;
        }

        .package-table tr:hover {
            background-color: #f8f9fa;
        }

        .action-buttons {
            display: flex;
            gap: 10px;
        }

        .btn-edit, .btn-delete {
            padding: 6px 10px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 5px;
            transition: all 0.3s;
        }

        .btn-edit {
            background-color: #f39c12;
            color: white;
        }

        .btn-edit:hover {
            background-color: #d35400;
        }

        .btn-delete {
            background-color: #e74c3c;
            color: white;
        }

        .btn-delete:hover {
            background-color: #c0392b;
        }

        /* Modal Styles */
        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.5);
            overflow: auto;
        }

        .modal-content {
            background-color: white;
            margin: 5% auto;
            padding: 25px;
            border-radius: 8px;
            width: 90%;
            max-width: 600px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.3);
            position: relative;
        }

        .close {
            position: absolute;
            top: 15px;
            right: 20px;
            font-size: 24px;
            font-weight: bold;
            color: #aaa;
            cursor: pointer;
        }

        .close:hover {
            color: #333;
        }

        /* Form Styles */
        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: 500;
            color: #2c3e50;
        }

        .form-group input,
        .form-group select,
        .form-group textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
        }

        .form-group textarea {
            resize: vertical;
            min-height: 80px;
        }

        .form-actions {
            display: flex;
            justify-content: flex-end;
            gap: 10px;
            margin-top: 20px;
        }

        .btn-secondary {
            background-color: #95a5a6;
            color: white;
            border: none;
            padding: 10px 15px;
            border-radius: 4px;
            cursor: pointer;
            font-weight: 500;
            transition: background-color 0.3s;
        }

        .btn-secondary:hover {
            background-color: #7f8c8d;
        }

        .btn-danger {
            background-color: #e74c3c;
            color: white;
            border: none;
            padding: 10px 15px;
            border-radius: 4px;
            cursor: pointer;
            font-weight: 500;
            transition: background-color 0.3s;
        }

        .btn-danger:hover {
            background-color: #c0392b;
        }
    </style>
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
                <li><a href="index.jsp">Home</a></li>
                <li><a href="packageManagement.jsp" class="active">Manage Packages</a></li>
                <li><a href="#destinations">Destinations</a></li>
                <li><a href="#about">About</a></li>
                <li><a href="#contact">Contact</a></li>
            </ul>
        </nav>
        <div class="auth-buttons">
            <button id="logoutBtn">Logout</button>
        </div>
    </div>
</header>

<main class="container">
    <section class="package-management">
        <h2>Package Management</h2>

        <div class="management-actions">
            <button id="addPackageBtn" class="btn-primary">
                <i class="fas fa-plus"></i> Add New Package
            </button>
        </div>

        <div class="package-table-container">
            <table class="package-table">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Package Name</th>
                    <th>Destination</th>
                    <th>Duration</th>
                    <th>Price</th>
                    <th>Type</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="pkg" items="${packages}">
                    <tr>
                        <td>${pkg.id}</td>
                        <td>${pkg.name}</td>
                        <td>${pkg.destination}</td>
                        <td>${pkg.duration} days</td>
                        <td>$${pkg.price}</td>
                        <td>${pkg.type}</td>
                        <td class="action-buttons">
                            <button class="btn-edit" data-id="${pkg.id}">
                                <i class="fas fa-edit"></i> Edit
                            </button>
                            <button class="btn-delete" data-id="${pkg.id}">
                                <i class="fas fa-trash"></i> Delete
                            </button>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </section>
</main>

<!-- Add/Edit Package Modal -->
<div class="modal" id="packageModal">
    <div class="modal-content">
        <span class="close">&times;</span>
        <h2 id="modalTitle">Add New Package</h2>
        <form id="packageForm" action="PackageServlet" method="POST">
            <input type="hidden" id="packageId" name="packageId" value="">

            <div class="form-group">
                <label for="packageName">Package Name</label>
                <input type="text" id="packageName" name="packageName" required>
            </div>

            <div class="form-group">
                <label for="destination">Destination</label>
                <input type="text" id="destination" name="destination" required>
            </div>

            <div class="form-group">
                <label for="duration">Duration (days)</label>
                <input type="number" id="duration" name="duration" min="1" required>
            </div>

            <div class="form-group">
                <label for="price">Price ($)</label>
                <input type="number" id="price" name="price" min="0" step="0.01" required>
            </div>

            <div class="form-group">
                <label for="type">Package Type</label>
                <select id="type" name="type" required>
                    <option value="">Select Type</option>
                    <option value="Beach">Beach</option>
                    <option value="Mountain">Mountain</option>
                    <option value="City">City</option>
                    <option value="Adventure">Adventure</option>
                    <option value="Cultural">Cultural</option>
                </select>
            </div>

            <div class="form-group">
                <label for="description">Description</label>
                <textarea id="description" name="description" rows="4" required></textarea>
            </div>

            <div class="form-group">
                <label for="inclusions">Inclusions</label>
                <textarea id="inclusions" name="inclusions" rows="3" required></textarea>
            </div>

            <div class="form-group">
                <label for="imageUrl">Image URL</label>
                <input type="text" id="imageUrl" name="imageUrl" required>
            </div>

            <div class="form-actions">
                <button type="submit" class="btn-primary">Save Package</button>
                <button type="button" class="btn-secondary" id="cancelBtn">Cancel</button>
            </div>
        </form>
    </div>
</div>

<!-- Delete Confirmation Modal -->
<div class="modal" id="deleteModal">
    <div class="modal-content">
        <span class="close">&times;</span>
        <h2>Confirm Deletion</h2>
        <p>Are you sure you want to delete this package?</p>
        <form id="deleteForm" action="PackageServlet" method="POST">
            <input type="hidden" name="action" value="delete">
            <input type="hidden" id="deletePackageId" name="packageId" value="">
            <div class="form-actions">
                <button type="submit" class="btn-danger">Delete</button>
                <button type="button" class="btn-secondary" id="cancelDeleteBtn">Cancel</button>
            </div>
        </form>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Modal elements
        const packageModal = document.getElementById('packageModal');
        const deleteModal = document.getElementById('deleteModal');
        const addPackageBtn = document.getElementById('addPackageBtn');
        const cancelBtn = document.getElementById('cancelBtn');
        const cancelDeleteBtn = document.getElementById('cancelDeleteBtn');
        const closeButtons = document.querySelectorAll('.close');

        // Form elements
        const packageForm = document.getElementById('packageForm');
        const deleteForm = document.getElementById('deleteForm');
        const modalTitle = document.getElementById('modalTitle');
        const packageIdInput = document.getElementById('packageId');

        // Show add package modal
        addPackageBtn.addEventListener('click', function() {
            modalTitle.textContent = 'Add New Package';
            packageIdInput.value = '';
            packageForm.reset();
            packageForm.action = 'PackageServlet?action=insert';
            packageModal.style.display = 'block';
        });

        // Show edit package modal (dynamically added buttons)
        document.addEventListener('click', function(e) {
            if (e.target.classList.contains('btn-edit') ||
                (e.target.parentElement && e.target.parentElement.classList.contains('btn-edit'))) {
                const button = e.target.classList.contains('btn-edit') ? e.target : e.target.parentElement;
                const packageId = button.getAttribute('data-id');

                // In a real application, you would fetch the package details via AJAX
                // For now, we'll redirect to the servlet which will handle the edit form
                window.location.href = 'PackageServlet?action=edit&id=' + packageId;
            }

            if (e.target.classList.contains('btn-delete') ||
                (e.target.parentElement && e.target.parentElement.classList.contains('btn-delete'))) {
                const button = e.target.classList.contains('btn-delete') ? e.target : e.target.parentElement;
                const packageId = button.getAttribute('data-id');
                document.getElementById('deletePackageId').value = packageId;
                deleteModal.style.display = 'block';
            }
        });

        // Close modals
        function closeModals() {
            packageModal.style.display = 'none';
            deleteModal.style.display = 'none';
        }

        cancelBtn.addEventListener('click', closeModals);
        cancelDeleteBtn.addEventListener('click', closeModals);

        closeButtons.forEach(button => {
            button.addEventListener('click', closeModals);
        });

        // Close modal when clicking outside of it
        window.addEventListener('click', function(event) {
            if (event.target === packageModal || event.target === deleteModal) {
                closeModals();
            }
        });

        // Logout button
        document.getElementById('logoutBtn').addEventListener('click', function() {
            window.location.href = 'logout.jsp';
        });

        // If we're in edit mode, populate the form with existing data
        <c:if test="${not empty package}">
        document.addEventListener('DOMContentLoaded', function() {
            modalTitle.textContent = 'Edit Package';
            packageIdInput.value = '${package.id}';
            document.getElementById('packageName').value = '${package.name}';
            document.getElementById('destination').value = '${package.destination}';
            document.getElementById('duration').value = '${package.duration}';
            document.getElementById('price').value = '${package.price}';
            document.getElementById('type').value = '${package.type}';
            document.getElementById('description').value = '${package.description}';
            document.getElementById('inclusions').value = '${package.inclusions}';
            document.getElementById('imageUrl').value = '${package.imageUrl}';
            packageForm.action = 'PackageServlet?action=update';
            packageModal.style.display = 'block';
        });
        </c:if>
    });
</script>
</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Travel Destinations Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #3498db;
            --secondary-color: #2c3e50;
            --accent-color: #e74c3c;
            --light-color: #ecf0f1;
        }
        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .header {
            background: linear-gradient(135deg, var(--secondary-color), var(--primary-color));
            color: white;
            padding: 2rem 0;
            margin-bottom: 2rem;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }
        .card {
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.05);
            transition: transform 0.3s ease;
            margin-bottom: 2rem;
        }
        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 12px rgba(0,0,0,0.1);
        }
        .table-responsive {
            border-radius: 8px;
            overflow: hidden;
        }
        .table {
            margin-bottom: 0;
        }
        .table th {
            background-color: var(--secondary-color);
            color: white;
            font-weight: 500;
        }
        .action-btn {
            padding: 5px 10px;
            border-radius: 5px;
            transition: all 0.2s;
            margin: 0 3px;
        }
        .edit-btn {
            color: var(--primary-color);
            border: 1px solid var(--primary-color);
        }
        .edit-btn:hover {
            background-color: var(--primary-color);
            color: white;
        }
        .delete-btn {
            color: var(--accent-color);
            border: 1px solid var(--accent-color);
        }
        .delete-btn:hover {
            background-color: var(--accent-color);
            color: white;
        }
        .create-btn {
            background-color: var(--primary-color);
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            font-weight: 500;
            transition: all 0.2s;
        }
        .create-btn:hover {
            background-color: #2980b9;
            transform: translateY(-2px);
        }
        .search-box {
            position: relative;
            margin-bottom: 1.5rem;
        }
        .search-box i {
            position: absolute;
            top: 12px;
            left: 15px;
            color: #7f8c8d;
        }
        .search-box input {
            padding-left: 40px;
            border-radius: 25px;
            border: 1px solid #ddd;
            box-shadow: none;
        }
        .destination-image {
            width: 80px;
            height: 60px;
            object-fit: cover;
            border-radius: 5px;
        }
    </style>
</head>
<body>
<div class="header">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-md-8">
                <h1><i class="fas fa-map-marked-alt me-2"></i> Travel Destinations Admin</h1>
                <p class="mb-0">Manage all your travel destinations in one place</p>
            </div>
            <div class="col-md-4 text-end">
                <button class="create-btn" onclick="location.href='/tourismpackage_war_exploded/create'">
                    <i class="fas fa-plus me-2"></i>Create New
                </button>
            </div>
        </div>
    </div>
</div>


<div class="container">
    <div class="card">
        <div class="card-body">
            <div class="search-box">
                <i class="fas fa-search"></i>
                <input type="text" id="searchInput" class="form-control" placeholder="Search destinations..."
                       onkeyup="filterDestinations()">
            </div>

            <div class="table-responsive">
                <table class="table table-hover" id="destinationsTable">
                    <thead>
                    <tr>
                        <th>Image</th>
                        <th>Name</th>
                        <th>Location</th>
                        <th>Description</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody id="destinationsTableBody">
                    <!-- Destinations will be loaded here via JavaScript -->
                    </tbody>
                </table>
            </div>

            <div class="text-center mt-3" id="loadingIndicator">
                <div class="spinner-border text-primary" role="status">
                    <span class="visually-hidden">Loading...</span>
                </div>
                <p class="mt-2">Loading destinations...</p>
            </div>

            <div class="alert alert-warning text-center d-none" id="noResults">
                <i class="fas fa-exclamation-circle me-2"></i>No destinations found matching your search.
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Load destinations when page loads
    document.addEventListener('DOMContentLoaded', function() {
        fetchDestinations();
    });

    // Fetch destinations from API
    function fetchDestinations() {
        fetch('/tourismpackage_war_exploded/api/destinations')
            .then(response => {
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                return response.json();
            })
            .then(data => {
                displayDestinations(data);
                document.getElementById('loadingIndicator').classList.add('d-none');
            })
            .catch(error => {
                console.error('Error fetching destinations:', error);
                document.getElementById('loadingIndicator').innerHTML =
                    '<div class="alert alert-danger">Failed to load destinations. Please try again later.</div>';
            });
    }

    // Display destinations in table
    function displayDestinations(destinations) {
        const tableBody = document.getElementById('destinationsTableBody');
        tableBody.innerHTML = '';

        if (destinations.length === 0) {
            document.getElementById('noResults').classList.remove('d-none');
            return;
        }

        destinations.forEach(destination => {
            const row = document.createElement('tr');
            row.innerHTML =
                "<td>" +
                "<img src=\"" + (destination.image || 'https://via.placeholder.com/80x60?text=No+Image') + "\" " +
                "alt=\"" + destination.name + "\" class=\"destination-image\">" +
                "</td>" +
                "<td>" + destination.name + "</td>" +
                "<td>" + destination.location + "</td>" +
                "<td>" +
                (destination.description.substring(0, 50) +
                    (destination.description.length > 50 ? '...' : '')) +
                "</td>" +
                "<td>" +
                "<button class=\"btn btn-sm action-btn edit-btn\" " +
                "onclick=\"window.location.href='/tourismpackage_war_exploded/edit?id=" + destination.id + "'\">" +
                "<i class=\"fas fa-edit\"></i> Edit" +
                "</button>" +
                "<button class=\"btn btn-sm action-btn delete-btn\" " +
                "onclick=\"deleteDestination('" + destination.id + "')\">" +
                "<i class=\"fas fa-trash-alt\"></i> Delete" +
                "</button>" +
                "</td>";
            tableBody.appendChild(row);
        });
    }

    // Filter destinations based on search input
    function filterDestinations() {
        const input = document.getElementById('searchInput').value.toLowerCase();
        const rows = document.querySelectorAll('#destinationsTableBody tr');
        let hasResults = false;

        rows.forEach(row => {
            const name = row.cells[1].textContent.toLowerCase();
            const location = row.cells[2].textContent.toLowerCase();
            const description = row.cells[3].textContent.toLowerCase();

            if (name.includes(input) || location.includes(input) || description.includes(input)) {
                row.style.display = '';
                hasResults = true;
            } else {
                row.style.display = 'none';
            }
        });

        const noResultsDiv = document.getElementById('noResults');
        if (hasResults) {
            noResultsDiv.classList.add('d-none');
        } else {
            noResultsDiv.classList.remove('d-none');
        }
    }

    // Delete destination
    function deleteDestination(id) {
        if (confirm('Are you sure you want to delete this destination?')) {
            fetch(`/tourismpackage_war_exploded/api/destinations/`+id, {
                method: 'DELETE'
            })
                .then(response => {
                    if (response.ok) {
                        // Refresh the table after deletion
                        fetchDestinations();
                    } else {
                        alert('Failed to delete destination');
                    }
                })
                .catch(error => {
                    console.error('Error deleting destination:', error);
                    alert('Error deleting destination');
                });
        }
    }
</script>
</body>
</html>

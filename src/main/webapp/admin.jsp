<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Tour Packages</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        .package-row:hover {
            background-color: #f8fafc;
            transform: translateY(-1px);
        }
    </style>
</head>
<body class="bg-gray-50">
<div class="container mx-auto px-4 py-8">
    <div class="flex justify-between items-center mb-8">
        <h1 class="text-3xl font-bold text-gray-800">Tour Packages</h1>
        <a href="/tourismpackage_war_exploded/admin?action=create"
           class="bg-blue-600 hover:bg-blue-700 text-white px-4 py-2 rounded-lg flex items-center gap-2 transition-colors">
            <i class="fas fa-plus"></i> Create Package
        </a>
    </div>

    <div class="bg-white rounded-lg shadow overflow-hidden">
        <table class="min-w-full divide-y divide-gray-200">
            <thead class="bg-gray-50">
            <tr>
                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">ID</th>
                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Name</th>
                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Description</th>
                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Price</th>
                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Features</th>
                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Actions</th>
            </tr>
            </thead>
            <tbody id="packagesTable" class="bg-white divide-y divide-gray-200">
            <!-- Packages will be loaded here -->
            </tbody>
        </table>
    </div>
</div>

<script>
    // Fetch packages when page loads
    document.addEventListener('DOMContentLoaded', function() {
        fetchPackages();
    });

    // Fetch packages from API
    function fetchPackages() {
        fetch('/tourismpackage_war_exploded/packages')
            .then(response => response.json())
            .then(data => {
                const tableBody = document.getElementById('packagesTable');
                tableBody.innerHTML = '';

                if (data.length === 0) {
                    tableBody.innerHTML = `
                        <tr>
                            <td colspan="6" class="px-6 py-4 text-center text-gray-500">
                                No packages found
                            </td>
                        </tr>
                    `;
                    return;
                }

                data.forEach(pkg => {
                    const row = document.createElement('tr');
                    row.className = 'package-row transition-all';
                    row.innerHTML =
                        "<td class=\"px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900\">" + pkg.id + "</td>" +
                        "<td class=\"px-6 py-4 whitespace-nowrap text-sm text-gray-500\">" + pkg.name + "</td>" +
                        "<td class=\"px-6 py-4 text-sm text-gray-500 max-w-xs truncate\">" + pkg.description + "</td>" +
                        "<td class=\"px-6 py-4 whitespace-nowrap text-sm text-gray-500\">$" + pkg.price.toFixed(2) + "</td>" +
                        "<td class=\"px-6 py-4 text-sm text-gray-500\">" +
                        "<div class=\"flex flex-wrap gap-1\">";
                    for (var i = 0; i < pkg.features.length; i++) {
                        row.innerHTML +=
                            "<span class=\"bg-blue-100 text-blue-800 text-xs px-2 py-1 rounded\">" +
                            pkg.features[i] +
                            "</span>";
                    }
                    row.innerHTML +=
                        "</div>" +
                        "</td>" +
                        "<td class=\"px-6 py-4 whitespace-nowrap text-sm font-medium\">" +
                        "<a href=\"/tourismpackage_war_exploded/admin?action=edit&id=" + pkg.id + "\" " +
                        "class=\"text-yellow-600 hover:text-yellow-900 mr-3\">" +
                        "<i class=\"fas fa-edit\"></i> Edit" +
                        "</a>" +
                        "<button onclick=\"deletePackage('" + pkg.id + "')\" " +
                        "class=\"text-red-600 hover:text-red-900\">" +
                        "<i class=\"fas fa-trash\"></i> Delete" +
                        "</button>" +
                        "</td>";
                    tableBody.appendChild(row);
                });
            })
            .catch(error => {
                console.error('Error fetching packages:', error);
                const tableBody = document.getElementById('packagesTable');
                tableBody.innerHTML = `
                    <tr>
                        <td colspan="6" class="px-6 py-4 text-center text-red-500">
                            Error loading packages. Please try again.
                        </td>
                    </tr>
                `;
            });
    }

    // Delete package with confirmation
    function deletePackage(id) {
        if (confirm('Are you sure you want to delete this package?')) {
            fetch(`/tourismpackage_war_exploded/packages/`+id, {
                method: 'DELETE'
            })
                .then(response => {
                    if (response.ok) {
                        fetchPackages(); // Refresh the table
                    } else {
                        alert('Failed to delete package');
                    }
                })
                .catch(error => {
                    console.error('Error deleting package:', error);
                    alert('Error deleting package');
                });
        }
    }
</script>
</body>
</html>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tour Guides Management</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.25/jspdf.plugin.autotable.min.js"></script>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
</head>
<body class="bg-gray-100 p-6">
<div class="max-w-7xl mx-auto bg-white p-6 rounded-lg shadow-md">
    <div class="flex justify-between items-center mb-6">
        <h1 class="text-2xl font-bold text-gray-800">Tour Guides Management</h1>
        <div class="flex gap-4">
            <a href="/tourismpackage_war_exploded/admin?action=create" class="bg-green-600 hover:bg-green-700 text-white font-medium py-2 px-4 rounded-md transition flex items-center">
                <i class="fas fa-plus mr-2"></i> Create Guide
            </a>
            <button id="generatePDF" class="bg-red-600 hover:bg-red-700 text-white font-medium py-2 px-4 rounded-md transition flex items-center">
                <i class="fas fa-file-pdf mr-2"></i> Generate PDF
            </button>
        </div>
    </div>

    <div class="mb-6">
        <div class="relative">
            <input type="text" id="searchInput" placeholder="Search guides..." class="w-full border border-gray-300 rounded-md py-2 px-4 pl-10 focus:outline-none focus:ring-2 focus:ring-blue-500">
            <i class="fas fa-search absolute left-3 top-3 text-gray-400"></i>
        </div>
    </div>

    <div class="overflow-x-auto">
        <table class="min-w-full bg-white" id="guidesTable">
            <thead class="bg-gray-100">
            <tr>
                <th class="text-left py-3 px-4 font-semibold text-gray-700">Image</th>
                <th class="text-left py-3 px-4 font-semibold text-gray-700">Name</th>
                <th class="text-left py-3 px-4 font-semibold text-gray-700">Contact Number</th>
                <th class="text-left py-3 px-4 font-semibold text-gray-700">Description</th>
                <th class="text-center py-3 px-4 font-semibold text-gray-700">Actions</th>
            </tr>
            </thead>
            <tbody id="guidesTableBody">
            <!-- Data will be loaded here -->
            </tbody>
        </table>
    </div>

    <div id="noResults" class="hidden text-center py-4 text-gray-500">
        No guides found matching your search.
    </div>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        // Fetch guides data
        fetchGuides();

        // Search functionality
        document.getElementById("searchInput").addEventListener("input", filterGuides);

        // PDF generation
        document.getElementById("generatePDF").addEventListener("click", generatePDF);
    });

    async function fetchGuides() {
        try {
            const response = await fetch("/tourismpackage_war_exploded/api/guides");
            const guides = await response.json();
            renderGuides(guides);
            window.allGuides = guides; // Store guides for filtering
        } catch (error) {
            console.error("Error fetching guides:", error);
            document.getElementById("guidesTableBody").innerHTML = "<tr><td colspan='5' class='text-center py-4 text-red-500'>Error loading guides</td></tr>";
        }
    }

    function renderGuides(guides) {
        const tableBody = document.getElementById("guidesTableBody");

        if (guides.length === 0) {
            document.getElementById("noResults").classList.remove("hidden");
            tableBody.innerHTML = "";
            return;
        }

        document.getElementById("noResults").classList.add("hidden");
        tableBody.innerHTML = guides.map(guide =>
            "<tr class=\"border-b hover:bg-gray-50\">" +
            "<td class=\"py-3 px-4\">" +
            "<img src=\"" + guide.image + "\" alt=\"" + guide.name + "\" class=\"w-16 h-16 object-cover rounded-full\">" +
            "</td>" +
            "<td class=\"py-3 px-4\">" + guide.name + "</td>" +
            "<td class=\"py-3 px-4\">" + guide.contactNumber + "</td>" +
            "<td class=\"py-3 px-4 max-w-xs truncate\">" + guide.description + "</td>" +
            "<td class=\"py-3 px-4 text-center\">" +
            "<div class=\"flex justify-center space-x-3\">" +
            "<a href=\"/tourismpackage_war_exploded/admin?action=edit&tourGuideId=" + guide.id + "\" class=\"text-blue-600 hover:text-blue-800\">" +
            "<i class=\"fas fa-edit text-lg\"></i>" +
            "</a>" +
            "<button onclick=\"deleteGuide('" + guide.id + "')\" class=\"text-red-600 hover:text-red-800\">" +
            "<i class=\"fas fa-trash-alt text-lg\"></i>" +
            "</button>" +
            "</div>" +
            "</td>" +
            "</tr>"
        ).join("");

    }

    function filterGuides() {
        const searchTerm = document.getElementById("searchInput").value.toLowerCase();
        const filteredGuides = window.allGuides.filter(guide =>
            guide.name.toLowerCase().includes(searchTerm) ||
            guide.contactNumber.includes(searchTerm) ||
            guide.description.toLowerCase().includes(searchTerm)
        );

        renderGuides(filteredGuides);
    }

    function deleteGuide(guideId) {
        if (confirm("Are you sure you want to delete this guide?")) {
            // Send DELETE request
            fetch(`/tourismpackage_war_exploded/api/guides/`+guideId, {
                method: "DELETE"
            })
                .then(response => {
                    if (response.ok) {
                        // Refresh guides list
                        fetchGuides();
                    } else {
                        alert("Failed to delete guide");
                    }
                })
                .catch(error => {
                    console.error("Error deleting guide:", error);
                    alert("An error occurred while deleting the guide");
                });
        }
    }

    function generatePDF() {
        const { jsPDF } = window.jspdf;
        const doc = new jsPDF();

        // Add title
        doc.setFontSize(18);
        doc.text("Tour Guides List", 14, 22);

        // Create table data
        const tableColumn = ["Name", "Contact Number", "Description"];
        const tableRows = [];

        window.allGuides.forEach(guide => {
            const guideData = [
                guide.name,
                guide.contactNumber,
                guide.description.substring(0, 50) + (guide.description.length > 50 ? "..." : "")
            ];
            tableRows.push(guideData);
        });

        // Generate the table
        doc.autoTable({
            head: [tableColumn],
            body: tableRows,
            startY: 30,
            styles: {
                fontSize: 10,
                cellPadding: 3,
                overflow: "linebreak"
            },
            columnStyles: {
                0: { cellWidth: 50 },
                1: { cellWidth: 40 },
                2: { cellWidth: 100 }
            }
        });

        // Save the PDF
        doc.save("tour-guides-list.pdf");
    }
</script>
</body>
</html>
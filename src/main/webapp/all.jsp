
<script src="https://cdn.tailwindcss.com"></script>
<div class="container mx-auto px-4 py-8">
    <div id="packages-container" class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6">

    </div>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        // Fetch packages from the API
        fetch("http://localhost:8080/tourismpackage_war_exploded/packages")
            .then(function(response) {
                if (!response.ok) {
                    throw new Error("Network response was not ok");
                }
                return response.json();
            })
            .then(function(data) {
                displayPackages(data);
            })
            .catch(function(error) {
                console.error("Error fetching packages:", error);
                document.getElementById("packages-container").innerHTML =
                    "<div class=\"col-span-full p-4 bg-red-100 text-red-700 rounded\">Failed to load packages. Please try again later.</div>";
            });
    });

    function displayPackages(packages) {
        const container = document.getElementById("packages-container");

        if (packages.length === 0) {
            container.innerHTML = "<div class=\"col-span-full p-4 bg-blue-50 text-blue-700 rounded\">No packages available at the moment.</div>";
            return;
        }

        let packagesHTML = "";

        packages.forEach(function(pkg) {
            const featuresList = pkg.features.map(function(feature) {
                return "<li class=\"flex items-center\"><i class=\"fas fa-check-circle text-blue-500 mr-2\"></i>" + feature + "</li>";
            }).join("");

            packagesHTML +=
                "<div class=\"bg-gradient-to-br from-blue-50 to-blue-100 rounded-lg shadow-md overflow-hidden hover:shadow-lg transition-shadow duration-300\">" +
                "<div class=\"p-6\">" +
                "<h3 class=\"text-xl font-semibold text-blue-800 mb-2\">" + pkg.name + "</h3>" +
                "<p class=\"text-gray-600 mb-4\">" + pkg.description + "</p>" +
                "<div class=\"text-2xl font-bold text-blue-600 mb-4\">$" + pkg.price.toFixed(2) + "</div>" +
                "<div class=\"border-t border-blue-200 pt-4\">" +
                "<h4 class=\"text-sm font-semibold text-blue-700 mb-2\">Features:</h4>" +
                "<ul class=\"text-gray-600 space-y-1\">" + featuresList + "</ul>" +
                "</div>" +
                "</div>" +
                "</div>";


        });

        container.innerHTML = packagesHTML.replace(/`/g, "'");
    }
</script>
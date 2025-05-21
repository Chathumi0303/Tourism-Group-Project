<style>

    .featured-destinations {
        padding: 2rem;
        background-color: #f9f9f9;
    }
    .destination-grid {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
        gap: 1.5rem;
    }
    .destination-card {
        background-color: white;
        border-radius: 10px;
        overflow: hidden;
        box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    }
    .destination-image {
        position: relative;
        height: 200px;
        background-size: cover;
        background-position: center;
    }
    .destination-location {
        position: absolute;
        bottom: 0;
        right: 0;
        background: rgba(0,0,0,0.6);
        color: white;
        padding: 0.5rem;
        font-size: 0.85rem;
    }
    .destination-content {
        padding: 1rem;
    }
    .destination-title {
        margin: 0 0 0.5rem;
        font-size: 1.2rem;
    }
    .destination-description {
        font-size: 0.95rem;
        color: #555;
    }
    .view-btn {
        display: inline-block;
        margin-top: 0.75rem;
        padding: 0.5rem 1rem;
        background-color: #007bff;
        color: white;
        border-radius: 4px;
        text-decoration: none;
    }
    .view-btn:hover {
        background-color: #0056b3;
    }
</style>

<section class="featured-destinations">
    <h3 class="section-title">Top Destinations</h3>
    <div class="destination-grid" id="destinationContainer">
        <!-- Dynamic content will be injected here -->
    </div>
</section>

<script>
    fetch("/tourismpackage_war_exploded/api/destinations")
        .then(function(response) {
            return response.json();
        })
        .then(function(data) {
            var container = document.getElementById("destinationContainer");
            data.forEach(function(dest) {
                var card = document.createElement("div");
                card.className = "destination-card";
                card.innerHTML =
                    "<div class='destination-image' style=\"background-image: url('" + dest.image + "')\">" +
                    "<div class='destination-location'>" + dest.location + "</div>" +
                    "</div>" +
                    "<div class='destination-content'>" +
                    "<h4 class='destination-title'>" + dest.name + "</h4>" +
                    "<p class='destination-description'>" + dest.description + "</p>" +
                    "</div>";
                container.appendChild(card);
            });
        })
        .catch(function(error) {
            console.error("Error fetching destinations:", error);
        });
</script>

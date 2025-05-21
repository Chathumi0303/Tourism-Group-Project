<section class="featured-packages">
  <h3 class="section-title">Our Expert Tour Guides</h3>
  <div class="package-grid" id="guides-container">
    <!-- Guides will be loaded here dynamically -->
  </div>
</section>

<script>
  document.addEventListener('DOMContentLoaded', function() {
    fetch('http://localhost:8080/tourismpackage_war_exploded/api/guides')
            .then(response => {
              if (!response.ok) {
                throw new Error('Network response was not ok');
              }
              return response.json();
            })
            .then(guides => {
              const container = document.getElementById('guides-container');

              if (guides.length === 0) {
                container.innerHTML = '<p>No tour guides available at the moment.</p>';
                return;
              }

              guides.forEach(guide => {
                const guideCard = document.createElement('div');
                guideCard.className = 'package-card';

                guideCard.innerHTML =
                        "<div class=\"package-image\" style=\"background-image: url('" + (guide.image || 'images/default-guide.jpg') + "')\">" +
                        "<div class=\"package-price\">" + guide.contactNumber + "</div>" +
                        "</div>" +
                        "<div class=\"package-content\">" +
                        "<h4 class=\"package-title\">" + guide.name + "</h4>" +
                        "<p class=\"package-description\">" + (guide.description || 'Experienced tour guide ready to show you the best sights.') + "</p>" +
                        "<div class=\"package-meta\">" +
                        "<span>Contact for details</span>" +
                        "</div>" +
                        "</div>";

                container.appendChild(guideCard);
              });
            })
            .catch(error => {
              console.error('Error fetching tour guides:', error);
              document.getElementById('guides-container').innerHTML =
                      '<p>Unable to load tour guides at this time. Please try again later.</p>';
            });
  });
</script>
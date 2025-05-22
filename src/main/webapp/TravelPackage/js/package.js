document.addEventListener('DOMContentLoaded', function() {
    // Modal elements
    const packageModal = document.getElementById('packageModal');
    const deleteModal = document.getElementById('deleteModal');
    const addPackageBtn = document.getElementById('addPackageBtn');
    const cancelBtn = document.getElementById('cancelBtn');
    const cancelDeleteBtn = document.getElementById('cancelDeleteBtn');
    const packageForm = document.getElementById('packageForm');
    const deleteForm = document.getElementById('deleteForm');
    const modalTitle = document.getElementById('modalTitle');

    // Close modals when clicking X
    document.querySelectorAll('.close').forEach(closeBtn => {
        closeBtn.addEventListener('click', function() {
            packageModal.style.display = 'none';
            deleteModal.style.display = 'none';
        });
    });

    // Open add package modal
    addPackageBtn.addEventListener('click', function() {
        modalTitle.textContent = 'Add New Package';
        packageForm.reset();
        document.getElementById('packageId').value = '';
        packageModal.style.display = 'block';
    });

    // Cancel buttons
    cancelBtn.addEventListener('click', function() {
        packageModal.style.display = 'none';
    });

    cancelDeleteBtn.addEventListener('click', function() {
        deleteModal.style.display = 'none';
    });

    // Edit package buttons
    document.querySelectorAll('.btn-edit').forEach(btn => {
        btn.addEventListener('click', function() {
            const packageId = this.getAttribute('data-id');
            // In a real application, you would fetch the package data here
            // For now, we'll just set the ID and show the modal
            modalTitle.textContent = 'Edit Package';
            document.getElementById('packageId').value = packageId;

            // Simulate fetching package data (replace with actual AJAX call)
            const packageData = {
                name: 'Sample Package ' + packageId,
                destination: 'Sample Destination',
                duration: 7,
                price: 999.99,
                type: 'Beach',
                description: 'Sample package description',
                inclusions: 'Flight, Hotel, Breakfast',
                imageUrl: 'https://example.com/image.jpg'
            };

            // Fill the form with the package data
            document.getElementById('packageName').value = packageData.name;
            document.getElementById('destination').value = packageData.destination;
            document.getElementById('duration').value = packageData.duration;
            document.getElementById('price').value = packageData.price;
            document.getElementById('type').value = packageData.type;
            document.getElementById('description').value = packageData.description;
            document.getElementById('inclusions').value = packageData.inclusions;
            document.getElementById('imageUrl').value = packageData.imageUrl;

            packageModal.style.display = 'block';
        });
    });

    // Delete package buttons
    document.querySelectorAll('.btn-delete').forEach(btn => {
        btn.addEventListener('click', function() {
            const packageId = this.getAttribute('data-id');
            document.getElementById('deletePackageId').value = packageId;
            deleteModal.style.display = 'block';
        });
    });

    // Close modals when clicking outside
    window.addEventListener('click', function(event) {
        if (event.target === packageModal) {
            packageModal.style.display = 'none';
        }
        if (event.target === deleteModal) {
            deleteModal.style.display = 'none';
        }
    });

    // Form submission (you would replace this with actual form submission logic)
    packageForm.addEventListener('submit', function(e) {
        e.preventDefault();
        // In a real application, you would submit the form via AJAX or let it submit normally
        alert('Package saved successfully!');
        packageModal.style.display = 'none';
        // Reload the page or update the table dynamically
        window.location.reload();
    });

    deleteForm.addEventListener('submit', function(e) {
        e.preventDefault();
        // In a real application, you would submit the form via AJAX or let it submit normally
        alert('Package deleted successfully!');
        deleteModal.style.display = 'none';
        // Reload the page or update the table dynamically
        window.location.reload();
    });

    // Logout button
    document.getElementById('logoutBtn').addEventListener('click', function() {
        // In a real application, you would handle logout here
        window.location.href = 'index.jsp';
    });
});
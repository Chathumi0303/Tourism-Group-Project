<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create New Destination</title>
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
            margin-bottom: 2rem;
        }
        .form-control, .form-select {
            border-radius: 8px;
            padding: 12px;
            border: 1px solid #ddd;
        }
        .form-label {
            font-weight: 500;
            color: var(--secondary-color);
        }
        .submit-btn {
            background-color: var(--primary-color);
            color: white;
            border: none;
            padding: 12px 24px;
            border-radius: 8px;
            font-weight: 500;
            transition: all 0.2s;
        }
        .submit-btn:hover {
            background-color: #2980b9;
            transform: translateY(-2px);
        }
        .cancel-btn {
            background-color: #95a5a6;
            color: white;
            border: none;
            padding: 12px 24px;
            border-radius: 8px;
            font-weight: 500;
            transition: all 0.2s;
        }
        .cancel-btn:hover {
            background-color: #7f8c8d;
            transform: translateY(-2px);
        }
        .image-preview {
            width: 200px;
            height: 150px;
            object-fit: cover;
            border-radius: 8px;
            border: 2px dashed #ddd;
            display: none;
        }
    </style>
</head>
<body>
<div class="header">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-md-12">
                <h1><i class="fas fa-plus-circle me-2"></i> Create New Destination</h1>
                <p class="mb-0">Add a new travel destination to your collection</p>
            </div>
        </div>
    </div>
</div>

<div class="container">
    <div class="card">
        <div class="card-body">
            <form id="createForm">
                <div class="row mb-4">
                    <div class="col-md-6">
                        <div class="mb-3">
                            <label for="name" class="form-label">Destination Name</label>
                            <input type="text" class="form-control" id="name" required>
                        </div>

                        <div class="mb-3">
                            <label for="location" class="form-label">Location</label>
                            <input type="text" class="form-control" id="location" required>
                        </div>

                        <div class="mb-3">
                            <label for="image" class="form-label">Image URL</label>
                            <input type="url" class="form-control" id="image"
                                   placeholder="https://example.com/image.jpg" required>
                        </div>
                    </div>

                    <div class="col-md-6">
                        <div class="mb-3">
                            <label class="form-label">Image Preview</label>
                            <div class="d-flex justify-content-center">
                                <img id="imagePreview" class="image-preview"
                                     alt="Image preview will appear here">
                            </div>
                        </div>
                    </div>
                </div>

                <div class="mb-3">
                    <label for="description" class="form-label">Description</label>
                    <textarea class="form-control" id="description" rows="5" required></textarea>
                </div>

                <div class="d-flex justify-content-between mt-4">
                    <button type="button" class="cancel-btn" onclick="window.location.href='/admin'">
                        <i class="fas fa-times me-2"></i>Cancel
                    </button>
                    <button type="submit" class="submit-btn">
                        <i class="fas fa-save me-2"></i>Create Destination
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Show image preview when URL changes
    document.getElementById('image').addEventListener('input', function() {
        const preview = document.getElementById('imagePreview');
        preview.src = this.value;
        preview.style.display = 'block';
    });

    // Handle form submission
    document.getElementById('createForm').addEventListener('submit', function(e) {
        e.preventDefault();

        const destination = {
            name: document.getElementById('name').value,
            location: document.getElementById('location').value,
            image: document.getElementById('image').value,
            description: document.getElementById('description').value
        };

        fetch('/tourismpackage_war_exploded/api/destinations', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(destination)
        })
            .then(response => {
                if (response.ok) {
                    return response.json();
                }
                throw new Error('Network response was not ok');
            })
            .then(data => {
                alert('Destination created successfully!');
                window.location.href = '/tourismpackage_war_exploded/admin';
            })
            .catch(error => {
                console.error('Error:', error);
                alert('Error creating destination: ' + error.message);
            });
    });
</script>
</body>
</html>

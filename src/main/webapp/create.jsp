<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Tourism Package</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        .error-message {
            display: none;
            color: #ef4444;
            font-size: 0.875rem;
            margin-top: 0.25rem;
        }
    </style>
</head>
<body class="bg-gray-50">
<div class="container mx-auto px-4 py-8 max-w-4xl">
    <div class="flex items-center mb-6">
        <button id="backButton" class="flex items-center text-blue-600 hover:text-blue-800" title="Return to Package List">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-1" viewBox="0 0 20 20" fill="currentColor">
                <path fill-rule="evenodd" d="M9.707 16.707a1 1 0 01-1.414 0l-6-6a1 1 0 010-1.414l6-6a1 1 0 011.414 1.414L5.414 9H17a1 1 0 110 2H5.414l4.293 4.293a1 1 0 010 1.414z" clip-rule="evenodd" />
            </svg>
            Back to Packages
        </button>
    </div>

    <div class="bg-white rounded-lg shadow-md p-6">
        <h1 class="text-2xl font-bold text-gray-800 mb-6">Create New Tourism Package</h1>

        <div id="alert-success" class="hidden bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded mb-4">
            <span id="success-message">Package created successfully!</span>
        </div>

        <div id="alert-error" class="hidden bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-4">
            <span id="error-message">An error occurred while creating the package.</span>
        </div>

        <form id="packageForm" class="space-y-6">
            <div>
                <label for="id" class="block text-sm font-medium text-gray-700 mb-1">Package ID</label>
                <input type="text" id="id" name="id" class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500" required>
                <span class="error-message" id="id-error">Package ID is required and must be alphanumeric (letters and numbers only)</span>
            </div>

            <div>
                <label for="name" class="block text-sm font-medium text-gray-700 mb-1">Package Name</label>
                <input type="text" id="name" name="name" class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500" required>
                <span class="error-message" id="name-error">Package name is required (2-50 characters)</span>
            </div>

            <div>
                <label for="description" class="block text-sm font-medium text-gray-700 mb-1">Description</label>
                <textarea id="description" name="description" rows="4" class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500" required></textarea>
                <span class="error-message" id="description-error">Description is required (minimum 10 characters)</span>
            </div>

            <div>
                <label for="price" class="block text-sm font-medium text-gray-700 mb-1">Price ($)</label>
                <input type="text" id="price" name="price" class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500" required>
                <span class="error-message" id="price-error">Price must be a valid positive number</span>
            </div>

            <div>
                <label for="features" class="block text-sm font-medium text-gray-700 mb-1">Features (comma-separated)</label>
                <input type="text" id="features" name="features" class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500" required>
                <span class="error-message" id="features-error">At least one feature is required</span>
            </div>

            <div>
                <label class="block text-sm font-medium text-gray-700 mb-2">Package Type</label>
                <div class="flex items-center space-x-4">
                    <div class="flex items-center">
                        <input type="radio" id="standard" name="packageType" value="standard" class="h-4 w-4 text-blue-600 focus:ring-blue-500" checked>
                        <label for="standard" class="ml-2 text-sm text-gray-700">Standard</label>
                    </div>
                    <div class="flex items-center">
                        <input type="radio" id="luxury" name="packageType" value="luxury" class="h-4 w-4 text-blue-600 focus:ring-blue-500">
                        <label for="luxury" class="ml-2 text-sm text-gray-700">Luxury</label>
                    </div>
                </div>
            </div>

            <div id="luxuryFeatureContainer" class="hidden">
                <label for="luxuryFeature" class="block text-sm font-medium text-gray-700 mb-1">Luxury Feature</label>
                <input type="text" id="luxuryFeature" name="luxuryFeature" class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
                <span class="error-message" id="luxuryFeature-error">Luxury feature is required for luxury packages</span>
            </div>

            <div class="flex justify-end">
                <button type="submit" class="px-4 py-2 bg-blue-600 text-white rounded-md hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2">
                    Create Package
                </button>
            </div>
        </form>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Show/hide luxury feature based on package type
        const packageTypeRadios = document.querySelectorAll('input[name="packageType"]');
        const luxuryFeatureContainer = document.getElementById('luxuryFeatureContainer');

        packageTypeRadios.forEach(radio => {
            radio.addEventListener('change', function() {
                if (this.value === 'luxury') {
                    luxuryFeatureContainer.classList.remove('hidden');
                } else {
                    luxuryFeatureContainer.classList.add('hidden');
                }
            });
        });

        // Form validation patterns
        const validations = {
            id: {
                pattern: /^[a-zA-Z0-9]+$/,
                message: 'Package ID is required and must be alphanumeric (letters and numbers only)'
            },
            name: {
                pattern: /^.{2,50}$/,
                message: 'Package name is required (2-50 characters)'
            },
            description: {
                pattern: /^.{10,}$/,
                message: 'Description is required (minimum 10 characters)'
            },
            price: {
                pattern: /^[0-9]+(\.[0-9]{1,2})?$/,
                message: 'Price must be a valid positive number'
            },
            features: {
                pattern: /^.+$/,
                message: 'At least one feature is required'
            },
            luxuryFeature: {
                pattern: /^.{2,}$/,
                message: 'Luxury feature is required for luxury packages'
            }
        };

        // Back button functionality
        document.getElementById('backButton').addEventListener('click', function() {
            window.location.href = '/tourismpackage_war_exploded/admin';
        });

        // Form submission
        document.getElementById('packageForm').addEventListener('submit', function(e) {
            e.preventDefault();

            // Validate all fields
            let isValid = true;

            // Reset all error messages
            document.querySelectorAll('.error-message').forEach(el => {
                el.style.display = 'none';
            });

            // Check each field against its validation pattern
            for (const [field, validation] of Object.entries(validations)) {
                const element = document.getElementById(field);

                // Skip luxury feature validation if not a luxury package
                if (field === 'luxuryFeature' && document.getElementById('standard').checked) {
                    continue;
                }

                if (element && (!validation.pattern.test(element.value))) {
                    document.getElementById(`${field}-error`).style.display = 'block';
                    isValid = false;
                }
            }

            if (!isValid) {
                return;
            }

            // Prepare the data for submission
            const formData = {
                id: document.getElementById('id').value,
                name: document.getElementById('name').value,
                description: document.getElementById('description').value,
                price: parseFloat(document.getElementById('price').value),
                features: document.getElementById('features').value.split(',').map(f => f.trim())
            };

            // Add luxury feature if applicable
            if (document.getElementById('luxury').checked) {
                formData.luxuryFeature = document.getElementById('luxuryFeature').value;
            }

            // Send the fetch request
            fetch('<%=request.getContextPath()%>/packages', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(formData)
            })
                .then(response => {
                    if (!response.ok) {
                        return response.json().then(data => {
                            throw new Error(data.error || 'An error occurred');
                        });
                    }
                    return response.json();
                })
                .then(data => {
                    // Show success message
                    const successAlert = document.getElementById('alert-success');
                    successAlert.classList.remove('hidden');

                    // Reset form
                    document.getElementById('packageForm').reset();

                    // Hide success message after 3 seconds
                    setTimeout(() => {
                        successAlert.classList.add('hidden');
                    }, 3000);
                })
                .catch(error => {
                    // Show error message
                    const errorAlert = document.getElementById('alert-error');
                    document.getElementById('error-message').textContent = error.message;
                    errorAlert.classList.remove('hidden');

                    // Hide error message after 5 seconds
                    setTimeout(() => {
                        errorAlert.classList.add('hidden');
                    }, 5000);
                });
        });
    });
</script>
</body>
</html>
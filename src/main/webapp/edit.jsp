<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Tour Guide</title>
    <script src="https://cdn.tailwindcss.com"></script>

    <style>
        .loader {
            border-top-color: #3498db;
            -webkit-animation: spinner 1.5s linear infinite;
            animation: spinner 1.5s linear infinite;
        }

        @-webkit-keyframes spinner {
            0% { -webkit-transform: rotate(0deg); }
            100% { -webkit-transform: rotate(360deg); }
        }

        @keyframes spinner {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
    </style>
</head>
<body class="bg-gray-100">
<div class="container mx-auto px-4 py-8 max-w-2xl">
    <div class="flex items-center mb-6">
        <button id="backButton" class="bg-gray-300 hover:bg-gray-400 text-gray-800 font-bold py-2 px-4 rounded inline-flex items-center mr-4">
            <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18"></path>
            </svg>
            Back
        </button>
        <h1 class="text-2xl font-bold">Edit Tour Guide</h1>
    </div>

    <div id="loadingContainer" class="text-center py-10">
        <div class="loader mx-auto ease-linear rounded-full border-4 border-t-4 border-gray-200 h-12 w-12 mb-4"></div>
        <p class="text-gray-600">Loading guide information...</p>
    </div>

    <div id="formContainer" class="bg-white shadow-md rounded px-8 pt-6 pb-8 mb-4 hidden">
        <form id="editGuideForm">
            <input type="hidden" id="guideId">

            <div class="mb-4">
                <label class="block text-gray-700 text-sm font-bold mb-2" for="name">
                    Full Name*
                </label>
                <input class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
                       id="name" type="text" placeholder="John Doe" required>
                <p id="nameError" class="text-red-500 text-xs italic hidden">Please enter a valid name.</p>
            </div>

            <div class="mb-4">
                <label class="block text-gray-700 text-sm font-bold mb-2" for="contactNumber">
                    Contact Number*
                </label>
                <input class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
                       id="contactNumber" type="text" placeholder="+1-555-123-4567" required>
                <p id="contactNumberError" class="text-red-500 text-xs italic hidden">Please enter a valid contact number (format: 07XXXXXXXX).</p>
            </div>

            <div class="mb-4">
                <label class="block text-gray-700 text-sm font-bold mb-2" for="image">
                    Image URL*
                </label>
                <input class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
                       id="image" type="text" placeholder="https://example.com/image.jpg" required>
                <p id="imageError" class="text-red-500 text-xs italic hidden">Please enter a valid image URL.</p>
            </div>

            <div class="mb-4">
                <img id="imagePreview" src="" alt="Guide Image Preview" class="w-32 h-32 object-cover rounded-full border-2 border-gray-300 hidden">
            </div>

            <div class="mb-6">
                <label class="block text-gray-700 text-sm font-bold mb-2" for="description">
                    Description*
                </label>
                <textarea class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
                          id="description" rows="4" placeholder="Guide description and specialties..." required></textarea>
                <p id="descriptionError" class="text-red-500 text-xs italic hidden">Please enter a description (minimum 10 characters).</p>
            </div>

            <div class="flex items-center justify-between">
                <button class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline"
                        id="submitButton" type="submit">
                    Update Guide
                </button>

                <div id="loadingIndicator" class="hidden">
                    <div class="loader ease-linear rounded-full border-4 border-t-4 border-gray-200 h-8 w-8"></div>
                </div>
            </div>
        </form>
    </div>

    <!-- Success Alert -->
    <div id="successAlert" class="hidden bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded relative mb-4" role="alert">
        <strong class="font-bold">Success!</strong>
        <span class="block sm:inline"> Tour guide updated successfully.</span>
        <span class="absolute top-0 bottom-0 right-0 px-4 py-3">
            <svg onclick="document.getElementById('successAlert').classList.add('hidden')" class="fill-current h-6 w-6 text-green-500" role="button" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20">
                <title>Close</title>
                <path d="M14.348 14.849a1.2 1.2 0 0 1-1.697 0L10 11.819l-2.651 3.029a1.2 1.2 0 1 1-1.697-1.697l2.758-3.15-2.759-3.152a1.2 1.2 0 1 1 1.697-1.697L10 8.183l2.651-3.031a1.2 1.2 0 1 1 1.697 1.697l-2.758 3.152 2.758 3.15a1.2 1.2 0 0 1 0 1.698z"/>
            </svg>
        </span>
    </div>

    <!-- Error Alert -->
    <div id="errorAlert" class="hidden bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative mb-4" role="alert">
        <strong class="font-bold">Error!</strong>
        <span class="block sm:inline" id="errorMessage"> Something went wrong.</span>
        <span class="absolute top-0 bottom-0 right-0 px-4 py-3">
            <svg onclick="document.getElementById('errorAlert').classList.add('hidden')" class="fill-current h-6 w-6 text-red-500" role="button" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20">
                <title>Close</title>
                <path d="M14.348 14.849a1.2 1.2 0 0 1-1.697 0L10 11.819l-2.651 3.029a1.2 1.2 0 1 1-1.697-1.697l2.758-3.15-2.759-3.152a1.2 1.2 0 1 1 1.697-1.697L10 8.183l2.651-3.031a1.2 1.2 0 1 1 1.697 1.697l-2.758 3.152 2.758 3.15a1.2 1.2 0 0 1 0 1.698z"/>
            </svg>
        </span>
    </div>

    <!-- Not Found Alert -->
    <div id="notFoundAlert" class="hidden bg-yellow-100 border border-yellow-400 text-yellow-700 px-4 py-3 rounded relative mb-4" role="alert">
        <strong class="font-bold">Not Found!</strong>
        <span class="block sm:inline"> The requested tour guide was not found.</span>
        <span class="block mt-2">
            <a href="/tourismpackage_war_exploded/admin" class="underline">Return to guides list</a>
        </span>
    </div>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        // Back button functionality
        document.getElementById("backButton").addEventListener("click", function() {
            window.location.href = "/tourismpackage_war_exploded/admin";
        });

        // Get guide ID from URL
        const urlParams = new URLSearchParams(window.location.search);
        const guideId = urlParams.get("tourGuideId");

        if (!guideId) {
            document.getElementById("loadingContainer").classList.add("hidden");
            document.getElementById("notFoundAlert").classList.remove("hidden");
            return;
        }

        document.getElementById("guideId").value = guideId;

        // Form elements
        const form = document.getElementById("editGuideForm");
        const nameInput = document.getElementById("name");
        const contactNumberInput = document.getElementById("contactNumber");
        const imageInput = document.getElementById("image");
        const descriptionInput = document.getElementById("description");
        const imagePreview = document.getElementById("imagePreview");
        const submitButton = document.getElementById("submitButton");
        const loadingIndicator = document.getElementById("loadingIndicator");
        const successAlert = document.getElementById("successAlert");
        const errorAlert = document.getElementById("errorAlert");
        const errorMessage = document.getElementById("errorMessage");

        // Regular expressions for validation
        const nameRegex = /^[A-Za-z\s]{2,50}$/;
        const contactNumberRegex = /^(?:\+94|0)?7\d{8}$/;
        const imageRegex = /^(https?:\/\/.*\.(?:png|jpg|jpeg|gif))$/i;

        // Load guide data
        fetchGuideData(guideId);

        // Update image preview when URL changes
        imageInput.addEventListener("input", function() {
            if (imageRegex.test(imageInput.value)) {
                imagePreview.src = imageInput.value;
                imagePreview.classList.remove("hidden");
            } else {
                imagePreview.classList.add("hidden");
            }
        });

        // Form submission
        form.addEventListener("submit", function(event) {
            event.preventDefault();

            // Reset error messages
            document.querySelectorAll(".text-red-500").forEach(el => el.classList.add("hidden"));

            // Validate inputs
            let isValid = true;

            if (!nameRegex.test(nameInput.value)) {
                document.getElementById("nameError").classList.remove("hidden");
                isValid = false;
            }

            if (!contactNumberRegex.test(contactNumberInput.value)) {
                document.getElementById("contactNumberError").classList.remove("hidden");
                isValid = false;
            }

            if (!imageRegex.test(imageInput.value)) {
                document.getElementById("imageError").classList.remove("hidden");
                isValid = false;
            }

            if (descriptionInput.value.length < 10) {
                document.getElementById("descriptionError").classList.remove("hidden");
                isValid = false;
            }

            if (isValid) {
                // Show loading indicator, hide submit button
                submitButton.classList.add("hidden");
                loadingIndicator.classList.remove("hidden");

                // Hide any existing alerts
                successAlert.classList.add("hidden");
                errorAlert.classList.add("hidden");

                // Prepare data for submission
                const guideData = {
                    id: guideId,
                    name: nameInput.value,
                    contactNumber: contactNumberInput.value,
                    image: imageInput.value,
                    description: descriptionInput.value
                };

                // Send data to server
                updateGuide(guideData);
            }
        });

        // Function to fetch guide data
        function fetchGuideData(id) {
            fetch(`/tourismpackage_war_exploded/api/guides/`+id)
                .then(response => {
                    if (!response.ok) {
                        if (response.status === 404) {
                            throw new Error("Guide not found");
                        }
                        throw new Error("Server returned " + response.status + " " + response.statusText);
                    }
                    return response.json();
                })
                .then(guide => {
                    // Populate form with guide data
                    nameInput.value = guide.name;
                    contactNumberInput.value = guide.contactNumber;
                    imageInput.value = guide.image;
                    descriptionInput.value = guide.description;

                    // Show image preview
                    imagePreview.src = guide.image;
                    imagePreview.classList.remove("hidden");

                    // Show form, hide loading container
                    document.getElementById("loadingContainer").classList.add("hidden");
                    document.getElementById("formContainer").classList.remove("hidden");
                })
                .catch(error => {
                    console.error("Error fetching guide:", error);
                    document.getElementById("loadingContainer").classList.add("hidden");

                    if (error.message === "Guide not found") {
                        document.getElementById("notFoundAlert").classList.remove("hidden");
                    } else {
                        errorMessage.textContent = " " + error.message;
                        errorAlert.classList.remove("hidden");
                    }
                });
        }

        // Function to update guide
        function updateGuide(guideData) {
            fetch(`/tourismpackage_war_exploded/api/guides/`+guideData.id, {
                method: "PUT",
                headers: {
                    "Content-Type": "application/json"
                },
                body: JSON.stringify(guideData)
            })
                .then(response => {
                    if (!response.ok) {
                        throw new Error("Server returned " + response.status + " " + response.statusText);
                    }
                    return response.json();
                })
                .then(data => {
                    // Show success message
                    successAlert.classList.remove("hidden");

                    // Scroll to top to see the alert
                    window.scrollTo(0, 0);
                })
                .catch(error => {
                    // Show error message
                    errorMessage.textContent = " " + error.message;
                    errorAlert.classList.remove("hidden");
                })
                .finally(() => {
                    // Hide loading indicator, show submit button
                    loadingIndicator.classList.add("hidden");
                    submitButton.classList.remove("hidden");
                });
        }
    });
</script>
</body>
</html>
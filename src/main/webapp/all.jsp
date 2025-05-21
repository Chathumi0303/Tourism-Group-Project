<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Feedback Management</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap');

        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f8fafc;
        }

        .feedback-card {
            transition: all 0.3s ease;
            border-left: 4px solid #3b82f6;
        }

        .feedback-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
        }

        .modal-overlay {
            background-color: rgba(0, 0, 0, 0.5);
            backdrop-filter: blur(4px);
        }

        .modal-content {
            animation: modalFadeIn 0.3s ease-out;
        }

        @keyframes modalFadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        textarea, input {
            transition: border-color 0.3s ease;
        }

        textarea:focus, input:focus {
            border-color: #3b82f6;
            box-shadow: 0 0 0 2px rgba(59, 130, 246, 0.2);
        }
    </style>
</head>
<body class="bg-gray-50 text-gray-800 p-6">
<div class="max-w-6xl mx-auto">
    <div class="flex justify-between items-center mb-8">
        <div>
            <h1 class="text-3xl font-bold text-gray-800">Customer Feedback</h1>
            <p class="text-gray-600">Manage all customer feedback in one place</p>
        </div>
        <button
                class="bg-gradient-to-r from-blue-500 to-blue-600 text-white px-6 py-3 rounded-lg shadow-md hover:shadow-lg transition-all flex items-center gap-2"
                onclick="openCreateModal()">
            <i class="fas fa-plus"></i> Add New Feedback
        </button>
    </div>

    <div id="feedbackList" class="grid grid-cols-1 md:grid-cols-2 gap-6"></div>
</div>

<!-- Create Modal -->
<div id="createModal" class="fixed inset-0 hidden modal-overlay z-50 flex items-center justify-center p-4">
    <div class="modal-content bg-white rounded-xl shadow-2xl w-full max-w-lg overflow-hidden">
        <div class="bg-gradient-to-r from-blue-500 to-blue-600 p-4 text-white">
            <h2 class="text-xl font-semibold flex items-center gap-2">
                <i class="fas fa-comment-medical"></i> Create New Feedback
            </h2>
        </div>
        <form id="createForm" class="space-y-4 p-6">
            <div>
                <label class="block text-gray-700 mb-2 font-medium">Destination Place</label>
                <input
                        name="destinationPlace"
                        placeholder="Where did you visit?"
                        required
                        pattern="^[A-Za-z ]{3,}$"
                        class="w-full border border-gray-300 px-4 py-3 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-200">
            </div>
            <div>
                <label class="block text-gray-700 mb-2 font-medium">Your Feedback</label>
                <textarea
                        name="feedback"
                        placeholder="Share your thoughts..."
                        required
                        pattern=".{5,}"
                        rows="3"
                        class="w-full border border-gray-300 px-4 py-3 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-200"></textarea>
            </div>
            <div>
                <label class="block text-gray-700 mb-2 font-medium">Experience</label>
                <textarea
                        name="experience"
                        placeholder="Tell us about your experience..."
                        required
                        pattern=".{5,}"
                        rows="3"
                        class="w-full border border-gray-300 px-4 py-3 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-200"></textarea>
            </div>
            <div class="flex justify-end gap-3 pt-4">
                <button
                        type="button"
                        onclick="closeCreateModal()"
                        class="px-6 py-2 border border-gray-300 rounded-lg text-gray-700 hover:bg-gray-100 transition-colors">
                    Cancel
                </button>
                <button
                        type="submit"
                        class="px-6 py-2 bg-gradient-to-r from-blue-500 to-blue-600 text-white rounded-lg shadow hover:shadow-md transition-all">
                    Save Feedback
                </button>
            </div>
        </form>
    </div>
</div>

<!-- Edit Modal -->
<div id="editModal" class="fixed inset-0 hidden modal-overlay z-50 flex items-center justify-center p-4">
    <div class="modal-content bg-white rounded-xl shadow-2xl w-full max-w-lg overflow-hidden">
        <div class="bg-gradient-to-r from-green-500 to-green-600 p-4 text-white">
            <h2 class="text-xl font-semibold flex items-center gap-2">
                <i class="fas fa-edit"></i> Edit Feedback
            </h2>
        </div>
        <form id="editForm" class="space-y-4 p-6">
            <input type="hidden" name="id" id="editId">
            <div>
                <label class="block text-gray-700 mb-2 font-medium">Destination Place</label>
                <input
                        name="destinationPlace"
                        id="editDestination"
                        required
                        pattern="^[A-Za-z ]{3,}$"
                        class="w-full border border-gray-300 px-4 py-3 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-200">
            </div>
            <div>
                <label class="block text-gray-700 mb-2 font-medium">Your Feedback</label>
                <textarea
                        name="feedback"
                        id="editFeedback"
                        required
                        pattern=".{5,}"
                        rows="3"
                        class="w-full border border-gray-300 px-4 py-3 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-200"></textarea>
            </div>
            <div>
                <label class="block text-gray-700 mb-2 font-medium">Experience</label>
                <textarea
                        name="experience"
                        id="editExperience"
                        required
                        pattern=".{5,}"
                        rows="3"
                        class="w-full border border-gray-300 px-4 py-3 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-200"></textarea>
            </div>
            <div class="flex justify-end gap-3 pt-4">
                <button
                        type="button"
                        onclick="closeEditModal()"
                        class="px-6 py-2 border border-gray-300 rounded-lg text-gray-700 hover:bg-gray-100 transition-colors">
                    Cancel
                </button>
                <button
                        type="submit"
                        class="px-6 py-2 bg-gradient-to-r from-green-500 to-green-600 text-white rounded-lg shadow hover:shadow-md transition-all">
                    Update Feedback
                </button>
            </div>
        </form>
    </div>
</div>

<script>
    function fetchFeedbacks() {
        fetch("/tourismpackage_war_exploded/api/feedbacks")
            .then(function(res) { return res.json(); })
            .then(function(data) {
                var list = document.getElementById("feedbackList");
                list.innerHTML = "";
                if (data.length === 0) {
                    list.innerHTML =
                        "<div class=\"col-span-full text-center py-12\">" +
                        "<i class=\"fas fa-comment-slash text-4xl text-gray-300 mb-4\"></i>" +
                        "<h3 class=\"text-xl font-medium text-gray-500\">No feedback yet</h3>" +
                        "<p class=\"text-gray-400\">Be the first to share your experience</p>" +
                        "</div>";
                    return;
                }
                data.forEach(function(fb) {
                    var card = document.createElement("div");
                    card.className = "feedback-card bg-white rounded-lg shadow-md overflow-hidden";
                    card.innerHTML =
                        "<div class=\"p-6\">" +
                        "<div class=\"flex justify-between items-start mb-3\">" +
                        "<span class=\"inline-block bg-blue-100 text-blue-800 text-xs px-3 py-1 rounded-full font-medium\">" +
                        fb.destinationPlace +
                        "</span>" +
                        "<div class=\"flex gap-2\">" +
                        "<button onclick='openEditModal(\"" + fb.id + "\")' class=\"text-yellow-500 hover:text-yellow-700 transition-colors\">" +
                        "<i class=\"fas fa-edit\"></i>" +
                        "</button>" +
                        "<button onclick='deleteFeedback(\"" + fb.id + "\")' class=\"text-red-500 hover:text-red-700 transition-colors\">" +
                        "<i class=\"fas fa-trash\"></i>" +
                        "</button>" +
                        "</div>" +
                        "</div>" +
                        "<h3 class=\"font-medium text-lg mb-2\">" + fb.feedback + "</h3>" +
                        "<p class=\"text-gray-600\">" + fb.experience + "</p>" +
                        "</div>";
                    list.appendChild(card);
                });
            });
    }

    function openCreateModal() {
        document.getElementById("createModal").classList.remove("hidden");
    }

    function closeCreateModal() {
        document.getElementById("createModal").classList.add("hidden");
    }

    function openEditModal(id) {
        fetch("/tourismpackage_war_exploded/api/feedbacks/" + id)
            .then(function(res) { return res.json(); })
            .then(function(data) {
                document.getElementById("editId").value = data.id;
                document.getElementById("editFeedback").value = data.feedback;
                document.getElementById("editDestination").value = data.destinationPlace;
                document.getElementById("editExperience").value = data.experience;
                document.getElementById("editModal").classList.remove("hidden");
            });
    }

    function closeEditModal() {
        document.getElementById("editModal").classList.add("hidden");
    }

    function deleteFeedback(id) {
        if (confirm("Are you sure you want to delete this feedback?")) {
            fetch("/tourismpackage_war_exploded/api/feedbacks/" + id, { method: "DELETE" })
                .then(function(res) { return res.json(); })
                .then(function() {
                    fetchFeedbacks();
                });
        }
    }

    document.getElementById("createForm").addEventListener("submit", function(e) {
        e.preventDefault();
        if (!e.target.checkValidity()) {
            alert("Please fill all fields correctly");
            return;
        }
        var data = {
            feedback: e.target.feedback.value,
            destinationPlace: e.target.destinationPlace.value,
            experience: e.target.experience.value
        };
        fetch("/tourismpackage_war_exploded/api/feedbacks", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify(data)
        })
            .then(function(res) { return res.json(); })
            .then(function() {
                closeCreateModal();
                fetchFeedbacks();
                e.target.reset();
            });
    });

    document.getElementById("editForm").addEventListener("submit", function(e) {
        e.preventDefault();
        if (!e.target.checkValidity()) {
            alert("Please fill all fields correctly");
            return;
        }
        var id = document.getElementById("editId").value;
        var data = {
            feedback: document.getElementById("editFeedback").value,
            destinationPlace: document.getElementById("editDestination").value,
            experience: document.getElementById("editExperience").value
        };
        fetch("/tourismpackage_war_exploded/api/feedbacks/" + id, {
            method: "PUT",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify(data)
        })
            .then(function(res) { return res.json(); })
            .then(function() {
                closeEditModal();
                fetchFeedbacks();
            });
    });

    fetchFeedbacks();
</script>
</body>
</html>
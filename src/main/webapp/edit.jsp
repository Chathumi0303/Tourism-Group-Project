<!DOCTYPE html>
<html>
<head>
    <title>Edit Feedback</title>
</head>
<body>
<h2>Edit Feedback</h2>
<form id="editForm">
    <input type="hidden" name="id" id="feedbackId">

    <label>Feedback:</label><br>
    <textarea name="feedback" id="feedback" required></textarea><br><br>

    <label>Destination Place:</label><br>
    <input type="text" name="destinationPlace" id="destinationPlace" required><br><br>

    <label>Experience:</label><br>
    <textarea name="experience" id="experience" required></textarea><br><br>

    <button type="submit">Update</button>
</form>

<script>
    const params = new URLSearchParams(window.location.search);
    const id = params.get("id");

    fetch("/tourismpackage_war_exploded/api/feedbacks/" + id)
        .then(res => res.json())
        .then(data => {
            document.getElementById("feedbackId").value = data.id;
            document.getElementById("feedback").value = data.feedback;
            document.getElementById("destinationPlace").value = data.destinationPlace;
            document.getElementById("experience").value = data.experience;
        })
        .catch(err => console.error("Fetch error:", err));

    document.getElementById("editForm").addEventListener("submit", function (e) {
        e.preventDefault();

        const data = {
            feedback: document.getElementById("feedback").value,
            destinationPlace: document.getElementById("destinationPlace").value,
            experience: document.getElementById("experience").value
        };

        fetch("/tourismpackage_war_exploded/api/feedbacks/" + id, {
            method: "PUT",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify(data)
        })
            .then(res => res.json())
            .then(json => {
                alert("Feedback updated successfully!");
            })
            .catch(err => console.error("Error:", err));
    });
</script>
</body>
</html>

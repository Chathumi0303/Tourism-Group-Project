<!DOCTYPE html>
<html>
<head>
    <title>Create Feedback</title>
</head>
<body>
<h2>Create Feedback</h2>
<form id="createForm">
    <label>Feedback:</label><br>
    <textarea name="feedback" required></textarea><br><br>

    <label>Destination Place:</label><br>
    <input type="text" name="destinationPlace" required><br><br>

    <label>Experience:</label><br>
    <textarea name="experience" required></textarea><br><br>

    <button type="submit">Submit</button>
</form>

<script>
    document.getElementById("createForm").addEventListener("submit", function (e) {
        e.preventDefault();

        const form = e.target;
        const data = {
            feedback: form.feedback.value,
            destinationPlace: form.destinationPlace.value,
            experience: form.experience.value
        };

        fetch("/tourismpackage_war_exploded/api/feedbacks", {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify(data)
        })
            .then(res => res.json())
            .then(json => {
                alert("Feedback created successfully!");
                form.reset();
            })
            .catch(err => console.error("Error:", err));
    });
</script>
</body>
</html>

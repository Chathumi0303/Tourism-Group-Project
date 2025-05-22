<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Property</title>
    <style>
        /* Add your CSS styles here */
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        .form-container {
            max-width: 600px;
            margin: 0 auto;
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            display: block;
            margin-bottom: 5px;
        }
        input[type="text"], textarea {
            width: 100%;
            padding: 8px;
        }
        .btn {
            padding: 8px 15px;
            text-decoration: none;
            border-radius: 3px;
            cursor: pointer;
        }
        .btn-primary {
            background-color: #4CAF50;
            color: white;
            border: none;
        }
    </style>
</head>
<body>
<div class="form-container">
    <h1>Edit Property</h1>

    <form action="PackageServlet" method="POST">
        <input type="hidden" name="action" value="updateProperty">
        <input type="hidden" name="packageId" value="${packageId}">
        <input type="hidden" name="propertyId" value="${property.id}">

        <div class="form-group">
            <label for="propertyName">Property Name:</label>
            <input type="text" id="propertyName" name="propertyName" value="${property.name}" required>
        </div>

        <div class="form-group">
            <label for="propertyValue">Value:</label>
            <input type="text" id="propertyValue" name="propertyValue" value="${property.value}" required>
        </div>

        <div class="form-group">
            <label for="propertyDescription">Description:</label>
            <textarea id="propertyDescription" name="propertyDescription" rows="3">${property.description}</textarea>
        </div>

        <button type="submit" class="btn btn-primary">Update Property</button>
        <a href="PackageServlet?action=viewProperties&packageId=${packageId}" class="btn">Cancel</a>
    </form>
</div>
</body>
</html>
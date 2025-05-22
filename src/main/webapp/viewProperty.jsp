<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Package Properties</title>
  <style>
    /* Add your CSS styles here similar to packageManagement.jsp */
    body {
      font-family: Arial, sans-serif;
      margin: 20px;
    }
    .container {
      max-width: 1200px;
      margin: 0 auto;
    }
    .property-table {
      width: 100%;
      border-collapse: collapse;
      margin-top: 20px;
    }
    .property-table th, .property-table td {
      border: 1px solid #ddd;
      padding: 8px;
      text-align: left;
    }
    .property-table th {
      background-color: #f2f2f2;
    }
    .action-buttons {
      display: flex;
      gap: 5px;
    }
    .btn {
      padding: 5px 10px;
      text-decoration: none;
      border-radius: 3px;
      cursor: pointer;
    }
    .btn-primary {
      background-color: #4CAF50;
      color: white;
      border: none;
    }
    .btn-edit {
      background-color: #2196F3;
      color: white;
      border: none;
    }
    .btn-delete {
      background-color: #f44336;
      color: white;
      border: none;
    }
    .modal {
      display: none;
      position: fixed;
      z-index: 1;
      left: 0;
      top: 0;
      width: 100%;
      height: 100%;
      overflow: auto;
      background-color: rgba(0,0,0,0.4);
    }
    .modal-content {
      background-color: #fefefe;
      margin: 15% auto;
      padding: 20px;
      border: 1px solid #888;
      width: 50%;
    }
  </style>
</head>
<body>
<div class="container">
  <h1>Properties for Package ID: ${packageId}</h1>

  <button id="addPropertyBtn" class="btn btn-primary">Add New Property</button>

  <table class="property-table">
    <thead>
    <tr>
      <th>Name</th>
      <th>Value</th>
      <th>Description</th>
      <th>Actions</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="property" items="${properties}">
      <tr>
        <td>${property.name}</td>
        <td>${property.value}</td>
        <td>${property.description}</td>
        <td class="action-buttons">
          <a href="PackageServlet?action=editProperty&packageId=${packageId}&propertyId=${property.id}"
             class="btn btn-edit">Edit</a>
          <a href="PackageServlet?action=deleteProperty&packageId=${packageId}&propertyId=${property.id}"
             class="btn btn-delete">Delete</a>
        </td>
      </tr>
    </c:forEach>
    </tbody>
  </table>

  <a href="PackageServlet?action=list" class="btn">Back to Packages</a>
</div>

<!-- Add Property Modal -->
<div id="propertyModal" class="modal">
  <div class="modal-content">
    <span class="close">&times;</span>
    <h2>Add New Property</h2>
    <form action="PackageServlet" method="POST">
      <input type="hidden" name="action" value="addProperty">
      <input type="hidden" name="packageId" value="${packageId}">

      <div>
        <label for="propertyName">Property Name:</label>
        <input type="text" id="propertyName" name="propertyName" required>
      </div>

      <div>
        <label for="propertyValue">Value:</label>
        <input type="text" id="propertyValue" name="propertyValue" required>
      </div>

      <div>
        <label for="propertyDescription">Description:</label>
        <textarea id="propertyDescription" name="propertyDescription" rows="3"></textarea>
      </div>

      <button type="submit" class="btn btn-primary">Save Property</button>
    </form>
  </div>
</div>

<script>
  // Modal handling
  const modal = document.getElementById("propertyModal");
  const btn = document.getElementById("addPropertyBtn");
  const span = document.getElementsByClassName("close")[0];

  btn.onclick = function() {
    modal.style.display = "block";
  }

  span.onclick = function() {
    modal.style.display = "none";
  }

  window.onclick = function(event) {
    if (event.target == modal) {
      modal.style.display = "none";
    }
  }
</script>
</body>
</html>
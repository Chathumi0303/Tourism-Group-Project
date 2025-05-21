package com.example.tourismpackage.controllers;

import com.example.tourismpackage.models.TravelDestination;
import com.example.tourismpackage.services.TravelDestinationCrud;
import jakarta.json.Json;
import jakarta.json.JsonObject;
import jakarta.json.JsonReader;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet(name = "TravelDestinationController", urlPatterns = {
        "/api/destinations",        // For GET all and POST
        "/api/destinations/*"      // For GET by ID, PUT, DELETE
})
public class TravelDestinationController extends HttpServlet {

    private TravelDestinationCrud destinationCrud = new TravelDestinationCrud();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String pathInfo = request.getPathInfo();
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        try {
            if (pathInfo == null || pathInfo.equals("/")) {
                // GET all destinations
                List<TravelDestination> destinations = destinationCrud.getAllDestinations();
                out.print(convertToJson(destinations));
            } else {
                // GET single destination
                String id = pathInfo.substring(1);
                if (id.isEmpty()) {
                    response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                    out.print("{\"error\":\"Invalid ID format\"}");
                    return;
                }

                TravelDestination destination = destinationCrud.getDestinationById(id);
                if (destination != null) {
                    out.print(convertToJson(destination));
                } else {
                    response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                    out.print("{\"error\":\"Destination not found\"}");
                }
            }
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print("{\"error\":\"" + e.getMessage() + "\"}");
        }
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        try {
            // Parse JSON from request body
            TravelDestination newDestination = parseFromJson(request);
            newDestination.setId(destinationCrud.generateId());

            destinationCrud.createDestination(newDestination);
            response.setStatus(HttpServletResponse.SC_CREATED);
            out.print(convertToJson(newDestination));
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            out.print("{\"error\":\"" + e.getMessage() + "\"}");
        }
    }

    @Override
    protected void doPut(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String pathInfo = request.getPathInfo();
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        if (pathInfo == null || pathInfo.equals("/")) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            out.print("{\"error\":\"ID is required\"}");
            return;
        }

        try {
            String id = pathInfo.substring(1); // Remove leading slash
            TravelDestination existing = destinationCrud.getDestinationById(id);
            if (existing == null) {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                out.print("{\"error\":\"Destination not found\"}");
                return;
            }

            TravelDestination updated = parseFromJson(request);
            updated.setId(id); // Ensure ID remains the same

            // Preserve existing values if fields are not provided in update
            if (updated.getName() == null) updated.setName(existing.getName());
            if (updated.getLocation() == null) updated.setLocation(existing.getLocation());
            if (updated.getImage() == null) updated.setImage(existing.getImage());
            if (updated.getDescription() == null) updated.setDescription(existing.getDescription());

            destinationCrud.updateDestination(updated);
            out.print(convertToJson(updated));
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            out.print("{\"error\":\"" + e.getMessage() + "\"}");
        }
    }

    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String pathInfo = request.getPathInfo();
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        if (pathInfo == null || pathInfo.equals("/") || pathInfo.substring(1).isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            out.print("{\"error\":\"ID is required\"}");
            return;
        }

        try {
            String id = pathInfo.substring(1);
            TravelDestination existing = destinationCrud.getDestinationById(id);
            if (existing == null) {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                out.print("{\"error\":\"Destination not found\"}");
                return;
            }

            destinationCrud.deleteDestination(id);
            out.print("{\"message\":\"Destination with ID " + id + " deleted successfully\"}");
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print("{\"error\":\"" + e.getMessage() + "\"}");
        }
    }

    // Helper method to parse JSON from request
    private TravelDestination parseFromJson(HttpServletRequest request) throws IOException {
        try (JsonReader reader = Json.createReader(request.getReader())) {
            JsonObject jsonObject = reader.readObject();
            TravelDestination dest = new TravelDestination();

            if (jsonObject.containsKey("name")) {
                dest.setName(jsonObject.getString("name"));
            }
            if (jsonObject.containsKey("location")) {
                dest.setLocation(jsonObject.getString("location"));
            }
            if (jsonObject.containsKey("image")) {
                dest.setImage(jsonObject.getString("image"));
            }
            if (jsonObject.containsKey("description")) {
                dest.setDescription(jsonObject.getString("description"));
            }

            return dest;
        }
    }

    // Helper method to convert to JSON (simplified)
    private String convertToJson(TravelDestination destination) {
        return String.format("{\"id\":\"%s\",\"name\":\"%s\",\"location\":\"%s\",\"image\":\"%s\",\"description\":\"%s\"}",
                destination.getId(),
                destination.getName(),
                destination.getLocation(),
                destination.getImage(),
                destination.getDescription());
    }

    private String convertToJson(List<TravelDestination> destinations) {
        StringBuilder sb = new StringBuilder("[");
        for (int i = 0; i < destinations.size(); i++) {
            if (i > 0) sb.append(",");
            sb.append(convertToJson(destinations.get(i)));
        }
        sb.append("]");
        return sb.toString();
    }
}
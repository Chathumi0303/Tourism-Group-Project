package com.example.tourismpackage.controllers;

import com.example.tourismpackage.models.TouristGuide;
import com.example.tourismpackage.services.TouristGuideService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

/**
 * Servlet that handles REST API endpoints for TouristGuide operations
 */
@WebServlet("/api/guides/*")
public class TouristGuideServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final TouristGuideService service;
    private final Gson gson;

    public TouristGuideServlet() {
        this.service = new TouristGuideService();
        this.gson = new Gson();
    }

    /**
     * Handle GET requests:
     * - GET /api/guides: Get all guides
     * - GET /api/guides/{id}: Get guide by ID
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        String pathInfo = request.getPathInfo();

        // Get guide by ID: /api/guides/{id}
        if (pathInfo != null && !pathInfo.equals("/")) {
            String id = pathInfo.substring(1); // Remove leading slash
            Optional<TouristGuide> guide = service.getById(id);

            if (guide.isPresent()) {
                out.print(gson.toJson(guide.get()));
                response.setStatus(HttpServletResponse.SC_OK);
            } else {
                sendError(response, HttpServletResponse.SC_NOT_FOUND, "Guide not found with ID: " + id);
            }
        }
        // Get all guides: /api/guides
        else {
            List<TouristGuide> guides = service.getAllGuides();
            out.print(gson.toJson(guides));
            response.setStatus(HttpServletResponse.SC_OK);
        }

        out.flush();
    }

    /**
     * Handle POST requests:
     * - POST /api/guides: Create new guide
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        try {
            // Parse JSON request body
            String requestBody = request.getReader().lines().collect(Collectors.joining());
            TouristGuide guide = gson.fromJson(requestBody, TouristGuide.class);

            // Create new guide
            TouristGuide createdGuide = service.create(guide);

            // Return created guide with status 201
            out.print(gson.toJson(createdGuide));
            response.setStatus(HttpServletResponse.SC_CREATED);

        } catch (Exception e) {
            sendError(response, HttpServletResponse.SC_BAD_REQUEST, "Invalid request: " + e.getMessage());
        }

        out.flush();
    }

    /**
     * Handle PUT requests:
     * - PUT /api/guides/{id}: Update guide
     */
    @Override
    protected void doPut(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        String pathInfo = request.getPathInfo();

        if (pathInfo != null && !pathInfo.equals("/")) {
            String id = pathInfo.substring(1); // Remove leading slash

            try {
                // Parse JSON request body
                String requestBody = request.getReader().lines().collect(Collectors.joining());
                TouristGuide guide = gson.fromJson(requestBody, TouristGuide.class);

                // Update guide
                Optional<TouristGuide> updatedGuide = service.update(id, guide);

                if (updatedGuide.isPresent()) {
                    out.print(gson.toJson(updatedGuide.get()));
                    response.setStatus(HttpServletResponse.SC_OK);
                } else {
                    sendError(response, HttpServletResponse.SC_NOT_FOUND, "Guide not found with ID: " + id);
                }

            } catch (Exception e) {
                sendError(response, HttpServletResponse.SC_BAD_REQUEST, "Invalid request: " + e.getMessage());
            }
        } else {
            sendError(response, HttpServletResponse.SC_BAD_REQUEST, "Guide ID is required for update");
        }

        out.flush();
    }

    /**
     * Handle DELETE requests:
     * - DELETE /api/guides/{id}: Delete guide
     */
    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        String pathInfo = request.getPathInfo();

        if (pathInfo != null && !pathInfo.equals("/")) {
            String id = pathInfo.substring(1); // Remove leading slash

            boolean deleted = service.delete(id);

            if (deleted) {
                JsonObject jsonResponse = new JsonObject();
                jsonResponse.addProperty("message", "Guide deleted successfully");
                out.print(jsonResponse);
                response.setStatus(HttpServletResponse.SC_OK);
            } else {
                sendError(response, HttpServletResponse.SC_NOT_FOUND, "Guide not found with ID: " + id);
            }
        } else {
            sendError(response, HttpServletResponse.SC_BAD_REQUEST, "Guide ID is required for deletion");
        }

        out.flush();
    }

    /**
     * Send error response
     */
    private void sendError(HttpServletResponse response, int status, String message) throws IOException {
        response.setStatus(status);
        JsonObject error = new JsonObject();
        error.addProperty("error", message);
        response.getWriter().print(gson.toJson(error));
    }
}
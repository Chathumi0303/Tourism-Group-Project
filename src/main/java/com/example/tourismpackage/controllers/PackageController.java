package com.example.tourismpackage.controllers;

import com.example.tourismpackage.models.DestinationPackage;
import com.example.tourismpackage.services.PackageService;
import com.fasterxml.jackson.databind.ObjectMapper;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.List;
import java.io.BufferedReader;

@WebServlet("/packages/*")
public class PackageController extends HttpServlet {
    private final PackageService packageService = new PackageService();
    private final ObjectMapper mapper = new ObjectMapper();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");

        // Extract ID from path or query parameter
        String pathInfo = request.getPathInfo();
        String id = null;

        // Check if ID is in the path (e.g., /packages/123)
        if (pathInfo != null && pathInfo.length() > 1) {
            id = pathInfo.substring(1);
        } else {
            // Fallback to query parameter
            id = request.getParameter("id");
        }

        if (id == null || id.isEmpty()) {
            List<DestinationPackage> packages = packageService.getAllPackages();
            response.getWriter().write(mapper.writeValueAsString(packages));
        } else {
            DestinationPackage pkg = packageService.getPackageById(id);
            if (pkg != null) {
                response.getWriter().write(mapper.writeValueAsString(pkg));
            } else {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                response.getWriter().write("{\"error\": \"Package not found with ID: " + id + "\"}");
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Read the request body
        StringBuilder buffer = new StringBuilder();
        BufferedReader reader = request.getReader();
        String line;
        while ((line = reader.readLine()) != null) {
            buffer.append(line);
        }

        // Parse the JSON into a DestinationPackage object
        DestinationPackage pkg = mapper.readValue(buffer.toString(), DestinationPackage.class);

        boolean success;
        try {
            success = packageService.addPackage(pkg);
        } catch (IOException e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to save package: " + e.getMessage());
            return;
        }

        if (success) {
            response.setStatus(HttpServletResponse.SC_CREATED);
            response.getWriter().write("{\"message\": \"Package created successfully\", \"id\": \"" + pkg.getId() + "\"}");
        } else {
            response.setStatus(HttpServletResponse.SC_CONFLICT);
            response.getWriter().write("{\"error\": \"Package with ID " + pkg.getId() + " already exists\"}");
        }
    }

    @Override
    protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");

        // Extract ID from path or query parameter
        String pathInfo = request.getPathInfo();
        String id = null;

        // Check if ID is in the path (e.g., /packages/123)
        if (pathInfo != null && pathInfo.length() > 1) {
            id = pathInfo.substring(1);
        } else {
            // Fallback to query parameter
            id = request.getParameter("id");
        }

        // Read the request body
        StringBuilder buffer = new StringBuilder();
        BufferedReader reader = request.getReader();
        String line;
        while ((line = reader.readLine()) != null) {
            buffer.append(line);
        }

        // Parse the JSON into a DestinationPackage object
        DestinationPackage updatedPkg = mapper.readValue(buffer.toString(), DestinationPackage.class);

        // Ensure ID consistency if provided in path/query
        if (id != null && !id.isEmpty()) {
            updatedPkg.setId(id);
        }

        boolean success;
        try {
            success = packageService.updatePackage(updatedPkg);
        } catch (IOException e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to update package: " + e.getMessage());
            return;
        }

        if (success) {
            response.getWriter().write("{\"message\": \"Package with ID " + updatedPkg.getId() + " updated successfully\"}");
        } else {
            response.setStatus(HttpServletResponse.SC_NOT_FOUND);
            response.getWriter().write("{\"error\": \"Package with ID " + updatedPkg.getId() + " not found\"}");
        }
    }

    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");

        // Extract ID from path or query parameter
        String pathInfo = request.getPathInfo();
        String id = null;

        // Check if ID is in the path (e.g., /packages/123)
        if (pathInfo != null && pathInfo.length() > 1) {
            id = pathInfo.substring(1);
        } else {
            // Fallback to query parameter
            id = request.getParameter("id");
        }

        if (id == null || id.isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"error\": \"ID parameter is required for DELETE operation\"}");
            return;
        }

        try {
            boolean success = packageService.deletePackage(id);
            if (success) {
                response.getWriter().write("{\"message\": \"Package with ID " + id + " deleted successfully\"}");
            } else {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                response.getWriter().write("{\"error\": \"Package with ID " + id + " not found\"}");
            }
        } catch (IOException e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to delete package: " + e.getMessage());
        }
    }
}

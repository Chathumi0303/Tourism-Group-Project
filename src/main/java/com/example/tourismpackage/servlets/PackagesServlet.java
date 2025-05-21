package com.example.tourismpackage.servlets;

import com.example.tourismpackage.models.DestinationPackage;
import com.example.tourismpackage.services.PackageService;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet("/admin")
public class PackagesServlet extends HttpServlet {
    private final PackageService packageService = new PackageService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the action parameter
        String action = request.getParameter("action");

        // Default to list if no action is specified
        if (action == null || action.isEmpty()) {
            action = "list";
        }

        // Log the action for debugging
        System.out.println("Admin servlet action: " + action);

        switch (action) {
            case "list":
                // Show list of all packages
                request.setAttribute("packages", packageService.getAllPackages());
                request.getRequestDispatcher("admin.jsp").forward(request, response);
                break;

            case "create":
                // Show create form
                request.getRequestDispatcher("create.jsp").forward(request, response);
                break;

            case "edit":
                // Get ID from query param
                String id = request.getParameter("id");
                if (id == null || id.isEmpty()) {
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Package ID is required for edit action");
                    return;
                }

                DestinationPackage pkg = packageService.getPackageById(id);
                if (pkg == null) {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "Package with ID '" + id + "' not found");
                    return;
                }

                request.setAttribute("package", pkg);
                request.getRequestDispatcher("edit.jsp").forward(request, response);
                break;

            case "view":
                // View a single package details
                String viewId = request.getParameter("id");
                if (viewId == null || viewId.isEmpty()) {
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Package ID is required for view action");
                    return;
                }

                DestinationPackage viewPkg = packageService.getPackageById(viewId);
                if (viewPkg == null) {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "Package with ID '" + viewId + "' not found");
                    return;
                }

                request.setAttribute("package", viewPkg);
                request.getRequestDispatcher("/WEB-INF/jsp/viewPackage.jsp").forward(request, response);
                break;

            case "delete":
                // Confirm deletion of a package
                String deleteId = request.getParameter("id");
                if (deleteId == null || deleteId.isEmpty()) {
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Package ID is required for delete action");
                    return;
                }

                DestinationPackage deletePkg = packageService.getPackageById(deleteId);
                if (deletePkg == null) {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "Package with ID '" + deleteId + "' not found");
                    return;
                }

                request.setAttribute("package", deletePkg);
                request.getRequestDispatcher("/WEB-INF/jsp/deleteConfirm.jsp").forward(request, response);
                break;

            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Unknown action: " + action);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null || action.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Action parameter is required");
            return;
        }

        switch (action) {
            case "create":
                // Process create form submission
                // Note: This would typically extract form parameters and create a new package
                // For now, we'll redirect back to the list page
                response.sendRedirect(request.getContextPath() + "/admin?action=list");
                break;

            case "update":
                // Process edit form submission
                String updateId = request.getParameter("id");
                if (updateId == null || updateId.isEmpty()) {
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Package ID is required for update action");
                    return;
                }

                // Process update logic here
                // ...

                response.sendRedirect(request.getContextPath() + "/admin?action=list");
                break;

            case "delete":
                // Process delete confirmation
                String deleteId = request.getParameter("id");
                if (deleteId == null || deleteId.isEmpty()) {
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Package ID is required for delete action");
                    return;
                }

                try {
                    boolean success = packageService.deletePackage(deleteId);
                    if (!success) {
                        response.sendError(HttpServletResponse.SC_NOT_FOUND, "Package with ID '" + deleteId + "' not found");
                        return;
                    }
                } catch (IOException e) {
                    response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to delete package: " + e.getMessage());
                    return;
                }

                response.sendRedirect(request.getContextPath() + "/admin?action=list");
                break;

            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Unknown action: " + action);
                break;
        }
    }
}

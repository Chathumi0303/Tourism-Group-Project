package com.example.tourismpackage.controllers;

import com.example.tourismpackage.models.Feedbacks;
import com.example.tourismpackage.services.FeedbackService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import com.google.gson.Gson;

import java.io.BufferedReader;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "FeedbackController", urlPatterns = {
        "/api/feedbacks",        // For GET all and POST
        "/api/feedbacks/*"       // For GET by ID, PUT, DELETE
})
public class FeedbackController extends HttpServlet {
    private final FeedbackService service = new FeedbackService();
    private final Gson gson = new Gson();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");

        String pathInfo = request.getPathInfo();

        try {
            if (pathInfo == null || pathInfo.equals("/")) {
                // GET all feedbacks
                List<Feedbacks> allFeedbacks = service.getAllFeedbacks();
                response.getWriter().write(gson.toJson(allFeedbacks));
            } else {
                // GET feedback by ID
                String id = pathInfo.substring(1); // Remove leading slash
                Feedbacks feedback = service.getFeedbackById(id);
                if (feedback != null) {
                    response.getWriter().write(gson.toJson(feedback));
                } else {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "Feedback not found");
                }
            }
        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            Feedbacks feedback = parseRequest(request);
            service.addFeedback(feedback);
            response.setContentType("application/json");
            response.getWriter().write(gson.toJson(feedback));
        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, e.getMessage());
        }
    }

    @Override
    protected void doPut(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String pathInfo = request.getPathInfo();

        if (pathInfo == null || pathInfo.equals("/")) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing feedback ID");
            return;
        }

        try {
            String id = pathInfo.substring(1); // Remove leading slash
            Feedbacks feedback = parseRequest(request);
            feedback.setId(id); // Ensure ID from URL is set

            service.updateFeedback(feedback);
            response.setContentType("application/json");
            response.getWriter().write(gson.toJson(feedback));
        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, e.getMessage());
        }
    }

    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String pathInfo = request.getPathInfo();

        if (pathInfo == null || pathInfo.equals("/")) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing feedback ID");
            return;
        }

        try {
            String id = pathInfo.substring(1); // Remove leading slash
            service.deleteFeedback(id);
            response.setContentType("application/json");
            response.getWriter().write("{\"message\": \"Feedback deleted successfully\"}");
        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getMessage());
        }
    }

    private Feedbacks parseRequest(HttpServletRequest request) throws IOException {
        BufferedReader reader = request.getReader();
        return gson.fromJson(reader, Feedbacks.class);
    }
}

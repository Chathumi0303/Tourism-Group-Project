package com.example.tourismpackage.servlets;

import com.example.tourismpackage.dtos.TouristGuideDTO;
import com.example.tourismpackage.models.TouristGuide;
import com.example.tourismpackage.services.TouristGuideService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;
import java.util.Optional;

@WebServlet(name="AdminServlet")
public class AdminServlet extends HttpServlet {
    private TouristGuideService touristGuideService;

    @Override
    public void init() throws ServletException {
        touristGuideService = new TouristGuideService();
        super.init();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null) {

            List<TouristGuide> guides = touristGuideService.getAllGuides();
            System.out.println("there are guides"+guides.size());
            request.setAttribute("guides", guides);
            request.getRequestDispatcher("admin.jsp").forward(request, response);

        } else if ("create".equals(action)) {

            request.getRequestDispatcher("create.jsp").forward(request, response);

        } else if ("edit".equals(action)) {
            // Get tour guide ID from request
            String tourGuideIdStr = request.getParameter("tourGuideId");
            if (tourGuideIdStr == null || tourGuideIdStr.isEmpty()) {
                throw new ServletException("Tour Guide ID is required for edit action.");
            }

            try {
                Optional<TouristGuide> guide = touristGuideService.getById(tourGuideIdStr);
                if (guide.isEmpty()) {
                    throw new ServletException("Tour Guide not found.");
                }
                request.setAttribute("guide", guide);
                request.getRequestDispatcher("edit.jsp").forward(request, response);
            } catch (NumberFormatException e) {
                throw new ServletException("Invalid Tour Guide ID.");
            }
        } else {
            throw new ServletException("Unknown action: " + action);
        }
    }
}

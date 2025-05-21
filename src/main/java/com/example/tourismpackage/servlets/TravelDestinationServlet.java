package com.example.tourismpackage.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "TravelDestinationServlet", urlPatterns = {
        "/admin",
        "/create",
        "/edit"
})
public class TravelDestinationServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getServletPath();
        System.out.println(path);
        switch (path) {
            case "/admin":
                request.getRequestDispatcher("admin.jsp").forward(request, response);
                break;
            case "/create":
                request.getRequestDispatcher("create.jsp").forward(request, response);
                break;
            default:
                System.out.println("edit route "+path);
                request.getRequestDispatcher("edit.jsp").forward(request, response);
        }
    }
}
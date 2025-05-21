package com.example.tourismpackage;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;


@WebServlet(name = "helloServlet", value = "/hello")
public class HelloApplication extends HttpServlet {

    public void init() {

    }

    public void destroy() {
    }
}

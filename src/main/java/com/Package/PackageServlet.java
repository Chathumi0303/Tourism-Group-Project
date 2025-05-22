package com.Package;

import java.io.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/PackageServlet")
public class PackageServlet extends HttpServlet {
    private static final String FILE_PATH = "package.txt";
    private static final String PROPERTY_FILE_PATH = "package_properties.txt";

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "new":
                showNewForm(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "delete":
                deletePackage(request, response);
                break;
            case "viewProperties":
                viewProperties(request, response);
                break;
            case "editProperty":
                showEditPropertyForm(request, response);
                break;
            case "deleteProperty":
                deleteProperty(request, response);
                break;
            case "list":
            default:
                listPackages(request, response);
                break;
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "insert":
                insertPackage(request, response);
                break;
            case "update":
                updatePackage(request, response);
                break;
            case "addProperty":
                addProperty(request, response);
                break;
            case "updateProperty":
                updateProperty(request, response);
                break;
            default:
                listPackages(request, response);
                break;
        }
    }

    private void listPackages(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Map<String, String>> packages = readPackagesFromFile();
        request.setAttribute("packages", packages);
        request.getRequestDispatcher("packageManagement.jsp").forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("packageManagement.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        List<Map<String, String>> packages = readPackagesFromFile();
        Map<String, String> packageToEdit = null;

        for (Map<String, String> pkg : packages) {
            if (pkg.get("id").equals(id)) {
                packageToEdit = pkg;
                break;
            }
        }

        if (packageToEdit != null) {
            request.setAttribute("package", packageToEdit);
            request.getRequestDispatcher("packageManagement.jsp").forward(request, response);
        } else {
            response.sendRedirect("PackageServlet?action=list");
        }
    }

    private void insertPackage(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Map<String, String> newPackage = new HashMap<>();
        newPackage.put("id", UUID.randomUUID().toString());
        newPackage.put("name", request.getParameter("packageName"));
        newPackage.put("destination", request.getParameter("destination"));
        newPackage.put("duration", request.getParameter("duration"));
        newPackage.put("price", request.getParameter("price"));
        newPackage.put("type", request.getParameter("type"));
        newPackage.put("description", request.getParameter("description"));
        newPackage.put("inclusions", request.getParameter("inclusions"));
        newPackage.put("imageUrl", request.getParameter("imageUrl"));

        List<Map<String, String>> packages = readPackagesFromFile();
        packages.add(newPackage);
        writePackagesToFile(packages);

        response.sendRedirect("PackageServlet?action=list");
    }

    private void updatePackage(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("packageId");
        List<Map<String, String>> packages = readPackagesFromFile();

        for (Map<String, String> pkg : packages) {
            if (pkg.get("id").equals(id)) {
                pkg.put("name", request.getParameter("packageName"));
                pkg.put("destination", request.getParameter("destination"));
                pkg.put("duration", request.getParameter("duration"));
                pkg.put("price", request.getParameter("price"));
                pkg.put("type", request.getParameter("type"));
                pkg.put("description", request.getParameter("description"));
                pkg.put("inclusions", request.getParameter("inclusions"));
                pkg.put("imageUrl", request.getParameter("imageUrl"));
                break;
            }
        }

        writePackagesToFile(packages);
        response.sendRedirect("PackageServlet?action=list");
    }

    private void deletePackage(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        List<Map<String, String>> packages = readPackagesFromFile();

        // First delete all properties associated with this package
        List<Map<String, String>> allProperties = readAllProperties();
        allProperties.removeIf(prop -> prop.get("packageId").equals(id));
        writeAllProperties(allProperties);

        // Then delete the package
        packages.removeIf(pkg -> pkg.get("id").equals(id));
        writePackagesToFile(packages);

        response.sendRedirect("PackageServlet?action=list");
    }

    private List<Map<String, String>> readPackagesFromFile() throws IOException {
        List<Map<String, String>> packages = new ArrayList<>();
        File file = new File(getServletContext().getRealPath(FILE_PATH));

        if (!file.exists()) {
            file.createNewFile();
            return packages;
        }

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                if (!line.trim().isEmpty()) {
                    Map<String, String> packageData = new HashMap<>();
                    String[] parts = line.split("\\|");
                    for (String part : parts) {
                        String[] keyValue = part.split("=", 2);
                        if (keyValue.length == 2) {
                            packageData.put(keyValue[0], keyValue[1]);
                        }
                    }
                    packages.add(packageData);
                }
            }
        }

        return packages;
    }

    private void writePackagesToFile(List<Map<String, String>> packages) throws IOException {
        File file = new File(getServletContext().getRealPath(FILE_PATH));

        try (PrintWriter writer = new PrintWriter(new FileWriter(file))) {
            for (Map<String, String> pkg : packages) {
                StringBuilder line = new StringBuilder();
                for (Map.Entry<String, String> entry : pkg.entrySet()) {
                    if (line.length() > 0) {
                        line.append("|");
                    }
                    line.append(entry.getKey()).append("=").append(entry.getValue());
                }
                writer.println(line.toString());
            }
        }
    }

    private void viewProperties(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String packageId = request.getParameter("packageId");
        List<Map<String, String>> properties = readPropertiesForPackage(packageId);
        request.setAttribute("packageId", packageId);
        request.setAttribute("properties", properties);
        request.getRequestDispatcher("viewProperty.jsp").forward(request, response);
    }

    private void showEditPropertyForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String packageId = request.getParameter("packageId");
        String propertyId = request.getParameter("propertyId");
        Map<String, String> property = readProperty(packageId, propertyId);

        if (property != null) {
            request.setAttribute("packageId", packageId);
            request.setAttribute("property", property);
            request.getRequestDispatcher("packageManagement.jsp").forward(request, response);
        } else {
            response.sendRedirect("PackageServlet?action=viewProperties&packageId=" + packageId);
        }
    }

    private void addProperty(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String packageId = request.getParameter("packageId");
        Map<String, String> newProperty = new HashMap<>();
        newProperty.put("id", UUID.randomUUID().toString());
        newProperty.put("packageId", packageId);
        newProperty.put("name", request.getParameter("propertyName"));
        newProperty.put("value", request.getParameter("propertyValue"));
        newProperty.put("description", request.getParameter("propertyDescription"));

        List<Map<String, String>> allProperties = readAllProperties();
        allProperties.add(newProperty);
        writeAllProperties(allProperties);

        response.sendRedirect("PackageServlet?action=viewProperties&packageId=" + packageId);
    }

    private void updateProperty(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String packageId = request.getParameter("packageId");
        String propertyId = request.getParameter("propertyId");

        List<Map<String, String>> allProperties = readAllProperties();
        for (Map<String, String> property : allProperties) {
            if (property.get("id").equals(propertyId) && property.get("packageId").equals(packageId)) {
                property.put("name", request.getParameter("propertyName"));
                property.put("value", request.getParameter("propertyValue"));
                property.put("description", request.getParameter("propertyDescription"));
                break;
            }
        }

        writeAllProperties(allProperties);
        response.sendRedirect("PackageServlet?action=viewProperties&packageId=" + packageId);
    }

    private void deleteProperty(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String packageId = request.getParameter("packageId");
        String propertyId = request.getParameter("propertyId");

        List<Map<String, String>> allProperties = readAllProperties();
        allProperties.removeIf(prop ->
                prop.get("id").equals(propertyId) && prop.get("packageId").equals(packageId));

        writeAllProperties(allProperties);
        response.sendRedirect("PackageServlet?action=viewProperties&packageId=" + packageId);
    }

    private Map<String, String> readProperty(String packageId, String propertyId) throws IOException {
        List<Map<String, String>> allProperties = readAllProperties();
        for (Map<String, String> property : allProperties) {
            if (property.get("id").equals(propertyId) && property.get("packageId").equals(packageId)) {
                return property;
            }
        }
        return null;
    }

    private List<Map<String, String>> readPropertiesForPackage(String packageId) throws IOException {
        List<Map<String, String>> allProperties = readAllProperties();
        List<Map<String, String>> packageProperties = new ArrayList<>();

        for (Map<String, String> property : allProperties) {
            if (property.get("packageId").equals(packageId)) {
                packageProperties.add(property);
            }
        }

        return packageProperties;
    }

    private List<Map<String, String>> readAllProperties() throws IOException {
        List<Map<String, String>> properties = new ArrayList<>();
        File file = new File(getServletContext().getRealPath(PROPERTY_FILE_PATH));

        if (!file.exists()) {
            file.createNewFile();
            return properties;
        }

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                if (!line.trim().isEmpty()) {
                    Map<String, String> propertyData = new HashMap<>();
                    String[] parts = line.split("\\|");
                    for (String part : parts) {
                        String[] keyValue = part.split("=", 2);
                        if (keyValue.length == 2) {
                            propertyData.put(keyValue[0], keyValue[1]);
                        }
                    }
                    properties.add(propertyData);
                }
            }
        }

        return properties;
    }

    private void writeAllProperties(List<Map<String, String>> properties) throws IOException {
        File file = new File(getServletContext().getRealPath(PROPERTY_FILE_PATH));

        try (PrintWriter writer = new PrintWriter(new FileWriter(file))) {
            for (Map<String, String> property : properties) {
                StringBuilder line = new StringBuilder();
                for (Map.Entry<String, String> entry : property.entrySet()) {
                    if (line.length() > 0) {
                        line.append("|");
                    }
                    line.append(entry.getKey()).append("=").append(entry.getValue());
                }
                writer.println(line.toString());
            }
        }
    }
}
package com.example.tourismpackage.services;

import com.example.tourismpackage.models.DestinationPackage;
import com.example.tourismpackage.utils.PackageQuickSort;

import java.io.*;
import java.nio.file.*;
import java.util.*;
import java.util.stream.Collectors;

public class PackageService {
    private static final String FILE_PATH = "packages.txt";
    private List<DestinationPackage> packages = new ArrayList<>();

    public PackageService() {
        loadFromFile();
    }

    // Load all packages from the file
    private void loadFromFile() {
        try {
            if (!Files.exists(Paths.get(FILE_PATH))) {
                Files.createFile(Paths.get(FILE_PATH));
                return;
            }

            List<String> lines = Files.readAllLines(Paths.get(FILE_PATH));
            packages.clear();

            for (String line : lines) {
                if (line.trim().isEmpty()) continue;

                String[] parts = line.split("\\|");
                if (parts.length < 5) continue;

                DestinationPackage pkg = new DestinationPackage();
                pkg.setId(parts[0]);
                pkg.setName(parts[1]);
                pkg.setDescription(parts[2]);
                pkg.setPrice(Double.parseDouble(parts[3]));

                String[] featureArray = parts[4].split(",");
                pkg.setFeatures(Arrays.asList(featureArray));
                packages.add(pkg);
            }
        } catch (IOException e) {
            System.err.println("Error loading packages: " + e.getMessage());
        }
    }

    // Save all packages back to the file
    private void saveToFile() throws IOException {
        List<String> lines = packages.stream()
                .map(this::packageToString)
                .collect(Collectors.toList());

        Files.write(Paths.get(FILE_PATH), lines);
    }

    // Convert package object to string format
    private String packageToString(DestinationPackage pkg) {
        String features = String.join(",", pkg.getFeatures());
        return String.join("|",
                pkg.getId(),
                pkg.getName(),
                pkg.getDescription(),
                String.valueOf(pkg.getPrice()),
                features
        );
    }

    public List<DestinationPackage> getAllPackages() {
        
        return new ArrayList<>(packages);
    }

    public List<DestinationPackage> getAllPackagesSortedByPrice() {
        List<DestinationPackage> allPackages = getAllPackages();
        return PackageQuickSort.sortByPrice(allPackages);
    }


    public List<DestinationPackage> getAllPackagesSortedByPriceDescending() {
        List<DestinationPackage> allPackages = getAllPackages();
        return PackageQuickSort.sortByPriceDescending(allPackages);
    }

    // Get package by ID
    public DestinationPackage getPackageById(String id) {
        return packages.stream()
                .filter(p -> p.getId().equals(id))
                .findFirst()
                .orElse(null);
    }

    // Add a new package
    public boolean addPackage(DestinationPackage newPackage) throws IOException {
        // Generate UUID if ID is null or empty
        if (newPackage.getId() == null || newPackage.getId().trim().isEmpty()) {
            newPackage.setId(UUID.randomUUID().toString());
        }

        // Check for duplicate ID
        if (getPackageById(newPackage.getId()) != null) {
            return false; // Duplicate ID
        }

        packages.add(newPackage);
        saveToFile();
        return true;
    }

    // Update existing package
    public boolean updatePackage(DestinationPackage updatedPkg) throws IOException {
        DestinationPackage existing = getPackageById(updatedPkg.getId());
        if (existing == null) return false;

        existing.setName(updatedPkg.getName());
        existing.setDescription(updatedPkg.getDescription());
        existing.setPrice(updatedPkg.getPrice());
        existing.setFeatures(updatedPkg.getFeatures());

        saveToFile();
        return true;
    }

    // Delete package by ID
    public boolean deletePackage(String id) throws IOException {
        DestinationPackage toRemove = getPackageById(id);
        if (toRemove == null) return false;

        packages.remove(toRemove);
        saveToFile();
        return true;
    }
}

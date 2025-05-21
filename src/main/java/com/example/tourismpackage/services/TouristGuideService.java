package com.example.tourismpackage.services;

import com.example.tourismpackage.models.TouristGuide;

import java.io.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.UUID;
import java.util.stream.Collectors;

public class TouristGuideService {
    private static final String DATA_FILE = "guides.txt";

    /**
     * Create a new TouristGuide and save to file
     * @param guide The TouristGuide object to create
     * @return The created TouristGuide with generated ID
     */
    public TouristGuide create(TouristGuide guide) {
        List<TouristGuide> guides = getAllGuides();

        // Generate a unique ID for the guide (using UUID)
        String id = UUID.randomUUID().toString();
        guide.setId(id);

        guides.add(guide);
        saveToFile(guides);

        return guide;
    }

    /**
     * Get a TouristGuide by ID
     * @param id The ID of the guide to find
     * @return Optional containing the guide if found
     */
    public Optional<TouristGuide> getById(String id) {
        List<TouristGuide> guides = getAllGuides();

        return guides.stream()
                .filter(guide -> guide.getId().equals(id))
                .findFirst();
    }

    /**
     * Get all TouristGuides
     * @return List of all TouristGuides
     */
    public List<TouristGuide> getAllGuides() {
        File file = new File(DATA_FILE);

        if (!file.exists()) {
            return new ArrayList<>();
        }

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            List<TouristGuide> guides = new ArrayList<>();
            String line;

            while ((line = reader.readLine()) != null) {
                TouristGuide guide = deserialize(line);
                guides.add(guide);
            }

            return guides;
        } catch (IOException e) {
            System.err.println("Error reading from file: " + e.getMessage());
            return new ArrayList<>();
        }
    }

    /**
     * Update an existing TouristGuide
     * @param id The ID of the guide to update
     * @param updatedGuide The updated guide information
     * @return Optional containing the updated guide if found
     */
    public Optional<TouristGuide> update(String id, TouristGuide updatedGuide) {
        List<TouristGuide> guides = getAllGuides();

        boolean found = false;
        for (int i = 0; i < guides.size(); i++) {
            if (guides.get(i).getId().equals(id)) {
                // Preserve the original ID
                updatedGuide.setId(id);
                guides.set(i, updatedGuide);
                found = true;
                break;
            }
        }

        if (found) {
            saveToFile(guides);
            return Optional.of(updatedGuide);
        } else {
            return Optional.empty();
        }
    }

    /**
     * Delete a TouristGuide by ID
     * @param id The ID of the guide to delete
     * @return true if deleted, false if not found
     */
    public boolean delete(String id) {
        List<TouristGuide> guides = getAllGuides();
        int originalSize = guides.size();

        List<TouristGuide> filteredGuides = guides.stream()
                .filter(guide -> !guide.getId().equals(id))
                .collect(Collectors.toList());

        if (filteredGuides.size() < originalSize) {
            saveToFile(filteredGuides);
            return true;
        }

        return false;
    }

    /**
     * Save the list of guides to the file
     * @param guides List of guides to save
     */
    private void saveToFile(List<TouristGuide> guides) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(DATA_FILE))) {
            for (TouristGuide guide : guides) {
                writer.write(serialize(guide));
                writer.newLine();
            }
        } catch (IOException e) {
            System.err.println("Error writing to file: " + e.getMessage());
        }
    }

    /**
     * Serialize a TouristGuide to a string
     * @param guide The guide to serialize
     * @return Serialized string representation
     */
    private String serialize(TouristGuide guide) {
        return String.join("|",
                guide.getId(),
                guide.getName(),
                guide.getContactNumber(),
                guide.getImage(),
                guide.getDescription());
    }

    /**
     * Deserialize a string to a TouristGuide
     * @param serialized The serialized string
     * @return TouristGuide object
     */
    private TouristGuide deserialize(String serialized) {
        String[] parts = serialized.split("\\|");

        TouristGuide guide = new TouristGuide();
        guide.setId(parts[0]);
        guide.setName(parts[1]);
        guide.setContactNumber(parts[2]);
        guide.setImage(parts[3]);
        guide.setDescription(parts[4]);

        return guide;
    }
}
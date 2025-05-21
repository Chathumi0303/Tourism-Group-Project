package com.example.tourismpackage.services;

import com.example.tourismpackage.models.TravelDestination;
import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class TravelDestinationCrud {
    private static final String FILE_PATH = "travel_destinations.txt";

    // Create a new destination
    public void createDestination(TravelDestination destination) throws IOException {
        List<TravelDestination> destinations = getAllDestinations();
        destinations.add(destination);
        saveAllDestinations(destinations);
    }

    // Read all destinations
    public List<TravelDestination> getAllDestinations() throws IOException {
        List<TravelDestination> destinations = new ArrayList<>();
        File file = new File(FILE_PATH);

        if (!file.exists()) {
            return destinations;
        }

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split("\\|");
                if (parts.length == 5) {
                    TravelDestination dest = new TravelDestination(
                            parts[0], // id
                            parts[1], // name
                            parts[2], // location
                            parts[3], // image
                            parts[4]  // description
                    );
                    destinations.add(dest);
                }
            }
        }
        return destinations;
    }

    // Get a destination by ID
    public TravelDestination getDestinationById(String id) throws IOException {
        List<TravelDestination> destinations = getAllDestinations();
        for (TravelDestination dest : destinations) {
            if (dest.getId().equals(id)) {
                return dest;
            }
        }
        return null;
    }

    // Update a destination
    public void updateDestination(TravelDestination updatedDestination) throws IOException {
        List<TravelDestination> destinations = getAllDestinations();
        for (int i = 0; i < destinations.size(); i++) {
            if (destinations.get(i).getId().equals(updatedDestination.getId())) {
                destinations.set(i, updatedDestination);
                break;
            }
        }
        saveAllDestinations(destinations);
    }

    // Delete a destination
    public void deleteDestination(String id) throws IOException {
        List<TravelDestination> destinations = getAllDestinations();
        destinations.removeIf(dest -> dest.getId().equals(id));
        saveAllDestinations(destinations);
    }

    // Helper method to save all destinations to file
    private void saveAllDestinations(List<TravelDestination> destinations) throws IOException {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH))) {
            for (TravelDestination dest : destinations) {
                writer.write(String.join("|",
                        dest.getId(),
                        dest.getName(),
                        dest.getLocation(),
                        dest.getImage(),
                        dest.getDescription()));
                writer.newLine();
            }
        }
    }

    // Generate a unique ID (simple implementation)
    public String generateId() {
        return String.valueOf(System.currentTimeMillis());
    }
}
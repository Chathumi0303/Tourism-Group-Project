package com.example.tourismpackage.services;

import com.example.tourismpackage.models.Feedbacks;

import java.io.*;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

public class FeedbackService {
    private static final String FILE_PATH = "/Users/gimhanrajapaksha/Desktop/projects/tourismpackage/src/data/Feedbacks.txt";

    public List<Feedbacks> getAllFeedbacks() {
        List<Feedbacks> feedbacksList = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split("\\|");
                if (parts.length == 4) {
                    feedbacksList.add(new Feedbacks(parts[0], parts[1], parts[2], parts[3]));
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return feedbacksList;
    }
    public Feedbacks getFeedbackById(String id) {
        try (BufferedReader reader = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split("\\|");
                if (parts.length == 4 && parts[0].equals(id)) {
                    return new Feedbacks(parts[0], parts[1], parts[2], parts[3]);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null; // return null if not found
    }

    public void addFeedback(Feedbacks feedback) {
        String id = UUID.randomUUID().toString();
        feedback.setId(id);

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH, true))) {
            writer.write(feedback.getId() + "|" + feedback.getFeedback() + "|" +
                    feedback.getDestinationPlace() + "|" + feedback.getExperience());
            writer.newLine();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    public void updateFeedback(Feedbacks updatedFeedback) {
        List<Feedbacks> feedbacks = getAllFeedbacks();
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH))) {
            for (Feedbacks fb : feedbacks) {
                if (fb.getId().equals(updatedFeedback.getId())) {
                    fb = updatedFeedback;
                }
                writer.write(fb.getId() + "|" + fb.getFeedback() + "|" +
                        fb.getDestinationPlace() + "|" + fb.getExperience());
                writer.newLine();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public void deleteFeedback(String id) {
        List<Feedbacks> feedbacks = getAllFeedbacks();
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH))) {
            for (Feedbacks fb : feedbacks) {
                if (!fb.getId().equals(id)) {
                    writer.write(fb.getId() + "|" + fb.getFeedback() + "|" +
                            fb.getDestinationPlace() + "|" + fb.getExperience());
                    writer.newLine();
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}

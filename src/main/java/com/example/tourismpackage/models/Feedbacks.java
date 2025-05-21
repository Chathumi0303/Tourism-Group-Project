package com.example.tourismpackage.models;

public class Feedbacks extends BaseModel {
    private String feedback;
    private String destinationPlace;
    private String experience;

    public Feedbacks() {
    }

    public Feedbacks(String id, String feedback, String destinationPlace, String experience) {
        super(id);
        this.feedback = feedback;
        this.destinationPlace = destinationPlace;
        this.experience = experience;
    }

    public String getFeedback() {
        return feedback;
    }

    public void setFeedback(String feedback) {
        this.feedback = feedback;
    }

    public String getDestinationPlace() {
        return destinationPlace;
    }

    public void setDestinationPlace(String destinationPlace) {
        this.destinationPlace = destinationPlace;
    }

    public String getExperience() {
        return experience;
    }

    public void setExperience(String experience) {
        this.experience = experience;
    }
}

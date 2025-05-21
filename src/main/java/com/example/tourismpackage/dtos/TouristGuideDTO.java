package com.example.tourismpackage.dtos;

public class TouristGuideDTO {
    private String name;
    private String contactNumber;
    private String image;
    private String description;

    // Constructors
    public TouristGuideDTO() {
    }

    public TouristGuideDTO(String name, String contactNumber, String image, String description) {
        this.name = name;
        this.contactNumber = contactNumber;
        this.image = image;
        this.description = description;
    }

    // Getters and Setters
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getContactNumber() {
        return contactNumber;
    }

    public void setContactNumber(String contactNumber) {
        this.contactNumber = contactNumber;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}
package com.example.tourismpackage.models;

public class TouristGuide extends Person {
    private String id;
    private String image;
    private String description;

    // Default constructor
    public TouristGuide() {
        super();
    }

    // Parameterized constructor
    public TouristGuide(String name, String contactNumber, String image, String description) {
        super(name, contactNumber);
        this.image = image;
        this.description = description;
    }

    // Constructor with ID
    public TouristGuide(String id, String name, String contactNumber, String image, String description) {
        super(name, contactNumber);
        this.id = id;
        this.image = image;
        this.description = description;
    }

    // Getters and Setters for encapsulation
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
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

    // Method overriding for polymorphism
    @Override
    public String toString() {
        return "TouristGuide [id=" + id + ", name=" + getName() + ", contactNumber=" + getContactNumber() +
                ", image=" + image + ", description=" + description + "]";
    }
}

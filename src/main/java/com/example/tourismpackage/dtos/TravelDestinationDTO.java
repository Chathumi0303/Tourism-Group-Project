package com.example.tourismpackage.dtos;

public class TravelDestinationDTO {

    private String id;
    private String name;
    private String location;
    private String image;
    private String description;

    // Constructors
    public TravelDestinationDTO() {
    }

    public TravelDestinationDTO(String id, String name, String location, String image, String description) {
        this.id = id;
        this.name = name;
        this.location = location;
        this.image = image;
        this.description = description;
    }

    // Getters and Setters
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
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

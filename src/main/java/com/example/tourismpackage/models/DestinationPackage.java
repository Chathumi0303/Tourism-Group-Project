package com.example.tourismpackage.models;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import java.util.List;

@JsonIgnoreProperties(ignoreUnknown = true)
public class DestinationPackage {
    private String id;
    private String name;
    private String description;
    private double price;
    private List<String> features;

    // Default constructor
    public DestinationPackage() {}

    // Parameterized constructor
    public DestinationPackage(String id, String name, String description, double price, List<String> features) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.price = price;
        this.features = features;
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

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public List<String> getFeatures() {
        return features;
    }

    public void setFeatures(List<String> features) {
        this.features = features;
    }

    @Override
    public String toString() {
        return "DestinationPackage{" +
                "id='" + id + '\'' +
                ", name='" + name + '\'' +
                ", description='" + description + '\'' +
                ", price=" + price +
                ", features=" + features +
                '}';
    }
}

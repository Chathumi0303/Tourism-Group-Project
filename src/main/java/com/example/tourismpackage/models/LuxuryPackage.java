package com.example.tourismpackage.models;

import java.util.List;

public class LuxuryPackage extends DestinationPackage {

    private String luxuryFeature;

    public LuxuryPackage() {

    }

    public LuxuryPackage(String id, String name, String description, double price,
                         List<String> features, String luxuryFeature) {
        super(id, name, description, price, features);
        this.luxuryFeature = luxuryFeature;
    }

    public String getLuxuryFeature() {
        return luxuryFeature;
    }

    public void setLuxuryFeature(String luxuryFeature) {
        this.luxuryFeature = luxuryFeature;
    }

    @Override
    public String toString() {
        return "LuxuryPackage{" +
                "luxuryFeature='" + luxuryFeature + '\'' +
                "} " + super.toString();
    }
}
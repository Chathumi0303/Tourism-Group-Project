package com.example.tourismpackage.models;

public class BaseModel {
    private String id;

    public BaseModel() {
    }

    public BaseModel(String id) {
        this.id = id;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }
}

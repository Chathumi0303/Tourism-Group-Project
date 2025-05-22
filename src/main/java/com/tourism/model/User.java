package com.tourism.model;

import java.io.Serializable;

public class User implements Serializable {
    private String firstName;
    private String lastName;
    private String email;
    private String phone;
    private String password;
    private String dob;
    private String address;
    private String travelPreference;
    
    public User() {}
    
    public User(String firstName, String lastName, String email, String phone, String password) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.phone = phone;
        this.password = password;
    }
    
    // Getters and setters
    public String getFirstName() { return firstName; }
    public void setFirstName(String firstName) { this.firstName = firstName; }
    
    public String getLastName() { return lastName; }
    public void setLastName(String lastName) { this.lastName = lastName; }
    
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
    
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    
    // Additional getters and setters
    public String getDob() { return dob; }
    public void setDob(String dob) { this.dob = dob; }
    
    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }
    
    public String getTravelPreference() { return travelPreference; }
    public void setTravelPreference(String travelPreference) { this.travelPreference = travelPreference; }
    
    @Override
    public String toString() {
        return firstName + "," + lastName + "," + email + "," + phone + "," + password + "," + 
               (dob != null ? dob : "") + "," + 
               (address != null ? address : "") + "," + 
               (travelPreference != null ? travelPreference : "");
    }
}



package model;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;

public class Resident {
    private String residentId;
    private String email; // FK to User
    private String firstname;
    private String lastname;
    private String gender;
    private String phone;
    private String address;
    private String roomId; // FK to Room

    // Constructors
    public Resident() {}

    public Resident( String email, String firstName, String lastName, String gender, String phone, String address, String roomId) {
        this.email = email;
        this.firstname = firstName;
        this.lastname = lastName;
        this.gender = gender;
        this.phone = phone;
        this.address = address;
        this.roomId = roomId;
    }

    // Getters and Setters
    public String getResidentId() {
        return residentId;
    }
    public void setResidentId(String residentId) {
        this.residentId = residentId;
    }
    
    public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }


    public String getFirstname() {
        return firstname;
    }
    public void setFirstname(String firstName) {
        this.firstname = firstName;
    }

    public String getLastname() {
        return lastname;
    }
    public void setLastname(String lastName) {
        this.lastname = lastName;
    }
    
    public String getGender() {
        return gender;
    }
    public void setGender(String gender) {
        this.gender = gender;
    }
    
    public String getPhone() {
        return phone;
    }
    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getRoomId() {
        return roomId;
    }

    public void setRoomId(String roomId) {
        this.roomId = roomId;
    }
}

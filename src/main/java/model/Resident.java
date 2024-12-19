
package model;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;

public class Resident {
    private String residentId;
    private String userId; // FK to User
    private String firstname;
    private String lastname;
    private String phone;
    private String address;
    private String roomId; // FK to Room

    // Constructors
    public Resident() {}

    public Resident(String residentId, String userId, String firstName, String lastName, String phone, String address, String roomId) {
        this.residentId = residentId;
        this.userId = userId;
        this.firstname = firstName;
        this.lastname = lastName;
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

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
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

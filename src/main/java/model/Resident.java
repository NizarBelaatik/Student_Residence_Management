
package model;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;

import java.sql.Timestamp;
import java.time.LocalDate;

public class Resident {
    private int residentId;
    private String email; // FK to User
    private String firstname;
    private String lastname;
    private String gender;
    private String phone;
    private String address;
    private String roomId;
    private LocalDate c_start_date;
    private LocalDate  c_end_date;// FK to Room

    // Constructors
    

    public Resident( String email, String firstName, String lastName, String gender, String phone, String address, String roomId , LocalDate  c_start_date , LocalDate  c_end_date) {
        this.email = email;
        this.firstname = firstName;
        this.lastname = lastName;
        this.gender = gender;
        this.phone = phone;
        this.address = address;
        this.roomId = roomId;
        this.c_start_date = c_start_date;
        this.c_end_date = c_end_date;
    }
    


    // Getters and Setters
    public int getResidentId() {
        return residentId;
    }
    public void setResidentId(int residentId) {
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

    public String getFullname() { return  firstname + " "+ lastname; }

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

    public LocalDate  getCStartDate() {
        return c_start_date;
    }
    public void setCStartDate(LocalDate  c_start_date) {
        this.c_start_date = c_start_date;
    }

    public LocalDate  getCEndDate() {
        return c_end_date;
    }
    public void setCEndDate(LocalDate  c_end_date) {
        this.c_end_date = c_end_date;
    }
}

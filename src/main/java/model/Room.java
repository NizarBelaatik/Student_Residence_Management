/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import java.io.Serializable;

/**
 *
 * @author night
 */
public class Room {
    private String roomId;
    private String amenities;
    private String size;
    private float price;
    private String state;

    // Constructor with the ID field included
    public Room(String roomId, String size, String amenities, float price, String state) {
        this.roomId = roomId;
        this.amenities = amenities;
        this.size = size;
        this.price = price;
        this.state = state;
    }

    // Getters and setters
    public String getRoomId() {return roomId;}
    public void setRoomId(String id) {this.roomId = roomId;}
  
    public String getAmenities() {return amenities;}
    public void setAmenities(String amenities) {this.amenities = amenities;}

    public String getSize() {return size;}
    public void setSize(String size) {this.size = size;}

    public float getPrice() {return price;}
    public void setPrice(float price) {this.price = price;}

    public String getState() {return state;}
    public void setState(String state) {this.state = state;}
}
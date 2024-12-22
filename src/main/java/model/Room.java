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
    private String name;
    private String equipment;
    private String size;
    private float price;
    private String state;

    // Constructor with the ID field included
    public Room(String roomId, String name, String size, String equipment, float price, String state) {
        this.roomId = roomId;
        this.name = name;
        this.equipment = equipment;
        this.size = size;
        this.price = price;
        this.state = state;
    }


    // Getters and setters
    public String getRoomId() {return roomId;}
    public void setRoomId(String id) {this.roomId = roomId;}
    
    public String getRoomName() {return name;}
    public void setRoomName(String name) {this.name = name;}
  
    public String getEquipment() {return equipment;}
    public void setEquipment(String amenities) {this.equipment = amenities;}

    public String getSize() {return size;}
    public void setSize(String size) {this.size = size;}

    public float getPrice() {return price;}
    public void setPrice(float price) {this.price = price;}

    public String getState() {return state;}
    public void setState(String state) {this.state = state;}
}
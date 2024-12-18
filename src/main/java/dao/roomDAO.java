/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;
import model.Room;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author night
 */
public class roomDAO {
    // Database connection details
    private static final String URL = "jdbc:mysql://localhost:3306/test";
    private static final String USER = "root";
    private static final String PASSWORD = "";
    //private static final Connection conn;

    public static Connection getConnection() throws SQLException {
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(URL, USER, PASSWORD);
        }catch (ClassNotFoundException e) {
            e.printStackTrace();
            throw new SQLException("MySQL JDBC Driver not found.");
        }
    }

    // Add a Room
    public boolean addRoom(Room room) throws SQLException {
        String sql = "INSERT INTO rooms (amenities, size, price, state, roomId) VALUES (?, ?, ?, ?)";
        try (Connection conn = getConnection();
                 PreparedStatement ps = conn.prepareStatement(sql)) {

                ps.setString(1, room.getAmenities());
                ps.setString(2, room.getSize());
                ps.setFloat(3, room.getPrice());
                ps.setString(4, room.getState());

                int rowsAffected = ps.executeUpdate();
                return rowsAffected > 0; // Returns true if the insertion was successful
        }
    }

    // Get Room by ID
    public Room getRoomById(String roomId) throws SQLException {
        String sql = "SELECT roomId, amenities, size, price, state FROM rooms WHERE roomId = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, roomId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Room(
                        rs.getString("roomId"),
                        rs.getString("amenities"),
                        rs.getString("size"),
                        rs.getFloat("price"),
                        rs.getString("state")
                    );
                }
            }
        }
        return null;
    }

    // Get all rooms
    public List<Room> getAllRooms() throws SQLException {
        String sql = "SELECT roomId, amenities, size, price, state FROM rooms";
        List<Room> rooms = new ArrayList<>();
        try (Connection conn = getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                rooms.add(new Room(
                    rs.getString("roomId"),
                    rs.getString("amenities"),
                    rs.getString("size"),
                    rs.getFloat("price"),
                    rs.getString("state")
                ));
            }
        }
        return rooms;
    }
    

    // Update Room
    public boolean updateRoom(Room room) throws SQLException {
        String sql = "UPDATE rooms SET amenities = ?, size = ?, price = ?, state = ? WHERE roomId = ?";
        try (Connection conn = getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, room.getAmenities());
            ps.setString(2, room.getSize());
            ps.setFloat(3, room.getPrice());
            ps.setString(4, room.getState());
            ps.setString(5, room.getRoomId());  // Assuming 'id' is String, change it if needed.

            int rowsUpdated = ps.executeUpdate();
            return rowsUpdated > 0;  // Return true if at least one row is updated.
        }
    }

    // Delete Room
    public void deleteRoom(String roomId) throws SQLException {
        String sql = "DELETE FROM rooms WHERE roomId = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, roomId);
            ps.executeUpdate();
        }
    }
}
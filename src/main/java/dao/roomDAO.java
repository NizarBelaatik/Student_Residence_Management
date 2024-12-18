/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;
import model.Room;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;
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
        // Method to generate a unique roomId
    public static String generateUniqueRoomId() {
        int length = 10;
        String characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        Random random = new Random();
        StringBuilder randomString = new StringBuilder();

        // Loop to generate a random string
        for (int i = 0; i < length; i++) {
            int randomIndex = random.nextInt(characters.length());
            randomString.append(characters.charAt(randomIndex));
        }

        return randomString.toString();
    }
    private static boolean roomIdExists(String roomId) {
        String query = "SELECT COUNT(*) FROM rooms WHERE roomId = ?";
        try (Connection connection = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, roomId);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                return resultSet.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // Add a Room
    public boolean addRoom(Room room) throws SQLException {
        String roomId = generateUniqueRoomId();
        
        // Ensure the generated roomId is unique
        while (roomIdExists(roomId)) {
            roomId = generateUniqueRoomId(); // Generate a new ID if it exists
        }
        String sql = "INSERT INTO rooms (roomId,amenities, size, price, state ) VALUES (?, ?, ?, ?,?)";
        try (Connection conn = getConnection();
                 PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, roomId);
                ps.setString(2, room.getAmenities());
                ps.setString(3, room.getSize());
                ps.setFloat(4, room.getPrice());
                ps.setString(5, room.getState());
                
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
                        rs.getString("size"),
                        rs.getString("amenities"),
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
                    rs.getString("size"),
                    rs.getString("amenities"),
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
    public boolean deleteRoom(String roomId) throws SQLException {
        String sql = "DELETE FROM rooms WHERE roomId = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, roomId);
            
            int rowsUpdated = ps.executeUpdate();
            return rowsUpdated > 0;
        }
    }
}
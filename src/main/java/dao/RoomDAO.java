package dao;

import model.Room;
import service.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

public class RoomDAO {

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
        try (Connection connection = DatabaseConnection.getConnection();
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
        String sql = "INSERT INTO rooms (roomId, name, equipment, size, price, state) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, roomId);
            ps.setString(2, room.getRoomName());
            ps.setString(3, room.getEquipment());
            ps.setString(4, room.getSize());
            ps.setFloat(5, room.getPrice());
            ps.setString(6, room.getState());

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0; // Returns true if the insertion was successful
        }
    }

    // Get Room by ID
    public Room getRoomById(String roomId) throws SQLException {
        String sql = "SELECT roomId, name, equipment, size, price, state FROM rooms WHERE roomId = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, roomId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Room(
                            rs.getString("roomId"),
                            rs.getString("name"),
                            rs.getString("size"),
                            rs.getString("equipment"),
                            rs.getFloat("price"),
                            rs.getString("state")
                    );
                }
            }
        }
        return null;
    }

    // Method to count rooms based on their status (Available, Occupied, or Maintenance)
    public int getRoomsByStatusSize(String status) throws SQLException {
        String sql = "SELECT COUNT(*) AS roomCount FROM rooms WHERE state = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);  // "Available", "Occupied", or "Maintenance"
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("roomCount");
                }
            }
        }
        return 0; // Return 0 if no rooms found with the given status
    }

    // Optionally, you can also create additional methods to get totals, etc.
    public int getTotalRoomsByStatus(String status) throws SQLException {
        String sql = "SELECT COUNT(*) FROM rooms WHERE state = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);  // Return the total number of rooms with the given status
                }
            }
        }
        return 0;
    }
    // Get all rooms
    public List<Room> getAllRooms() throws SQLException {
        String sql = "SELECT roomId, name, equipment, size, price, state FROM rooms";
        List<Room> rooms = new ArrayList<>();
        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                rooms.add(new Room(
                        rs.getString("roomId"),
                        rs.getString("name"),
                        rs.getString("size"),
                        rs.getString("equipment"),
                        rs.getFloat("price"),
                        rs.getString("state")
                ));
            }
        }
        return rooms;
    }

    public List<Room> getAllRoomsAvailable() throws SQLException {
        String sql = "SELECT roomId, name, equipment, size, price, state FROM rooms where state = 'Available'";
        List<Room> rooms = new ArrayList<>();
        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                rooms.add(new Room(
                        rs.getString("roomId"),
                        rs.getString("name"),
                        rs.getString("size"),
                        rs.getString("equipment"),
                        rs.getFloat("price"),
                        rs.getString("state")
                ));
            }
        }
        return rooms;
    }

    // Update Room
    public boolean updateRoom(Room room) throws SQLException {
        String sql = "UPDATE rooms SET name = ?, equipment = ?, size = ?, price = ?, state = ? WHERE roomId = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, room.getRoomName());
            ps.setString(2, room.getEquipment());
            ps.setString(3, room.getSize());
            ps.setFloat(4, room.getPrice());
            ps.setString(5, room.getState());
            ps.setString(6, room.getRoomId());  // Assuming 'id' is String, change it if needed.

            int rowsUpdated = ps.executeUpdate();
            return rowsUpdated > 0;  // Return true if at least one row is updated.
        }
    }

    // Delete Room
    public boolean deleteRoom(String roomId) throws SQLException {
        String sql = "DELETE FROM rooms WHERE roomId = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, roomId);

            int rowsUpdated = ps.executeUpdate();
            return rowsUpdated > 0;
        }
    }
}

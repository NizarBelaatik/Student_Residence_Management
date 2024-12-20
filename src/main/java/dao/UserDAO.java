package dao;

import model.User;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

    // Database connection details
    private static final String URL = "jdbc:mysql://localhost:3306/test";
    private static final String USER = "root";
    private static final String PASSWORD = "";

    // Method to get a connection to the database
    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            throw new SQLException("MySQL JDBC Driver not found.");
        }
    }

    // Add a User to the database
    public boolean addUser(User user) throws SQLException {
        String sql = "INSERT INTO users (email, password_hash, role, active, created_at, updated_at) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, user.getEmail());
            ps.setString(2, user.getPasswordHash());
            ps.setString(3, user.getRole());
            ps.setBoolean(4, user.isActive());
            ps.setTimestamp(5, user.getCreatedAt());
            ps.setTimestamp(6, user.getUpdatedAt());

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0; // Returns true if the insertion was successful
        }
    }

    // Get a User by ID
    public User getUserById(int userId) throws SQLException {
        String sql = "SELECT id, email, password_hash, role, active, created_at, updated_at FROM users WHERE id = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new User(
                        rs.getString("email"),
                        rs.getString("password_hash"),
                        rs.getString("role")
                    );
                }
            }
        }
        return null;
    }

    // Get User by Email
    public User getUserByEmail(String email) throws SQLException {
        String sql = "SELECT id, email, password_hash, role, active, created_at, updated_at FROM users WHERE email = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new User(
                        rs.getString("email"),
                        rs.getString("password_hash"),
                        rs.getString("role")
                    );
                }
            }
        }
        return null;
    }

    // Get all Users
    public List<User> getAllUsers() throws SQLException {
        String sql = "SELECT id, email, password_hash, role, active, created_at, updated_at FROM users";
        List<User> users = new ArrayList<>();
        try (Connection conn = getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                users.add(new User(
                    rs.getString("email"),
                    rs.getString("password_hash"),
                    rs.getString("role")
                ));
            }
        }
        return users;
    }

    // Update User information
    public boolean updateUser(User user) throws SQLException {
        String sql = "UPDATE users SET email = ?, password_hash = ?, role = ?, active = ?, updated_at = ? WHERE id = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, user.getEmail());
            ps.setString(2, user.getPasswordHash());
            ps.setString(3, user.getRole());
            ps.setBoolean(4, user.isActive());
            ps.setTimestamp(5, new Timestamp(System.currentTimeMillis())); // updated_at to current timestamp
            ps.setInt(6, user.getId());

            int rowsUpdated = ps.executeUpdate();
            return rowsUpdated > 0;
        }
    }

    // Delete User by ID
    public boolean deleteUser(int userId) throws SQLException {
        String sql = "DELETE FROM users WHERE id = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            int rowsDeleted = ps.executeUpdate();
            return rowsDeleted > 0;
        }
    }
}

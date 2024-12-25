package dao;

import model.User;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import org.mindrot.jbcrypt.BCrypt;

import utils.DatabaseConnection;


public class UserDAO {



    // Login user method
    public User loginUser(String email, String password) throws SQLException {
        String sql = "SELECT id, email, password_hash, role, active, created_at, updated_at FROM users WHERE email = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    // Get the stored password hash from the database
                    String storedHash = rs.getString("password_hash");

                    // Verify the provided password against the stored hash
                    if (BCrypt.checkpw(password, storedHash)) {
                        // Password matches, create a User object
                        User user = new User(
                                rs.getString("email"),
                                rs.getString("password_hash"),
                                rs.getString("role")
                        );
                        user.setId(rs.getInt("id"));
                        user.setActive(rs.getBoolean("active"));
                        user.setCreatedAt(rs.getTimestamp("created_at"));
                        user.setUpdatedAt(rs.getTimestamp("updated_at"));

                        return user; // Return the user object if login is successful
                    }
                }
            }
        }
        return null; // Return null if no matching user or incorrect password
    }

    // Add a User to the database
    public boolean addUser(User user) throws SQLException {
        String sql = "INSERT INTO users (email, password_hash, role, active, created_at, updated_at) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DatabaseConnection.getConnection();
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
        try (Connection conn = DatabaseConnection.getConnection();
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
        try (Connection conn = DatabaseConnection.getConnection();
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
        try (Connection conn = DatabaseConnection.getConnection();
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
        try (Connection conn = DatabaseConnection.getConnection();
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
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            int rowsDeleted = ps.executeUpdate();
            return rowsDeleted > 0;
        }
    }
}

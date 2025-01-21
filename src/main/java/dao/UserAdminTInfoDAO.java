package dao;

import model.UserAdminTInfo;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserAdminTInfoDAO {

    // Add UserAdminTInfo to the database
    public boolean addUserAdminTInfo(UserAdminTInfo userAdminTInfo) throws SQLException {
        String sql = "INSERT INTO user_admin_tech_info (email, firstname, lastname, phone) VALUES (?, ?, ?, ?)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, userAdminTInfo.getEmail());
            ps.setString(2, userAdminTInfo.getFirstname());
            ps.setString(3, userAdminTInfo.getLastname());
            ps.setString(4, userAdminTInfo.getPhone());

            return ps.executeUpdate() > 0; // Returns true if insertion was successful
        }
    }

    // Get UserAdminTInfo by email
    public UserAdminTInfo getUserAdminTInfoByEmail(String email) throws SQLException {
        String sql = "SELECT email, firstname, lastname, phone FROM user_admin_tech_info WHERE email = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new UserAdminTInfo(
                            rs.getString("email"),
                            rs.getString("firstname"),
                            rs.getString("lastname"),
                            rs.getString("phone")
                    );
                }
            }
        }
        return null;
    }

    // Get all UserAdminTInfo records
    public List<UserAdminTInfo> getAllUserAdminTInfos() throws SQLException {
        String sql = "SELECT email, firstname, lastname, phone FROM user_admin_tech_info";
        List<UserAdminTInfo> userAdminTInfos = new ArrayList<>();
        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                userAdminTInfos.add(new UserAdminTInfo(
                        rs.getString("email"),
                        rs.getString("firstname"),
                        rs.getString("lastname"),
                        rs.getString("phone")
                ));
            }
        }
        return userAdminTInfos;
    }

    // Update UserAdminTInfo by email
    public boolean updateUserAdminTInfo(UserAdminTInfo userAdminTInfo) throws SQLException {
        String sql = "UPDATE user_admin_tech_info SET firstname = ?, lastname = ?, phone = ? WHERE email = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, userAdminTInfo.getFirstname());
            ps.setString(2, userAdminTInfo.getLastname());
            ps.setString(3, userAdminTInfo.getPhone());
            ps.setString(4, userAdminTInfo.getEmail());

            return ps.executeUpdate() > 0; // Returns true if update was successful
        }
    }

    // Delete UserAdminTInfo by email
    public boolean deleteUserAdminTInfo(String email) throws SQLException {
        String sql = "DELETE FROM user_admin_tech_info WHERE email = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);
            return ps.executeUpdate() > 0; // Returns true if deletion was successful
        }
    }
}

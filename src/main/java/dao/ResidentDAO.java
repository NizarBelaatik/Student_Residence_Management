package dao;

import model.Resident;
import utils.GenerateRandomString;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import service.DatabaseConnection;

public class ResidentDAO {


    // Method to check if a residentId already exists
    private static boolean residentIdExists(String id) {
        String query = "SELECT COUNT(*) FROM residents WHERE residentId = ?";
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, id);
            ResultSet resultSet = preparedStatement.executeQuery();
            return resultSet.next() && resultSet.getInt(1) > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Add a Resident
    public boolean addResident(Resident resident) throws SQLException {
        String residentId = GenerateRandomString.generateUniqueId();

        // Ensure the generated residentId is unique
        while (residentIdExists(residentId)) {
            residentId = GenerateRandomString.generateUniqueId(); // Generate a new ID if it exists
        }

        String sql = "INSERT INTO residents (email, firstname, lastname, gender, phone, address, roomId,  c_start_date , c_end_date ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, resident.getEmail());
            ps.setString(2, resident.getFirstname());
            ps.setString(3, resident.getLastname());
            ps.setString(4, resident.getGender());
            ps.setString(5, resident.getPhone());
            ps.setString(6, resident.getAddress());
            ps.setString(7, resident.getRoomId());
            ps.setString(8, resident.getCStartDate());
            ps.setString(9, resident.getCEndDate());

            return ps.executeUpdate() > 0; // Returns true if insertion was successful
        }
    }

    // Get Resident by Email
    public Resident getResidentByEmail(String email) throws SQLException {
        String sql = "SELECT email, firstname, lastname, gender, phone, address, roomId,  c_start_date, c_end_date FROM residents WHERE email = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Resident(
                            rs.getString("email"),
                            rs.getString("firstname"),
                            rs.getString("lastname"),
                            rs.getString("gender"),
                            rs.getString("phone"),
                            rs.getString("address"),
                            rs.getString("roomId"),
                            rs.getString("c_start_date"),
                            rs.getString("c_end_date")
                    );
                }
            }
        }
        return null;
    }

    // Get all Residents
    public List<Resident> getAllResidents() throws SQLException {
        String sql = "SELECT email, firstname, lastname, gender, phone, address, roomId,  c_start_date,  c_end_date  FROM residents";
        List<Resident> residents = new ArrayList<>();
        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                residents.add(new Resident(
                        rs.getString("email"),
                        rs.getString("firstname"),
                        rs.getString("lastname"),
                        rs.getString("gender"),
                        rs.getString("phone"),
                        rs.getString("address"),
                        rs.getString("roomId"),
                        rs.getString("c_start_date"),
                        rs.getString("c_end_date")
                ));
            }
        }
        return residents;
    }

    public List<Resident> getAllResidentsForPaymentGeneration() throws SQLException {
        // SQL query to get residents with active contracts (based on current date)
        String sql = "SELECT email, firstname, lastname, gender, phone, address, roomId, c_start_date, c_end_date " +
                "FROM residents " +
                "WHERE c_end_date >= CURDATE()";  // Ensuring residents with active contracts are selected

        List<Resident> residents = new ArrayList<>();
        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                // Add each resident to the list
                residents.add(new Resident(
                        rs.getString("email"),
                        rs.getString("firstname"),
                        rs.getString("lastname"),
                        rs.getString("gender"),
                        rs.getString("phone"),
                        rs.getString("address"),
                        rs.getString("roomId"),
                        rs.getString("c_start_date"),
                        rs.getString("c_end_date")
                ));
            }
        }
        return residents;
    }

    // Update Resident
    public boolean updateResident(Resident resident) throws SQLException {
        String sql = "UPDATE residents SET email = ?, firstname = ?, lastname = ?, gender = ?, phone = ?, address = ?, roomId = ?, c_start_date = ?, c_end_date = ? WHERE email = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, resident.getEmail());
            ps.setString(2, resident.getFirstname());
            ps.setString(3, resident.getLastname());
            ps.setString(4, resident.getGender());
            ps.setString(5, resident.getPhone());
            ps.setString(6, resident.getAddress());
            ps.setString(7, resident.getRoomId());
            ps.setString(8, resident.getCStartDate());
            ps.setString(9, resident.getCEndDate());
            ps.setString(10, resident.getEmail());

            return ps.executeUpdate() > 0; // Returns true if update was successful
        }
    }
}

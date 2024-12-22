package dao;

import model.Resident;
import utils.utils;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

public class ResidentDAO {

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

    private static boolean residentIdExists(String Id) {
        String query = "SELECT COUNT(*) FROM residents WHERE residentId = ?";
        try (Connection connection = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, Id);
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
    public boolean addResident(Resident resident) throws SQLException {
        String residentId = utils.generateUniqueId();
        
        // Ensure the generated roomId is unique
        while (residentIdExists(residentId)) {
            residentId = utils.generateUniqueId(); // Generate a new ID if it exists
        }
        String sql = "INSERT INTO residents (residentId,userId, firstname,lastname, phone, address, roomId ) VALUES (?, ?, ?, ?,?,?)";
        try (Connection conn = getConnection();
                 PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, residentId);
                //ps.setString(2, resident.getUserId());
                ps.setString(3, resident.getFirstname());
                ps.setString(4, resident.getLastname());
                ps.setString(5, resident.getPhone());
                ps.setString(6, resident.getAddress());
                ps.setString(7, resident.getRoomId());

                int rowsAffected = ps.executeUpdate();
                return rowsAffected > 0; // Returns true if the insertion was successful
        }
    }
    
    
    public Resident getResidentById(String residentId) throws SQLException {
        String sql = "SELECT residentId,userId, firstname,lastname, phone, address, roomId FROM residents WHERE residentId = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, residentId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Resident(
                        rs.getString("residentId"),
                        rs.getString("userId"),
                        rs.getString("firstname"),
                        rs.getString("lastname"),
                        rs.getString("phone"),
                        rs.getString("address"),
                        rs.getString("roomId")
                    );
                }
            }
        }
        return null;
    }
    
    public List<Resident> getAllResidents() throws SQLException {
        String sql = "SELECT residentId,userId, firstname,lastname, phone, address, roomId FROM residents ";
        List<Resident> residentsL = new ArrayList<>();
        try (Connection conn = getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                residentsL.add(new Resident(
                    rs.getString("residentId"),
                    rs.getString("userId"),
                    rs.getString("firstname"),
                    rs.getString("lastname"),
                    rs.getString("phone"),
                    rs.getString("address"),
                    rs.getString("roomId")
                ));
            }
        }
        return residentsL;
    }
    
        public boolean updateResident(Resident resident) throws SQLException {
        String sql = "UPDATE residents SET userId=?, firstname=?,lastname=?, phone=?, address=?, roomId=? WHERE residentId = ?";
        try (Connection conn = getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)) {
            
            //ps.setString(1, resident.getUserId());
            ps.setString(2, resident.getFirstname());
            ps.setString(3, resident.getLastname());
            ps.setString(4, resident.getPhone());
            ps.setString(5, resident.getAddress());
            ps.setString(6, resident.getRoomId());
            //ps.setString(7, resident.getResidentId());
            
            int rowsUpdated = ps.executeUpdate();
            return rowsUpdated > 0;  // Return true if at least one row is updated.
        }
    }
    
}

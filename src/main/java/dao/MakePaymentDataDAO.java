package dao;

import model.MakePaymentData; // Import your MakePaymentData model
import service.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MakePaymentDataDAO {
    // Add MakePaymentData to the database
    public boolean addPaymentData(MakePaymentData paymentData) throws SQLException {
        String sql = "INSERT INTO payment_data (email, cardholder_name, card_number, expiry_date, cvc, payment_id) VALUES (?,?, ?, ?, ?, ?)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, paymentData.getEmail());
            ps.setString(2, paymentData.getCardholderName());
            ps.setString(3, paymentData.getCardNumber());
            ps.setString(4, paymentData.getExpiryDate());
            ps.setString(5, paymentData.getCvc());
            ps.setString(6, paymentData.getPaymentId());

            return ps.executeUpdate() > 0; // Returns true if insertion was successful
        }
    }

    // Get MakePaymentData by payment ID
    public MakePaymentData getPaymentDataById(String paymentId) throws SQLException {
        String sql = "SELECT email, cardholder_name, card_number, expiry_date, cvc FROM payment_data WHERE payment_id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, paymentId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new MakePaymentData(
                            rs.getString("email"),
                            rs.getString("cardholder_name"),
                            rs.getString("card_number"),
                            rs.getString("expiry_date"),
                            rs.getString("cvc"),
                            paymentId
                    );
                }
            }
        }
        return null;
    }

    // Get all MakePaymentData records
    public List<MakePaymentData> getAllPaymentData() throws SQLException {
        String sql = "SELECT email, cardholder_name, card_number, expiry_date, cvc, payment_id FROM payment_data";
        List<MakePaymentData> paymentDataList = new ArrayList<>();
        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                paymentDataList.add(new MakePaymentData(
                        rs.getString("email"),
                        rs.getString("cardholder_name"),
                        rs.getString("card_number"),
                        rs.getString("expiry_date"),
                        rs.getString("cvc"),
                        rs.getString("payment_id")
                ));
            }
        }
        return paymentDataList;
    }

    // Update MakePaymentData by payment ID
    public boolean updatePaymentData(MakePaymentData paymentData) throws SQLException {
        String sql = "UPDATE payment_data SET email = ?, cardholder_name = ?, card_number = ?, expiry_date = ?, cvc = ? WHERE payment_id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, paymentData.getEmail());
            ps.setString(2, paymentData.getCardholderName());
            ps.setString(3, paymentData.getCardNumber());
            ps.setString(4, paymentData.getExpiryDate());
            ps.setString(5, paymentData.getCvc());
            ps.setString(6, paymentData.getPaymentId());

            return ps.executeUpdate() > 0; // Returns true if update was successful
        }
    }

    // Delete MakePaymentData by payment ID
    public boolean deletePaymentData(String paymentId) throws SQLException {
        String sql = "DELETE FROM payment_data WHERE payment_id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, paymentId);
            return ps.executeUpdate() > 0; // Returns true if deletion was successful
        }
    }
}

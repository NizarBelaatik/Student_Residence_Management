package dao;

import model.Payment;
import utils.GenerateRandomString;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import service.DatabaseConnection;

public class PaymentDAO {



    private static boolean paymentIdExists(String Id) {
        String query = "SELECT COUNT(*) FROM payments WHERE paymentId = ?";
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, Id);
            ResultSet resultSet = stmt.executeQuery();
            if (resultSet.next()) {
                return resultSet.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public void createPayment(Payment payment) throws SQLException {
        String query = "INSERT INTO payments (paymentId,email,roomId, amount_due, due_date,amount_paid, status) VALUES (?,?, ?, ?,?, ?,?)";

        String Id = GenerateRandomString.generateUniqueId();
        while (paymentIdExists(Id)) {
            Id = GenerateRandomString.generateUniqueId(); // Generate a new ID if it exists
        }

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1,Id);
            stmt.setString(2, payment.getEmail());
            stmt.setString(3, payment.getRoomId());
            stmt.setFloat(4, payment.getAmountDue());
            stmt.setTimestamp(5, payment.getDueDate());
            stmt.setFloat(6, payment.getAmountPaid());
            stmt.setString(7, payment.getStatus());
            stmt.executeUpdate();
        }
    }


    public void updatePaymentStatus(String paymentId, String status) throws SQLException {
        String query = "UPDATE payments SET status = ? WHERE paymentId = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, status);
            stmt.setString(2, paymentId);
            stmt.executeUpdate();
        }
    }

    public List<Payment> getPaymentsByStatus(String status) throws SQLException {
        String query = "SELECT * FROM payments WHERE status = ? " +
                "ORDER BY CASE WHEN payment_date IS NULL THEN due_date ELSE payment_date END";
        List<Payment> payments = new ArrayList<>();
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, status);

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Payment payment = new Payment(
                        rs.getString("paymentId"),
                        rs.getString("email"),
                        rs.getString("roomId"),
                        rs.getFloat("amount_due"),
                        rs.getFloat("amount_paid"),
                        rs.getTimestamp("due_date"),
                        rs.getTimestamp("payment_date"),
                        rs.getString("status"));
                payments.add(payment);
            }
        }
        return payments;
    }

    public int getPaymentsByStatusSize(String status) {
        String query = "SELECT COUNT(*) FROM payments WHERE status = ?";
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, status);
            ResultSet resultSet = stmt.executeQuery();

            // Since COUNT(*) returns a single value, retrieve it directly
            if (resultSet.next()) {
                return resultSet.getInt(1);  // Get the count from the first column (which is the count)
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
}

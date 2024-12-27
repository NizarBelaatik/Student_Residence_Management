package dao;

import model.Payment;
import utils.GenerateRandomString;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import utils.DatabaseConnection;

public class PaymentDAO {



    private static boolean paymentIdExists(String Id) {
        String query = "SELECT COUNT(*) FROM payment WHERE paymentId = ?";
        try (Connection connection = DatabaseConnection.getConnection();
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

    public void createPayment(Payment payment) throws SQLException {
        String query = "INSERT INTO payments (paymentId,email, amount_due, due_date,amount_paid, status) VALUES (?, ?, ?, ?,?)";

        String Id = GenerateRandomString.generateUniqueId();
        while (paymentIdExists(Id)) {
            Id = GenerateRandomString.generateUniqueId(); // Generate a new ID if it exists
        }

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1,Id);
            stmt.setString(2, payment.getEmail());
            stmt.setFloat(3, payment.getAmountDue());
            stmt.setString(4, payment.getDueDate());
            stmt.setFloat(5, payment.getAmountPaid());
            stmt.setString(6, payment.getStatus());
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

    public List<Payment> getOverduePayments() throws SQLException {
        String query = "SELECT * FROM payments WHERE status = 'Overdue'";
        List<Payment> payments = new ArrayList<>();
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Payment payment = new Payment(
                        rs.getString("paymentId"),
                        rs.getString("email"),
                        rs.getFloat("amount_due"),
                        rs.getFloat("amount_paid"),
                        rs.getString("due_date"),
                        rs.getString("paymentDate"),
                        rs.getString("status"));
                payments.add(payment);
            }
        }
        return payments;
    }
}

package dao;

import model.Payment;
import service.PaymentManager;
import utils.GenerateRandomString;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.HashMap;

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


    public Payment getPaymentByID(String paymentId) throws SQLException {
        String query = "SELECT paymentId, fullname, email, roomId, amount_due, amount_paid, due_date, payment_date, status FROM payments WHERE paymentId = ?";
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {

            // Set the payment ID parameter
            stmt.setString(1, paymentId);

            // Execute the query
            ResultSet rs = stmt.executeQuery();

            // Check if a result was returned
            if (rs.next()) {
                // Return a new Payment object populated with the retrieved data
                return new Payment(
                        rs.getString("paymentId"),
                        rs.getString("fullname"),
                        rs.getString("email"),
                        rs.getString("roomId"),
                        rs.getFloat("amount_due"),
                        rs.getFloat("amount_paid"),
                        rs.getTimestamp("due_date"),
                        rs.getTimestamp("payment_date"),
                        rs.getString("status")
                );
            } else {
                // Return null or throw an exception if no record is found
                return null;
            }

        }
    }
    public void createPayment(Payment payment) throws SQLException {
        String query = "INSERT INTO payments (paymentId,fullname,email,roomId, amount_due, due_date,amount_paid, status) VALUES (?,?, ?, ?,?, ?,?,?)";

        String Id = GenerateRandomString.generateUniqueId();
        while (paymentIdExists(Id)) {
            Id = GenerateRandomString.generateUniqueId(); // Generate a new ID if it exists
        }

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1,Id);
            stmt.setString(2, payment.getFullname());
            stmt.setString(3, payment.getEmail());
            stmt.setString(4, payment.getRoomId());
            stmt.setFloat(5, payment.getAmountDue());
            stmt.setTimestamp(6, payment.getDueDate());
            stmt.setFloat(7, payment.getAmountPaid());
            stmt.setString(8, payment.getStatus());
            stmt.executeUpdate();
        }
    }


    public void PaymentPaid(Payment payment) throws SQLException {
        String query = "UPDATE payments SET status = 'paid', amount_paid = ?, payment_date = ? WHERE paymentId = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            // Set the actual amount paid (not the amount due)
            stmt.setFloat(1, payment.getAmountPaid());

            // Set the current time as the payment date
            stmt.setTimestamp(2, new Timestamp(System.currentTimeMillis()));

            // Set the payment ID for the record to update
            stmt.setString(3, payment.getPaymentId());

            int rowsAffected = stmt.executeUpdate();

            // Check if the update was successful
            if (rowsAffected == 0) {
                throw new SQLException("No rows updated. The payment ID might not exist.");
            }
        }
    }

    public void updatePaymentStatus(String paymentId, String status) throws SQLException {
        if (paymentId == null || paymentId.isEmpty() || status == null || status.isEmpty()) {
            throw new IllegalArgumentException("Payment ID and status cannot be null or empty.");
        }

        String query = "UPDATE payments SET status = ? WHERE paymentId = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, status);
            stmt.setString(2, paymentId);

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected == 0) {
                throw new SQLException("No rows updated. The payment ID might not exist.");
            }
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
                        rs.getString("fullname"),
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

    public float getTotalPaymentsThisMonthByStatus(String status) {
        String query = "SELECT SUM(amount_paid) FROM payments WHERE status = ? AND MONTH(payment_date) = MONTH(CURRENT_DATE) AND YEAR(payment_date) = YEAR(CURRENT_DATE)";
        float totalAmount = 0.0f;

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {

            // Check if status is null or empty, handle accordingly
            if (status == null || status.trim().isEmpty()) {
                throw new IllegalArgumentException("The status cannot be null or empty");
            }

            // Set the status parameter in the prepared statement
            stmt.setString(1, status);

            // Execute the query and get the result
            try (ResultSet resultSet = stmt.executeQuery()) {
                if (resultSet.next()) {
                    // Retrieve the total payment amount from the first column of the result set
                    totalAmount = resultSet.getFloat(1);
                }
            }

        } catch (SQLException e) {
            System.err.println("SQL error while fetching total payments for this month: " + e.getMessage());
            e.printStackTrace(); // Print stack trace for detailed debugging
        } catch (IllegalArgumentException e) {
            System.err.println("Error: " + e.getMessage());
        }

        // Return the total amount or 0.0 if no payments were found
        return totalAmount;
    }

    public float getTotalPendingPayments() {
        String query = "SELECT SUM(amount_due) FROM payments WHERE status = 'pending' ";
        float totalAmount = 0.0f;

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {

            // Execute the query and get the result
            try (ResultSet resultSet = stmt.executeQuery()) {
                if (resultSet.next()) {
                    // Retrieve the total payment amount from the first column of the result set
                    totalAmount = resultSet.getFloat(1);
                }
            }

        } catch (SQLException e) {
            System.err.println("SQL error while fetching total pending payments: " + e.getMessage());
            e.printStackTrace(); // Print stack trace for detailed debugging
        }
        return totalAmount;
    }

    // Method to get the total of overdue payments
    public float getTotalOverduePayments() {
        String query = "SELECT SUM(amount_due) FROM payments WHERE status = 'overdue' AND due_date < CURRENT_DATE";
        float totalAmount = 0.0f;

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {

            // Execute the query and get the result
            try (ResultSet resultSet = stmt.executeQuery()) {
                if (resultSet.next()) {
                    // Retrieve the total payment amount from the first column of the result set
                    totalAmount = resultSet.getFloat(1);
                }
            }

        } catch (SQLException e) {
            System.err.println("SQL error while fetching total overdue payments: " + e.getMessage());
            e.printStackTrace(); // Print stack trace for detailed debugging
        }
        return totalAmount;
    }

    public float getTotalPaymentsByStatus(String status) {
        String query = "";
        if ("pending".equalsIgnoreCase(status)) {
            query = "SELECT SUM(amount_due) FROM payments WHERE status = 'pending' AND MONTH(due_date) = MONTH(CURRENT_DATE) AND YEAR(due_date) = YEAR(CURRENT_DATE)";
        } else if ("overdue".equalsIgnoreCase(status)) {
            query = "SELECT SUM(amount_due) FROM payments WHERE status = 'overdue' AND due_date < CURRENT_DATE";
        } else if ("paid".equalsIgnoreCase(status)) {
            query = "SELECT SUM(amount_paid) FROM payments WHERE status = 'paid' AND MONTH(payment_date) = MONTH(CURRENT_DATE) AND YEAR(payment_date) = YEAR(CURRENT_DATE)";
        }

        float totalAmount = 0.0f;
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {

            ResultSet resultSet = stmt.executeQuery();
            if (resultSet.next()) {
                totalAmount = resultSet.getFloat(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return totalAmount;
    }

    public Map<String, Map<String, Integer>> getPaymentGraphData() throws SQLException {
        Map<String, Map<String, Integer>> statusData = new HashMap<>();
        String query = "SELECT status, DATE(payment_date) AS date, COUNT(*) AS count " +
                "FROM payments " +
                "WHERE payment_date >= CURDATE() - INTERVAL 30 DAY " +
                "GROUP BY status, DATE(payment_date) " +
                "ORDER BY DATE(payment_date)";

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                String status = rs.getString("status");
                String date = rs.getString("date");
                int count = rs.getInt("count");

                // Initialize the map for each status if not already present
                if (!statusData.containsKey(status)) {
                    statusData.put(status, new HashMap<>());
                }

                // Add the count for the respective date
                statusData.get(status).put(date, count);
            }
        } catch (SQLException e) {
            // Log the exception and rethrow if necessary
            System.err.println("Error while fetching payment data: " + e.getMessage());
            throw e;  // Rethrow the SQLException
        }
        return statusData;
    }




}

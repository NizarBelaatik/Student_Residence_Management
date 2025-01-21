package service;

import java.util.concurrent.*;
import java.time.*;
import java.time.temporal.ChronoUnit;
import java.sql.*;

import dao.DatabaseConnection;
import dao.PaymentDAO;

public class ScheduledPaymentManager {
    private ScheduledExecutorService scheduler = Executors.newScheduledThreadPool(1);

    public void schedulePaymentGeneration() {
        LocalDate today = LocalDate.now();
        LocalDate firstDayOfNextMonth = today.plusMonths(1).withDayOfMonth(1);

        long delay = ChronoUnit.DAYS.between(today, firstDayOfNextMonth);

        // Schedule to run on the 1st day of the next month
        scheduler.schedule(() -> generatePayments(), delay, TimeUnit.DAYS);
    }

    private void generatePayments() {
        try {
            // Check if payments have already been generated for this month
            if (!isPaymentsGeneratedForCurrentMonth()) {
                // Generate payments
                PaymentDAO paymentDAO = new PaymentDAO();
                //paymentDAO.createMonthlyPayments();

                // Mark as generated in the database
                markPaymentsAsGeneratedForCurrentMonth();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Check if payments were generated for the current month
    private boolean isPaymentsGeneratedForCurrentMonth() throws SQLException {
        LocalDate today = LocalDate.now();
        int currentYear = today.getYear();
        int currentMonth = today.getMonthValue();

        String query = "SELECT generated FROM payment_generation_status WHERE year = ? AND month = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, currentYear);
            stmt.setInt(2, currentMonth);

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getBoolean("generated");
            }
            return false;  // If no record exists, return false (i.e., payments not generated)
        }
    }

    // Mark payments as generated for the current month
    private void markPaymentsAsGeneratedForCurrentMonth() throws SQLException {
        LocalDate today = LocalDate.now();
        int currentYear = today.getYear();
        int currentMonth = today.getMonthValue();

        String query = "INSERT INTO payment_generation_status (year, month, generated) VALUES (?, ?, ?) " +
                "ON DUPLICATE KEY UPDATE generated = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, currentYear);
            stmt.setInt(2, currentMonth);
            stmt.setBoolean(3, true);  // Mark as generated
            stmt.setBoolean(4, true);  // Update in case the record already exists
            stmt.executeUpdate();
        }
    }
}

package dao;

import model.EmailVerification;
import service.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class EmailVerificationDAO {

    // Database connection details
    private static final String URL = "jdbc:mysql://localhost:3306/test";
    private static final String USER = "root";
    private static final String PASSWORD = "";


    // Add Email Verification
    public boolean addEmailVerification(EmailVerification emailVerification) throws SQLException {
        String sql = "INSERT INTO email_verification (email, verification_token, created_at, expires_at) VALUES (?, ?, ?, ?)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, emailVerification.getEmail());
            ps.setString(2, emailVerification.getVerificationToken());
            ps.setTimestamp(3, emailVerification.getCreatedAt());
            ps.setTimestamp(4, emailVerification.getExpiresAt());

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0; // Returns true if the insertion was successful
        }
    }

    // Get Email Verification by Token
    public EmailVerification getEmailVerificationByToken(String token) throws SQLException {
        String sql = "SELECT verification_id, email, verification_token, created_at, expires_at, verified_at FROM email_verification WHERE verification_token = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, token);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new EmailVerification(
                        rs.getString("email"),
                        rs.getString("verification_token"),
                        rs.getTimestamp("expires_at")
                    );
                }
            }
        }
        return null;
    }

    // Get all Email Verifications (for admin or audit purposes)
    public List<EmailVerification> getAllEmailVerifications() throws SQLException {
        String sql = "SELECT verification_id, email, verification_token, created_at, expires_at, verified_at FROM email_verification";
        List<EmailVerification> verifications = new ArrayList<>();
        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                verifications.add(new EmailVerification(
                        rs.getString("email"),
                        rs.getString("verification_token"),
                        rs.getTimestamp("expires_at")
                ));
            }
        }
        return verifications;
    }

    // Update Email Verification as Verified
    public boolean verifyEmail(String email, String token) throws SQLException {
        String sql = "UPDATE email_verification SET verified_at = CURRENT_TIMESTAMP WHERE email = ? AND verification_token = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);
            ps.setString(2, token);
            int rowsUpdated = ps.executeUpdate();
            return rowsUpdated > 0;
        }
    }

    // Delete Email Verification (e.g., after it expires or is no longer needed)
    public boolean deleteEmailVerification(String token) throws SQLException {
        String sql = "DELETE FROM email_verification WHERE verification_token = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, token);
            int rowsUpdated = ps.executeUpdate();
            return rowsUpdated > 0;
        }
    }
}

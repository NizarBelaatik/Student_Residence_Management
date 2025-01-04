package dao;

import model.Notification;
import service.DatabaseConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class NotificationDAO {

    // Method to save a new notification
    public void add(Notification notification) {
        String query = "INSERT INTO notifications (sender, receiver, subject, msg,type ) " +
                "VALUES ( ?, ?, ?, ?,?)";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, notification.getSender());
            stmt.setString(2, notification.getReceiver());
            stmt.setString(3, notification.getSubject());
            stmt.setString(4, notification.getMsg());
            stmt.setString(5, notification.getType());

            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }



    public List<Notification> getNotifByEmail(String email) {
        List<Notification> notifications = new ArrayList<>();
        String query = "SELECT * FROM notifications WHERE receiver = ? ORDER BY sendDate DESC";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement statement = conn.prepareStatement(query)) {

            // Set the email parameter in the query
            statement.setString(1, email);

            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    // Assuming you have a method to map the result set to a Notification object
                    notifications.add(mapResultSetToNotification(resultSet));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return notifications;
    }


    public boolean updateNotificationStatus(String email) {
        // Example update logic (adjust according to your actual DB logic)
        try (Connection conn = DatabaseConnection.getConnection()) {
            String query = "UPDATE notifications SET status = true WHERE receiver = ?";
            try (PreparedStatement stmt = conn.prepareStatement(query)) {
                stmt.setString(1, email);
                int rowsAffected = stmt.executeUpdate();
                return rowsAffected > 0;  // Return true if the update was successful
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;  // Return false in case of error
        }
    }


    // Helper method to map a ResultSet to a Notification object
    private Notification mapResultSetToNotification(ResultSet resultSet) throws SQLException {
        int id = resultSet.getInt("id");
        String sender = resultSet.getString("sender");
        String receiver = resultSet.getString("receiver");
        String subject = resultSet.getString("subject");
        String msg = resultSet.getString("msg");
        boolean status = resultSet.getBoolean("status");
        String type = resultSet.getString("type");
        Timestamp sendDate = resultSet.getTimestamp("sendDate");
        Timestamp checkedDate = resultSet.getTimestamp("checkedDate");

        return new Notification(id, sender, receiver, subject, msg, status,type, sendDate, checkedDate);
    }
}

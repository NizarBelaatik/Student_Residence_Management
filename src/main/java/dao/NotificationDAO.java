package dao;

import model.Notification;
import service.DatabaseConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class NotificationDAO {

    // Method to save a new notification
    public void add(Notification notification) {
        String query = "INSERT INTO notification (sender, receiver, subject, msg ) " +
                "VALUES ( ?, ?, ?, ?)";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, notification.getSender());
            stmt.setString(2, notification.getReceiver());
            stmt.setString(3, notification.getSubject());
            stmt.setString(4, notification.getMsg());

            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Method to find a notification by its ID
    public Notification findById(int id) {
        String query = "SELECT * FROM notification WHERE id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement preparedStatement = conn.prepareStatement(query)) {

            preparedStatement.setInt(1, id);
            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                return mapResultSetToNotification(resultSet);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Method to get all notifications
    public List<Notification> findAll() {
        List<Notification> notifications = new ArrayList<>();
        String query = "SELECT * FROM notification";

        try (Connection conn = DatabaseConnection.getConnection();
             Statement statement = conn.createStatement();
             ResultSet resultSet = statement.executeQuery(query)) {

            while (resultSet.next()) {
                notifications.add(mapResultSetToNotification(resultSet));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return notifications;
    }

    // Method to update an existing notification
    public void update(Notification notification) {
        String query = "UPDATE notification SET sender = ?, receiver = ?, subject = ?, msg = ?, status = ?, " +
                "sendDate = ?, checkedDate = ? WHERE id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, notification.getSender());
            stmt.setString(2, notification.getReceiver());
            stmt.setString(3, notification.getSubject());
            stmt.setString(4, notification.getMsg());
            stmt.setBoolean(5, notification.isStatus());
            stmt.setTimestamp(6, notification.getSendDate());
            stmt.setTimestamp(7, notification.getCheckedDate());
            stmt.setInt(8, notification.getId());

            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Method to delete a notification by its ID
    public void delete(int id) {
        String query = "DELETE FROM notification WHERE id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, id);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
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
        Timestamp sendDate = resultSet.getTimestamp("sendDate");
        Timestamp checkedDate = resultSet.getTimestamp("checkedDate");

        return new Notification(id, sender, receiver, subject, msg, status, sendDate, checkedDate);
    }
}

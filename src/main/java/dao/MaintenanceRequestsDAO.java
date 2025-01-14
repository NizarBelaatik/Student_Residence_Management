package dao;

import model.MaintenanceRequests;
import service.DatabaseConnection;

import java.sql.*;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.*;

public class MaintenanceRequestsDAO {

    // Add a new MaintenanceRequest
    public boolean addMaintenanceRequest(MaintenanceRequests maintenanceRequest) throws SQLException {
        String sql = "INSERT INTO maintenance_requests (resident_email, roomId, issue_type, issue_description, status) " +
                "VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, maintenanceRequest.getResidentEmail());
            ps.setString(2, maintenanceRequest.getRoomId());
            ps.setString(3, maintenanceRequest.getIssueType());
            ps.setString(4, maintenanceRequest.getIssueDescription());
            ps.setString(5, maintenanceRequest.getStatus());

            return ps.executeUpdate() > 0; // Returns true if insertion was successful
        }
    }

    // Get a MaintenanceRequest by ID
    public MaintenanceRequests getMaintenanceRequestById(int id) throws SQLException {
        String sql = "SELECT * FROM maintenance_requests WHERE id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToMaintenanceRequest(rs);
                }
            }
        }
        return null;
    }

    // Get all MaintenanceRequests
    public List<MaintenanceRequests> getAllMaintenanceRequests() throws SQLException {
        String sql = "SELECT * FROM maintenance_requests";
        List<MaintenanceRequests> maintenanceRequests = new ArrayList<>();
        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                maintenanceRequests.add(mapResultSetToMaintenanceRequest(rs));
            }
        }
        return maintenanceRequests;
    }

    // Update the status of a MaintenanceRequest by ID
    public boolean updateMaintenanceRequestStatus(int id, String status, String technicianName) throws SQLException {
        String sql = "UPDATE maintenance_requests SET status = ?, technician_name = ?, resolved_date = ? WHERE id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, status);
            ps.setString(2, technicianName);
            if ("resolved".equals(status)) {
                ps.setDate(3, Date.valueOf(java.time.LocalDate.now()));
            } else {
                ps.setNull(3, Types.DATE);
            }
            ps.setInt(4, id);

            return ps.executeUpdate() > 0;
        }
    }

    // Delete a MaintenanceRequest by ID
    public boolean deleteMaintenanceRequest(int id) throws SQLException {
        String sql = "DELETE FROM maintenance_requests WHERE id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0; // Returns true if deletion was successful
        }
    }

    // Helper method to map ResultSet to MaintenanceRequests
    private MaintenanceRequests mapResultSetToMaintenanceRequest(ResultSet rs) throws SQLException {
        MaintenanceRequests request = new MaintenanceRequests(
                rs.getString("resident_email"),
                rs.getString("roomId"),
                rs.getString("issue_type"),
                rs.getString("issue_description")
        );
        request.setId(rs.getInt("id"));
        request.setStatus(rs.getString("status"));
        request.setTechnicianName(rs.getString("technician_name"));
        request.setResolvedDate(rs.getDate("resolved_date") != null ? rs.getDate("resolved_date").toLocalDate() : null);
        request.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
        request.setUpdatedAt(rs.getTimestamp("updated_at").toLocalDateTime());
        return request;
    }

    public Map<String, Map<String, Integer>> getRequestsGroupedByDayAndStatus() throws SQLException {
        Map<String, Map<String, Integer>> result = new LinkedHashMap<>();

        // SQL query to get data for the last 30 days (with counts)
        String sql = "SELECT DATE(created_at) AS request_date, status, COUNT(*) AS request_count " +
                "FROM maintenance_requests " +
                "WHERE created_at >= CURDATE() - INTERVAL 30 DAY " +
                "GROUP BY request_date, status " +
                "ORDER BY request_date DESC";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            // Fetch data from the database
            while (rs.next()) {
                String requestDate = rs.getString("request_date");
                String status = rs.getString("status");
                int count = rs.getInt("request_count");

                // Initialize the map if it's not already present
                result.putIfAbsent(requestDate, new HashMap<>());
                result.get(requestDate).put(status, count);
            }
        }

        // Ensure that we have data for the last 30 days (even if no requests exist)
        Calendar calendar = Calendar.getInstance();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        for (int i = 0; i < 30; i++) {
            calendar.add(Calendar.DAY_OF_MONTH, -1); // Go back one day at a time
            String date = sdf.format(calendar.getTime());

            // If no data for this date, initialize with an empty map (status -> count)
            if (!result.containsKey(date)) {
                result.put(date, new HashMap<>());
            }
        }

        return result;
    }

}

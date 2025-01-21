package dao;

import model.MaintenanceRequests;
import utils.GenerateRandomString;

import java.sql.*;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.*;

public class MaintenanceRequestsDAO {

    private static boolean maintenanceIdExists(String Id) {
        String query = "SELECT COUNT(*) FROM maintenance_requests WHERE id = ?";
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

    // Add a new MaintenanceRequest
    public boolean addMaintenanceRequest(MaintenanceRequests maintenanceRequest) throws SQLException {
        String sql = "INSERT INTO maintenance_requests (id,resident_email, roomId, issue_type, issue_description, status) " +
                "VALUES (?,?, ?, ?, ?, ?)";
        String Id = GenerateRandomString.generateUniqueId();
        while (maintenanceIdExists(Id)) {
            Id = GenerateRandomString.generateUniqueId(); // Generate a new ID if it exists
        }
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, Id);
            ps.setString(2, maintenanceRequest.getResidentEmail());
            ps.setString(3, maintenanceRequest.getRoomId());
            ps.setString(4, maintenanceRequest.getIssueType());
            ps.setString(5, maintenanceRequest.getIssueDescription());
            ps.setString(6, maintenanceRequest.getStatus());

            return ps.executeUpdate() > 0; // Returns true if insertion was successful
        }
    }

    // Get a MaintenanceRequest by ID
    public MaintenanceRequests getMaintenanceRequestById(String id) throws SQLException {
        String sql = "SELECT * FROM maintenance_requests WHERE id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToMaintenanceRequest(rs);
                }
            }
        }
        return null;
    }

    public String getMaintenanceRequestGetRoomId(String id) throws SQLException {
        String sql = "SELECT roomId FROM maintenance_requests WHERE id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getString(1);
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


    public List<MaintenanceRequests> getAllMaintenanceRequestsByRT(String email , String by) throws SQLException {
        String sql;
        if("tech".equals(by)){
            sql = "SELECT * FROM maintenance_requests WHERE technician_name = ?";
        }else{
            sql = "SELECT * FROM maintenance_requests WHERE resident_email = ?";
        }

        List<MaintenanceRequests> maintenanceRequests = new ArrayList<>();
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            // Set the resident_email parameter
            stmt.setString(1, email);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    maintenanceRequests.add(mapResultSetToMaintenanceRequest(rs));
                }
            }
        }
        return maintenanceRequests;
    }

    public List<MaintenanceRequests> getRecentMaintenanceRequests(int N) throws SQLException {
        // SQL query to fetch all records if N <= 1, else fetch N most recent
        String sql;
        if (N <= 1) {
            sql = "SELECT * FROM maintenance_requests " +
                    "ORDER BY GREATEST(COALESCE(resolved_date, '1900-01-01'), COALESCE(created_at, '1900-01-01'), COALESCE(updated_at, '1900-01-01')) DESC";
        } else {
            sql = "SELECT * FROM maintenance_requests " +
                    "ORDER BY GREATEST(COALESCE(resolved_date, '1900-01-01'), COALESCE(created_at, '1900-01-01'), COALESCE(updated_at, '1900-01-01')) DESC LIMIT ?";
        }

        List<MaintenanceRequests> maintenanceRequests = new ArrayList<>();

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            // If N > 1, set the limit for the query
            if (N > 1) {
                stmt.setInt(1, N);
            }

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    maintenanceRequests.add(mapResultSetToMaintenanceRequest(rs));
                }
            }
        } catch (SQLException e) {
            System.err.println("Error while fetching recent maintenance requests: " + e.getMessage());
            e.printStackTrace(); // Print stack trace for debugging
        }

        return maintenanceRequests;
    }


    public List<MaintenanceRequests> getAllMaintenanceRequestsByStatus(String status)
            throws SQLException {
        String sql = "SELECT * FROM maintenance_requests WHERE status = ?";
        List<MaintenanceRequests> maintenanceRequests = new ArrayList<>();

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, status); // Set the status parameter

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    maintenanceRequests.add(mapResultSetToMaintenanceRequest(rs));
                }
            }
        }

        return maintenanceRequests;
    }

    public List<MaintenanceRequests> getAllMaintenanceRequestsByStatusT(String status,String techEmail)
            throws SQLException {
        String sql = "SELECT * FROM maintenance_requests WHERE status = ? and technician_name = ?";
        List<MaintenanceRequests> maintenanceRequests = new ArrayList<>();

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, status); // Set the status parameter
            ps.setString(2, techEmail);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    maintenanceRequests.add(mapResultSetToMaintenanceRequest(rs));
                }
            }
        }

        return maintenanceRequests;
    }


    // Update the status of a MaintenanceRequest by ID
    public boolean updateMaintenanceRequestStatus(String id, String status, String technicianName) throws SQLException {
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
            ps.setString(4, id);

            return ps.executeUpdate() > 0;
        }
    }

    public boolean updateMaintenanceRequestStatusT(String id, String status ) throws SQLException {
        String sql = "UPDATE maintenance_requests SET status = ?,  resolved_date = ? WHERE id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            if ("resolved".equals(status)) {
                ps.setDate(2, Date.valueOf(java.time.LocalDate.now()));
            } else {
                ps.setNull(2, Types.DATE);
            }
            ps.setString(3, id);
            return ps.executeUpdate() > 0;
        }
    }

    // Delete a MaintenanceRequest by ID
    public boolean deleteMaintenanceRequest(String id) throws SQLException {
        String sql = "DELETE FROM maintenance_requests WHERE id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, id);
            return ps.executeUpdate() > 0; // Returns true if deletion was successful
        }
    }

    // Helper method to map ResultSet to MaintenanceRequests
    private MaintenanceRequests mapResultSetToMaintenanceRequest(ResultSet rs) throws SQLException {
        MaintenanceRequests request = new MaintenanceRequests(
                rs.getString("resident_email"),
                rs.getString("roomId"),
                rs.getString("issue_type"),
                rs.getString("issue_description"),
                rs.getString("status")
        );
        request.setId(rs.getString("id"));
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
    public Map<String, Map<String, Integer>> getMaintenanceRequestsGraphData() throws SQLException {
        Map<String, Map<String, Integer>> statusData = new HashMap<>();
        String query = "SELECT status, DATE(created_at) AS date, COUNT(*) AS count " +
                "FROM maintenance_requests " +
                "WHERE created_at >= CURDATE() - INTERVAL 30 DAY " +
                "GROUP BY status, DATE(created_at) " +
                "ORDER BY DATE(created_at)";

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
            System.err.println("Error while fetching maintenance request data: " + e.getMessage());
            throw e;  // Rethrow the SQLException
        }
        return statusData;
    }



}

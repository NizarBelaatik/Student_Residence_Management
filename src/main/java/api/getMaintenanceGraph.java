package api;

import com.google.gson.Gson;
import dao.MaintenanceRequestsDAO;
import jakarta.json.Json;
import jakarta.json.JsonArrayBuilder;
import jakarta.json.JsonObject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.ws.rs.core.Response;

import java.io.IOException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.Map;

import java.util.*;



@WebServlet(urlPatterns = {"/admin-api/getMaintenanceRequestsGraph"})
public class getMaintenanceGraph extends HttpServlet {
    private MaintenanceRequestsDAO maintenanceRequestsDAO = new MaintenanceRequestsDAO();

    private static final long serialVersionUID = 1L;
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            Map<String, Map<String, Integer>> statusData = maintenanceRequestsDAO.getMaintenanceRequestsGraphData();
            String jsonResponse = prepareChartData(statusData);

            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(jsonResponse);
        } catch (SQLException e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\": \"Database error: " + e.getMessage() + "\"}");
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\": \"An unexpected error occurred: " + e.getMessage() + "\"}");
        }
    }

    private String prepareChartData(Map<String, Map<String, Integer>> statusData) {
        StringBuilder dates = new StringBuilder();
        StringBuilder pendingData = new StringBuilder();
        StringBuilder resolvedData = new StringBuilder();
        StringBuilder inProgressData = new StringBuilder();

        // Get the current date
        LocalDate today = LocalDate.now();

        // Generate the last 30 days
        List<String> allDates = new ArrayList<>();
        for (int i = 0; i < 30; i++) {
            LocalDate date = today.minusDays(i);
            allDates.add(date.toString()); // Convert to string format (yyyy-MM-dd)
        }

        // Build the chart data for each date
        for (String date : allDates) {
            dates.append("\"").append(date).append("\","); // Add dates

            // Ensure that for each date, if no data exists, we append 0
            pendingData.append(statusData.getOrDefault("pending", Collections.emptyMap()).getOrDefault(date, 0)).append(",");
            resolvedData.append(statusData.getOrDefault("resolved", Collections.emptyMap()).getOrDefault(date, 0)).append(",");
            inProgressData.append(statusData.getOrDefault("in_progress", Collections.emptyMap()).getOrDefault(date, 0)).append(",");
        }

        // Remove the last comma to fix the array syntax
        if (dates.length() > 0) dates.setLength(dates.length() - 1);
        if (pendingData.length() > 0) pendingData.setLength(pendingData.length() - 1);
        if (resolvedData.length() > 0) resolvedData.setLength(resolvedData.length() - 1);
        if (inProgressData.length() > 0) inProgressData.setLength(inProgressData.length() - 1);

        // Prepare JSON response with the corrected data
        return String.format("{\"dates\": [%s], \"pending\": [%s], \"resolved\": [%s], \"in_progress\": [%s]}",
                dates.toString(), pendingData.toString(), resolvedData.toString(), inProgressData.toString());
    }
}
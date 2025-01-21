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
import jakarta.servlet.http.HttpSession;
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
        HttpSession session = request.getSession(false);
        String csrfTokenFromSession = (String) session.getAttribute("csrfToken");
        String csrfTokenFromRequest = request.getHeader("X-CSRF-Token");

        // CSRF token validation
        if (csrfTokenFromRequest == null || !csrfTokenFromRequest.equals(csrfTokenFromSession)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "CSRF token validation failed");
            return;
        }

        try {
            // Fetch the data from DAO
            Map<String, Map<String, Integer>> statusData = maintenanceRequestsDAO.getMaintenanceRequestsGraphData();

            // Prepare chart data
            Map<String, Object> chartData = prepareChartData(statusData);

            // Convert the data to JSON using Gson
            Gson gson = new Gson();
            String jsonResponse = gson.toJson(chartData);

            // Send the JSON response back to the frontend
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(jsonResponse);

        } catch (SQLException e) {
            // Handle database errors
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\": \"Database error: " + e.getMessage() + "\"}");
        } catch (Exception e) {
            // Handle unexpected errors
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\": \"An unexpected error occurred: " + e.getMessage() + "\"}");
        }
    }

    private Map<String, Object> prepareChartData(Map<String, Map<String, Integer>> statusData) {
        // Prepare the data to send back in the JSON response
        Map<String, Object> chartData = new HashMap<>();

        LocalDate today = LocalDate.now();

        // Generate the last 30 days
        List<String> dates = new ArrayList<>();
        List<Integer> pendingData = new ArrayList<>();
        List<Integer> resolvedData = new ArrayList<>();
        List<Integer> inProgressData = new ArrayList<>();

        Set<String> allDates = new LinkedHashSet<>();
        for (int i = 0; i < 30; i++) {
            LocalDate date = today.minusDays(i);
            allDates.add(date.toString()); // Format as yyyy-MM-dd
        }

        // Populate the data for each date
        for (String date : allDates) {
            dates.add(date);
            pendingData.add(statusData.getOrDefault("pending", Collections.emptyMap()).getOrDefault(date, 0));
            resolvedData.add(statusData.getOrDefault("resolved", Collections.emptyMap()).getOrDefault(date, 0));
            inProgressData.add(statusData.getOrDefault("in_progress", Collections.emptyMap()).getOrDefault(date, 0));
        }

        // Add the data to the chartData map
        chartData.put("dates", dates);
        chartData.put("pending", pendingData);
        chartData.put("resolved", resolvedData);
        chartData.put("in_progress", inProgressData);

        return chartData;
    }
}
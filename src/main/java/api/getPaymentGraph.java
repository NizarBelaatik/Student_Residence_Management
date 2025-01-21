package api;

import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDate;
import java.util.*;
import java.sql.SQLException; // <-- This line is missing

import dao.PaymentDAO;
import jakarta.servlet.http.HttpSession;


@WebServlet(name = "getPaymentGraph", urlPatterns = {"/admin-api/getPaymentGraph"})
public class getPaymentGraph extends HttpServlet {
    private PaymentDAO paymentDAO = new PaymentDAO();

    public getPaymentGraph() {
        super();
    }

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
            // Fetch payment data from the DAO
            Map<String, Map<String, Integer>> statusData = paymentDAO.getPaymentGraphData();

            // Prepare data for JSON response
            Map<String, Object> chartData = prepareChartData(statusData);

            // Convert data to JSON using Gson
            Gson gson = new Gson();
            String jsonResponse = gson.toJson(chartData);

            // Set content type and write response
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(jsonResponse);

        } catch (SQLException e) {
            // Database error handling
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\": \"Database error: " + e.getMessage() + "\"}");
        } catch (Exception e) {
            // General error handling
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\": \"An unexpected error occurred: " + e.getMessage() + "\"}");
        }
    }

    private Map<String, Object> prepareChartData(Map<String, Map<String, Integer>> statusData) {
        // Create a map to hold the chart data
        Map<String, Object> chartData = new HashMap<>();

        // Get today's date
        LocalDate today = LocalDate.now();

        // Generate the last 30 days
        List<String> dates = new ArrayList<>();
        List<Integer> pendingData = new ArrayList<>();
        List<Integer> paidData = new ArrayList<>();
        List<Integer> overdueData = new ArrayList<>();

        Set<String> allDates = new LinkedHashSet<>();
        for (int i = 0; i < 30; i++) {
            LocalDate date = today.minusDays(i);
            allDates.add(date.toString()); // Format as yyyy-MM-dd
        }

        // Fill the data for each date (in reverse order: oldest first)
        for (String date : allDates) {
            dates.add(date);
            pendingData.add(statusData.getOrDefault("pending", Collections.emptyMap()).getOrDefault(date, 0));
            paidData.add(statusData.getOrDefault("paid", Collections.emptyMap()).getOrDefault(date, 0));
            overdueData.add(statusData.getOrDefault("overdue", Collections.emptyMap()).getOrDefault(date, 0));
        }

        // Add the prepared data to the map
        chartData.put("dates", dates);
        chartData.put("pending", pendingData);
        chartData.put("paid", paidData);
        chartData.put("overdue", overdueData);

        return chartData;
    }
}
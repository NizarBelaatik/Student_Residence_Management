package api;

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



@WebServlet(name = "getPaymentGraph", urlPatterns = {"/admin-api/getPaymentGraph"})
public class getPaymentGraph extends HttpServlet {
    private PaymentDAO paymentDAO = new PaymentDAO();

    public getPaymentGraph() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Database code (database connection and query execution should be inside this try block)
            Map<String, Map<String, Integer>> statusData = paymentDAO.getPaymentGraphData();

            // Log the prepared JSON response for debugging
            String jsonResponse = prepareChartData(statusData);

            // Send the response back to the frontend
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(jsonResponse);
        } catch (SQLException e) {
            // Catch any SQLExceptions during database interaction
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\": \"Database error: " + e.getMessage() + "\"}");
        } catch (Exception e) {
            // Catch any other exceptions
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\": \"An unexpected error occurred: " + e.getMessage() + "\"}");
        }
    }

    private String prepareChartData(Map<String, Map<String, Integer>> statusData) {
        StringBuilder dates = new StringBuilder();
        StringBuilder pendingData = new StringBuilder();
        StringBuilder paidData = new StringBuilder();
        StringBuilder overdueData = new StringBuilder();

        // Get the current date
        LocalDate today = LocalDate.now();

        // Generate the last 30 days
        Set<String> allDates = new LinkedHashSet<>();
        for (int i = 0; i < 30; i++) {
            LocalDate date = today.minusDays(i);
            allDates.add(date.toString()); // Convert to string format (yyyy-MM-dd)
        }

        // Build the chart data for each date in the reversed order (oldest first)
        for (String date : allDates) {
            dates.insert(0, "\"" + date + "\","); // Add dates at the start for reverse order

            // Ensure that for each date, if no data exists, we append 0
            pendingData.insert(0, statusData.getOrDefault("pending", Collections.emptyMap()).getOrDefault(date, 0) + ",");
            paidData.insert(0, statusData.getOrDefault("paid", Collections.emptyMap()).getOrDefault(date, 0) + ",");
            overdueData.insert(0, statusData.getOrDefault("overdue", Collections.emptyMap()).getOrDefault(date, 0) + ",");
        }

        // Remove the last comma to fix the array syntax
        if (dates.length() > 0) dates.setLength(dates.length() - 1);
        if (pendingData.length() > 0) pendingData.setLength(pendingData.length() - 1);
        if (paidData.length() > 0) paidData.setLength(paidData.length() - 1);
        if (overdueData.length() > 0) overdueData.setLength(overdueData.length() - 1);

        // Prepare JSON response with the corrected data
        return String.format("{\"dates\": [%s], \"pending\": [%s], \"paid\": [%s], \"overdue\": [%s]}",
                dates.toString(), pendingData.toString(), paidData.toString(), overdueData.toString());
    }




}

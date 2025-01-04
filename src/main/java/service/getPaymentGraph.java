package service;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.*;

import dao.PaymentDAO;



@WebServlet(name = "getPaymentGraph", urlPatterns = {"/getPaymentGraph"})
public class getPaymentGraph  extends HttpServlet {
    private PaymentDAO paymentDAO = new PaymentDAO();

    public getPaymentGraph() {
        super();
        // TODO Auto-generated constructor stub
    }// Handle GET requests to fetch payment stats


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Set content type to JSON
        Map<String, Map<String, Integer>> statusData = paymentDAO.getPaymentGraphData();

        // Prepare the data for the chart in JSON format
        String jsonResponse = prepareChartData(statusData);

        // Set the response content type to JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // Write the JSON data to the response
        response.getWriter().write(jsonResponse);
    }

    private String prepareChartData(Map<String, Map<String, Integer>> statusData) {
        StringBuilder dates = new StringBuilder();
        StringBuilder pendingData = new StringBuilder();
        StringBuilder paidData = new StringBuilder();
        StringBuilder overdueData = new StringBuilder();

        Set<String> allDates = new TreeSet<>(); // To collect all unique dates

        // Collect all dates from the data
        for (String status : statusData.keySet()) {
            Map<String, Integer> dailyData = statusData.get(status);
            for (String date : dailyData.keySet()) {
                allDates.add(date);
            }
        }

        // Build the chart data
        for (String date : allDates) {
            dates.append("\"").append(date).append("\",");
            pendingData.append(statusData.getOrDefault("pending", Collections.emptyMap()).getOrDefault(date, 0)).append(",");
            paidData.append(statusData.getOrDefault("paid", Collections.emptyMap()).getOrDefault(date, 0)).append(",");
            overdueData.append(statusData.getOrDefault("overdue", Collections.emptyMap()).getOrDefault(date, 0)).append(",");
        }

        // Remove the last comma
        dates.setLength(dates.length() - 1);
        pendingData.setLength(pendingData.length() - 1);
        paidData.setLength(paidData.length() - 1);
        overdueData.setLength(overdueData.length() - 1);

        // Prepare JSON response
        return String.format("{\"dates\": [%s], \"pending\": [%s], \"paid\": [%s], \"overdue\": [%s]}",
                dates.toString(), pendingData.toString(), paidData.toString(), overdueData.toString());
    }
}

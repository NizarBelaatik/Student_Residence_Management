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
import java.util.Map;

import java.util.*;



@WebServlet(urlPatterns = {"/admin-api/getMaintenanceGraph"})
public class getMaintenanceGraph extends HttpServlet {
    private MaintenanceRequestsDAO maintenanceRequestsDAO = new MaintenanceRequestsDAO();

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");

        try {
            // Fetch data using your DAO method
            Map<String, Map<String, Integer>> data = maintenanceRequestsDAO.getRequestsGroupedByDayAndStatus();

            // Prepare data in a suitable structure for Chart.js
            Map<String, Object> chartData = new HashMap<>();
            List<String> labels = new ArrayList<>();
            Map<String, List<Integer>> datasets = new LinkedHashMap<>();

            // Get the current date and prepare the last 30 days
            Calendar calendar = Calendar.getInstance();
            List<String> last30Days = new ArrayList<>();
            for (int i = 0; i < 30; i++) {
                calendar.add(Calendar.DAY_OF_MONTH, -1); // Go back one day at a time
                last30Days.add(new SimpleDateFormat("yyyy-MM-dd").format(calendar.getTime()));
            }
            Collections.reverse(last30Days); // Make the list from oldest to newest

            // Initialize datasets for each status to 0 for each day
            for (String date : last30Days) {
                // Add date to labels
                labels.add(date);

                // Initialize the dataset for each status if not present
                for (String status : data.keySet()) {
                    datasets.putIfAbsent(status, new ArrayList<>());
                    // Initialize counts to 0 for each status on this day
                    datasets.get(status).add(0);
                }
            }

            // Update the dataset with actual values
            for (String date : data.keySet()) {
                Map<String, Integer> statusMap = data.get(date);
                int dateIndex = last30Days.indexOf(date);

                for (String status : statusMap.keySet()) {
                    // Update the dataset with actual values
                    int count = statusMap.get(status);
                    datasets.get(status).set(dateIndex, count);
                }
            }

            // Populate chart data with labels and datasets
            chartData.put("labels", labels);
            chartData.put("datasets", datasets);

            // Convert the map to JSON and send as response
            Gson gson = new Gson();
            String jsonResponse = gson.toJson(chartData);
            response.getWriter().write(jsonResponse);

        } catch (SQLException e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}
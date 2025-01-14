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
import java.util.Map;

import java.util.*;

@WebServlet("/admin-api/getRequestData")
public class RequestDataServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");

        try {
            // Fetch data using your DAO method
            MaintenanceRequestsDAO maintenanceRequestsDAO = new MaintenanceRequestsDAO();
            Map<String, Map<String, Integer>> data = maintenanceRequestsDAO.getRequestsGroupedByDayAndStatus();

            // Prepare data in a suitable structure for Chart.js
            Map<String, Object> chartData = new HashMap<>();
            List<String> labels = new ArrayList<>();
            Map<String, List<Integer>> datasets = new LinkedHashMap<>();

            for (String date : data.keySet()) {
                labels.add(date); // Adding the dates for x-axis
                Map<String, Integer> statusMap = data.get(date);

                for (String status : statusMap.keySet()) {
                    datasets.putIfAbsent(status, new ArrayList<>());
                    datasets.get(status).add(statusMap.get(status));
                }
            }

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

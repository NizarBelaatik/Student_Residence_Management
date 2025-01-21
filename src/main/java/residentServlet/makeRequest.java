package residentServlet;

import dao.NotificationDAO;
import dao.RoomDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.MaintenanceRequests;
import model.Notification;
import model.User;
import dao.MaintenanceRequestsDAO;
import java.io.IOException;
import java.sql.SQLException;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
@WebServlet(urlPatterns = {"/u/make_request"})
public class makeRequest extends HttpServlet {
    private MaintenanceRequestsDAO maintenanceRDAO = new MaintenanceRequestsDAO();
    private NotificationDAO notificationDAO = new NotificationDAO();
    private RoomDAO roomDAO = new RoomDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Forward the request to the actual JSP page


        String roomId = request.getParameter("roomId");
        request.setAttribute("roomId", roomId);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/resident/makeRequest.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpSession session = req.getSession(false);
        User user = (User) session.getAttribute("user");
        String email = user.getEmail();

        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = request.getReader().readLine()) != null) {
            sb.append(line);
        }
        String jsonData = sb.toString();

        // Parse the JSON data
        JsonObject jsonObject = JsonParser.parseString(jsonData).getAsJsonObject();
        String roomId = jsonObject.get("roomId").getAsString();
        String incident_type = jsonObject.get("incidentType").getAsString(); // Ensure this matches your AJAX
        String description = jsonObject.get("description").getAsString();

        MaintenanceRequests mainRequest = new MaintenanceRequests(email, roomId, incident_type, description, "pending");

        try {
            maintenanceRDAO.addMaintenanceRequest(mainRequest);

            // Send success response
            response.setContentType("application/json");
            response.setStatus(HttpServletResponse.SC_OK); // 200 OK
            response.getWriter().write("{\"status\":\"success\"}");

            //SEND NOTIFICATION TO ADMIN
            String subjectAdmin = "New Maintenance Request - Action Required";
            String notifMSGAdmin = "A new maintenance request has been submitted. Please review the request and assign a technician to fix the issue. Maintenance Request ID: " + mainRequest.getId() + ". Thank you!";

            Notification notifAdmin = new Notification(1, email, "ADMIN", subjectAdmin, notifMSGAdmin, false, "pending", null, null);
            notificationDAO.add(notifAdmin);
            roomDAO.updateRoomStatus(roomId, "Maintenance");


        } catch (SQLException e) {
            // Handle SQL exception and send error response
            response.setContentType("application/json");
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR); // 500 Internal Server Error
            response.getWriter().write("{\"status\":\"error\", \"message\":\"Failed to add maintenance request.\"}");
        }
    }


}

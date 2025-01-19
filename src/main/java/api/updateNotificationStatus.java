package api;


import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import dao.NotificationDAO;
import jakarta.servlet.http.HttpSession;
import model.User;

/**
 *
 * @author night
 */
@WebServlet(name = "updateNotificationStatus", urlPatterns = {"/api/updateNotificationStatus"})
public class updateNotificationStatus extends HttpServlet {
    private NotificationDAO notificationDAO = new NotificationDAO();

    public updateNotificationStatus(){ super();}

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Read email and action from request
        //String email = request.getParameter("email");

        HttpServletRequest req = (HttpServletRequest) request;
        HttpSession session = req.getSession(false);
        User user = (User) session.getAttribute("user");
        String email= user.getEmail() ;
        // Assuming NotificationDAO is properly implemented


        // Update the notification status in the database
        boolean isUpdated = notificationDAO.updateNotificationStatus(email);

        // Prepare the response based on the update
        String status = isUpdated ? "success" : "error";
        String message = isUpdated ? "Notification status updated successfully" : "Failed to update notification status";

        // Construct the JSON response manually (instead of JSONObject)
        String jsonResponse = "{\"status\":\"" + status + "\", \"message\":\"" + message +  "}";

        // Set content type and send the response
        response.setContentType("application/json");
        response.getWriter().write(jsonResponse); // Send JSON response back to the client
    }
}

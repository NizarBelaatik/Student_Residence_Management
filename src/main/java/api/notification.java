package api;

import dao.NotificationDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Notification;
import model.User;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.fasterxml.jackson.databind.ObjectMapper; // Add the Jackson dependency for JSON mapping

@WebServlet( urlPatterns = {"/api/notification"})
public class notification extends HttpServlet {

    private NotificationDAO notificationDAO = new NotificationDAO();
    public notification(){
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the session
        HttpSession session = request.getSession(false);
        if (session == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return; // Return unauthorized if the session doesn't exist
        }
        // Get the logged-in user
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return; // Return unauthorized if the user is not logged in
        }

        String csrfTokenFromSession = (String) session.getAttribute("csrfToken");
        String csrfTokenFromRequest = request.getHeader("X-CSRF-Token");
        if (csrfTokenFromRequest == null || !csrfTokenFromRequest.equals(csrfTokenFromSession)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "CSRF token validation failed");
            return;
        }


        // Get notifications for the user
        String email = user.getEmail();
        List<Notification> notifications = notificationDAO.getNotifByEmail(email);

        // Calculate unread count
        int unreadCount = 0;
        for (Notification notification : notifications) {
            if (!notification.getStatus()) { // status is false, meaning unread
                unreadCount++;
            }
        }
        // Create a response object
        Map<String, Object> responseData = new HashMap<>();
        responseData.put("email", email);
        responseData.put("notifications", notifications);
        responseData.put("unreadCount", unreadCount);

        // Set response content type to JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // Convert the responseData map to JSON and send it as the response
        ObjectMapper mapper = new ObjectMapper();
        mapper.writeValue(response.getOutputStream(), responseData);
    }
}
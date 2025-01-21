package adminServlet;

import dao.MaintenanceRequestsDAO;
import dao.NotificationDAO;
import dao.UserAdminTInfoDAO;
import dao.UserDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.*;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


@WebServlet(name = "maintenanceDetails", urlPatterns = {"/admin/maintenance/maintenanceDetails"})
public class maintenanceDetails  extends HttpServlet {
    private MaintenanceRequestsDAO mainreDAO = new MaintenanceRequestsDAO();
    private UserDAO userDAO = new UserDAO();
    private UserAdminTInfoDAO useratinfoDAO = new UserAdminTInfoDAO();
    private NotificationDAO notificationDAO = new NotificationDAO();


    public maintenanceDetails() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Forward the request to the actual JSP page
        List<MaintenanceRequests> maintenanceList = new ArrayList<>();
        String requestId = request.getParameter("requestId");
        List<UserAdminTInfo> userTinfoList = new ArrayList<>(); // Initialize the list

        try {
            // Retrieve the maintenance request by ID
            request.setAttribute("M_data", mainreDAO.getMaintenanceRequestById(requestId));
            request.setAttribute("getTechnicianName", mainreDAO.getMaintenanceRequestById(requestId).getTechnicianName());
            // Get all technicians without passwords
            List<User> userTechList = userDAO.getAllUsersWithoutPW("tech");

            // Loop through each technician and retrieve their information


            userTechList.forEach(userTech->{
                try{
                    UserAdminTInfo userInfo = useratinfoDAO.getUserAdminTInfoByEmail(userTech.getEmail());
                    userTinfoList.add(userInfo); // Add the technician info to the list
                } catch (SQLException e) {e.printStackTrace();}

            });

        } catch (SQLException e) {
            e.printStackTrace();
        }



        // Set the technician information in the request
        request.setAttribute("technician", userTinfoList);


        // Forward to the JSP page
        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/admin/maintenanceDetails.jsp");
        request.setAttribute("activePage", "maintenance");  // Set active page
        dispatcher.forward(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


        HttpSession session = request.getSession(false);
        String csrfTokenFromSession = (String) session.getAttribute("csrfToken");
        String csrfTokenFromRequest = request.getHeader("X-CSRF-Token");
        if (csrfTokenFromRequest == null || !csrfTokenFromRequest.equals(csrfTokenFromSession)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "CSRF token validation failed");
            return;
        }


        String inputTechnician = request.getParameter("inputTechnician");
        String inputStatus = request.getParameter("inputStatus");
        String inputRequestId = request.getParameter("inputRequestId");
        boolean success =false;
        String message = "";
        try{
            mainreDAO.updateMaintenanceRequestStatus(inputRequestId,inputStatus, inputTechnician);
            success = true;
            message = "Maintenance has been successfully Edited!";

            //SEND NOTIFICATION TO TECHNICIAN
            String subjectTech = "New Maintenance Request Assigned";
            String notifMSGTech = "You have been assigned to a new maintenance request. Please review the request details and proceed to fix the issue. Maintenance Request ID: " + inputRequestId + ". Thank you!";

            Notification notifTech = new Notification(1, "ADMIN", inputTechnician, subjectTech, notifMSGTech, false, inputStatus, null, null);
            notificationDAO.add(notifTech);

        } catch (SQLException e) {
            // Handle SQL exceptions and set error message
            success = false;
            message = "Something went wrong. Please try again."+e;
        }

        // Send the response as JSON
        if (success) {
            String jsonResponse = "{\"messageType\":\"success\", \"message\":\"" + message + "\"}";
            response.getWriter().write(jsonResponse);
        } else {
            String jsonResponse = "{\"messageType\":\"error\", \"message\":\"" + message + "\"}";
            response.getWriter().write(jsonResponse);
        }


    }
}

package techServlet;

import dao.*;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.*;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


@WebServlet( urlPatterns = {"/t/maintenance/maintenanceDetails"})
public class maintenanceDetails  extends HttpServlet {
    private MaintenanceRequestsDAO mainreDAO = new MaintenanceRequestsDAO();
    private NotificationDAO notificationDAO = new NotificationDAO();
    private RoomDAO roomDAO = new RoomDAO();

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

        } catch (SQLException e) {
            e.printStackTrace();
        }



        // Set the technician information in the request
        request.setAttribute("technician", userTinfoList);

        // Forward to the JSP page
        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/tech/maintenanceDetails.jsp");
        dispatcher.forward(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String inputStatus = request.getParameter("inputStatus");
        String inputRequestId = request.getParameter("inputRequestId");
        boolean success =false;
        String message = "";
        try{
            mainreDAO.updateMaintenanceRequestStatusT(inputRequestId,inputStatus);
            success = true;
            message = "Maintenance has been successfully Edited!";
            if("resolved".equals(inputStatus)) {
                //SEND NOTIFICATION TO RESIDENT
                String subjectResident = "Maintenance Request Fixed";
                String notifMSGResident = "Your maintenance request has been successfully fixed. Maintenance Request ID: " + inputRequestId + ". Thank you for your patience!";
                String residentEmail = mainreDAO.getMaintenanceRequestById(inputRequestId).getResidentEmail();
                Notification notifResident = new Notification(1, "TECH", residentEmail, subjectResident, notifMSGResident, false, "resolved", null, null);
                notificationDAO.add(notifResident);
            }

            String roomId =  mainreDAO.getMaintenanceRequestGetRoomId(inputRequestId);
            if("resolved".equals(inputStatus)){roomDAO.updateRoomStatus(roomId, "Available");
            }else{roomDAO.updateRoomStatus(roomId, "Maintenance");}

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

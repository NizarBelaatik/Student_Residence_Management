package techServlet;

import dao.MaintenanceRequestsDAO;
import dao.UserAdminTInfoDAO;
import dao.UserDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.MaintenanceRequests;
import model.Payment;
import model.User;
import model.UserAdminTInfo;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


@WebServlet( urlPatterns = {"/t/maintenance/maintenanceDetails"})
public class maintenanceDetails  extends HttpServlet {
    private MaintenanceRequestsDAO mainreDAO = new MaintenanceRequestsDAO();

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

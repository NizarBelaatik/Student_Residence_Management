package adminServlet;

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


@WebServlet(name = "maintenanceDetails", urlPatterns = {"/admin/maintenanceDetails"})
public class maintenanceDetails  extends HttpServlet {
    private MaintenanceRequestsDAO mainreDAO = new MaintenanceRequestsDAO();
    private UserDAO userDAO = new UserDAO();
    private UserAdminTInfoDAO useratinfoDAO = new UserAdminTInfoDAO();
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

}

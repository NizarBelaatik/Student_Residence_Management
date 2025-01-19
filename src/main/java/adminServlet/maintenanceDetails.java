package adminServlet;

import dao.MaintenanceRequestsDAO;
import dao.UserDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.MaintenanceRequests;
import model.User;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


@WebServlet(name = "maintenanceDetails", urlPatterns = {"/admin/maintenanceDetails"})
public class maintenanceDetails  extends HttpServlet {
    private MaintenanceRequestsDAO mainreDAO = new MaintenanceRequestsDAO();
    private UserDAO userDAO = new UserDAO();
    public maintenanceDetails() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Forward the request to the actual JSP page
        //roomDAO RoomDAO = new roomDAO();
        List<MaintenanceRequests> maintenanceList = new ArrayList<>();
        String requestId = request.getParameter("requestId");
        try {
            List<User> technicianName = userDAO.getAllUsersWithoutPW("tech");
            request.setAttribute("M_data", mainreDAO.getMaintenanceRequestById(requestId));
            request.setAttribute("technician", technicianName);
        } catch (SQLException e) {
            e.printStackTrace();
        }


        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/admin/maintenanceDetails.jsp");
        request.setAttribute("activePage", "maintenance");  // Set active page

        dispatcher.forward(request, response);
    }
}

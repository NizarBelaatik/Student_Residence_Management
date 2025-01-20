package adminServlet;


import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dao.MaintenanceRequestsDAO;
import model.MaintenanceRequests;


@WebServlet(name = "maintenance", urlPatterns = {"/admin/maintenance"})
public class maintenance  extends HttpServlet {
    private MaintenanceRequestsDAO mainreDAO = new MaintenanceRequestsDAO();

    public maintenance() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Forward the request to the actual JSP page
        //roomDAO RoomDAO = new roomDAO();

        try {

            request.setAttribute("M_pending", mainreDAO.getAllMaintenanceRequestsByStatus("pending"));
            request.setAttribute("M_in_progress", mainreDAO.getAllMaintenanceRequestsByStatus("in_progress"));
            request.setAttribute("M_resolved", mainreDAO.getAllMaintenanceRequestsByStatus("resolved"));
        } catch (SQLException e) {
            e.printStackTrace();
        }


        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/admin/maintenance.jsp");
        request.setAttribute("activePage", "maintenance");  // Set active page

        dispatcher.forward(request, response);
    }
}

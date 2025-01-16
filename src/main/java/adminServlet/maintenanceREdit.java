package adminServlet;

import dao.MaintenanceRequestsDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.MaintenanceRequests;
import model.User;

import java.io.IOException;
import java.sql.SQLException;


@WebServlet(urlPatterns = {"/admin/maintenance_request/edit"})
public class maintenanceREdit extends HttpServlet {
    private MaintenanceRequestsDAO maintenanceRDAO = new MaintenanceRequestsDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Forward the request to the actual JSP page
        HttpServletRequest req = (HttpServletRequest) request;
        HttpSession session = req.getSession(false);
        User user = (User) session.getAttribute("user");
        String email= user.getEmail() ;
        String requestId = request.getParameter("requestId");
        MaintenanceRequests maintenanceR;

        try{
            maintenanceR = maintenanceRDAO.getMaintenanceRequestById(requestId);
        } catch (SQLException e) {throw new RuntimeException(e);}

        request.setAttribute("maintenanceR", maintenanceR);
        request.setAttribute("maintenance_requests", "maintenance_requests");

        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/admin/maintenanceRequests.jsp");
        dispatcher.forward(request, response);
    }
}


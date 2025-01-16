package adminServlet;

import dao.MaintenanceRequestsDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;

import java.util.ArrayList;
import java.util.List;

import model.MaintenanceRequests;
import model.Resident;
import model.User;


@WebServlet(urlPatterns = {"/admin/maintenance_requests"})
public class maintenanceR extends HttpServlet {
    private MaintenanceRequestsDAO maintenanceRDAO = new MaintenanceRequestsDAO();

    @Override
        protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            // Forward the request to the actual JSP page
            HttpServletRequest req = (HttpServletRequest) request;
            HttpSession session = req.getSession(false);
            User user = (User) session.getAttribute("user");
            String email= user.getEmail() ;

            request.setAttribute("maintenance_requests", "maintenance_requests");
            List<MaintenanceRequests> maintenanceR_List = new ArrayList<>();
            try{
                maintenanceR_List = maintenanceRDAO.getAllMaintenanceRequests();
            } catch (SQLException e) {throw new RuntimeException(e);}

            request.setAttribute("maintenanceR_List", maintenanceR_List);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/views/admin/maintenanceRequests.jsp");
            dispatcher.forward(request, response);
        }
}

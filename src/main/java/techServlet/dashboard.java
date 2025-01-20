package techServlet;

import dao.MaintenanceRequestsDAO;
import dao.UserAdminTInfoDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import model.User;
import model.UserAdminTInfo;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet(urlPatterns = {"/t/dashboard"})
public class dashboard extends HttpServlet {
    private MaintenanceRequestsDAO maintRequestDao = new MaintenanceRequestsDAO();

    private UserAdminTInfoDAO userTechDAO= new UserAdminTInfoDAO();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Forward the request to the actual JSP page
        HttpServletRequest req = (HttpServletRequest) request;
        HttpSession session = req.getSession(false);
        User user = (User) session.getAttribute("user");
        String email= user.getEmail() ;

        try {

            request.setAttribute("maintenanceDATA", maintRequestDao.getAllMaintenanceRequestsByRT(email,"tech"));
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        try {

            request.setAttribute("M_pending", maintRequestDao.getAllMaintenanceRequestsByStatusT("pending",email));
            request.setAttribute("M_in_progress", maintRequestDao.getAllMaintenanceRequestsByStatusT("in_progress",email));
            request.setAttribute("M_resolved", maintRequestDao.getAllMaintenanceRequestsByStatusT("resolved",email));
        } catch (SQLException e) {
            e.printStackTrace();
        }
        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/tech/dashboardTech.jsp");
        dispatcher.forward(request, response);
    }
}

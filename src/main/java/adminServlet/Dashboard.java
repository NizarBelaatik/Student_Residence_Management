
package adminServlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import dao.MaintenanceRequestsDAO;
import dao.RoomDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.RequestDispatcher;

import jakarta.servlet.http.HttpSession;

import model.User;
import dao.PaymentDAO;

/**
 *
 * @author night
 */
@WebServlet(name = "Dashboard", urlPatterns = {"/admin/dashboard"})
public class Dashboard extends HttpServlet {
    private PaymentDAO paymentDAO = new PaymentDAO();
    private RoomDAO roomDAO = new RoomDAO();
    private MaintenanceRequestsDAO maintenanceDAO = new MaintenanceRequestsDAO();
    public Dashboard() {
        super();
        // TODO Auto-generated constructor stub
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
    
        if (session == null || session.getAttribute("user") == null) {  
            response.sendRedirect("login");
            return;
        }
        
        // Get the logged-in user from the session
        User user = (User) session.getAttribute("user");
        String role="admin";
        if(role.equals(user.getRole())){
            // Forward to the dashboard JSP with user and role info

            int maintenance_requests = 0;
            request.setAttribute("overdue", paymentDAO.getPaymentsByStatusINT("overdue"));
            request.setAttribute("paid", paymentDAO.getPaymentsByStatusINT("paid"));
            request.setAttribute("pending", paymentDAO.getPaymentsByStatusINT("pending"));





            request.setAttribute("total_payments_overdue", paymentDAO.getTotalPaymentsByStatus("overdue"));
            request.setAttribute("total_payments_paid", paymentDAO.getTotalPaymentsByStatus("paid"));
            request.setAttribute("total_payments_pending", paymentDAO.getTotalPaymentsByStatus("pending"));



            try {
                // Get counts of rooms based on their status
                int availableRooms = roomDAO.getRoomsByStatusSize("Available");
                int occupiedRooms = roomDAO.getRoomsByStatusSize("Occupied");
                int maintenanceRooms = roomDAO.getRoomsByStatusSize("Maintenance");

                // Set these counts as request attributes
                request.setAttribute("available_rooms", availableRooms);
                request.setAttribute("occupied_rooms", occupiedRooms);
                request.setAttribute("maintenance_rooms", maintenanceRooms);


                request.setAttribute("paymentsN", paymentDAO.getPaymentsN(5) );
                request.setAttribute("maintenance_requestsN", maintenanceDAO.getRecentMaintenanceRequests(5));

            } catch (SQLException e) {
                e.printStackTrace();
                // Handle exceptions as appropriate
            }

            request.setAttribute("user", user);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/views/admin/dashboardAdmin.jsp");
            request.setAttribute("activePage", "dashboard");  // Set active page
            dispatcher.forward(request, response);
        }else{
            response.sendRedirect("error");
        }

    }
}

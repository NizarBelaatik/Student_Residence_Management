
package adminServlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

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
            request.setAttribute("overdue", paymentDAO.getPaymentsByStatusSize("overdue"));
            request.setAttribute("paid", paymentDAO.getPaymentsByStatusSize("paid"));
            request.setAttribute("pending", paymentDAO.getPaymentsByStatusSize("pending"));
            request.setAttribute("maintenance_requests", maintenance_requests);


            request.setAttribute("total_payments_overdue", paymentDAO.getTotalOverduePayments());
            request.setAttribute("total_payments_paid", paymentDAO.getTotalPaymentsThisMonthByStatus("paid"));
            request.setAttribute("total_payments_pending", paymentDAO.getTotalPendingPayments());



            try {
                // Get counts of rooms based on their status
                int availableRooms = roomDAO.getRoomsByStatusSize("Available");
                int occupiedRooms = roomDAO.getRoomsByStatusSize("Occupied");
                int maintenanceRooms = roomDAO.getRoomsByStatusSize("Maintenance");

                // Set these counts as request attributes
                request.setAttribute("available_rooms", availableRooms);
                request.setAttribute("occupied_rooms", occupiedRooms);
                request.setAttribute("maintenance_rooms", maintenanceRooms);

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

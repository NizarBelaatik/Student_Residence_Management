
package adminServlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

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
            int overdue = paymentDAO.getPaymentsByStatusSize("overdue");
            int paid = paymentDAO.getPaymentsByStatusSize("paid");
            int pending = paymentDAO.getPaymentsByStatusSize("pending");
            int maintenance_requests = 0;
            request.setAttribute("overdue", overdue);
            request.setAttribute("paid", paid);
            request.setAttribute("pending", pending);
            request.setAttribute("maintenance_requests", maintenance_requests);


            request.setAttribute("total_payments_overdue", paymentDAO.getTotalOverduePayments());
            request.setAttribute("total_payments_paid", paymentDAO.getTotalPaymentsThisMonthByStatus("paid"));
            request.setAttribute("total_payments_pending", paymentDAO.getTotalPendingPayments());



            request.setAttribute("user", user);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/views/admin/dashboardAdmin.jsp");
            request.setAttribute("activePage", "dashboard");  // Set active page
            dispatcher.forward(request, response);
        }else{
            response.sendRedirect("error");
        }
        
    }
}

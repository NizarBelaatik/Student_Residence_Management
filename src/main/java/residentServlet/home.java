/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package residentServlet;

import dao.PaymentDAO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Payment;
import model.User;
import model.Notification;

import dao.NotificationDAO;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
/**
 *
 * @author night
 */
@WebServlet(name = "home", urlPatterns = {"/u/home"})
public class home extends HttpServlet {
    NotificationDAO notificationDAO = new NotificationDAO();
    PaymentDAO paymentDAO = new PaymentDAO();

    public home(){
        super();
        }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Forward the request to the actual JSP page
        HttpServletRequest req = (HttpServletRequest) request;
        HttpSession session = req.getSession(false);
        
        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/resident/home.jsp");
        User user = (User) session.getAttribute("user");
        String email= user.getEmail() ;


        List<Notification> notif=  notificationDAO.getNotifByEmail(email);

        int unreadCount = 0;
        for (Notification notification : notif) {
            if (!notification.getStatus()) { // status is false, meaning unread
                unreadCount++; // Increment the unread count
            }
        }

        int limit = 5;  // For example, to get the most recent 5 payments
        //List<Payment> payments = new ArrayList<>();
        try {

            request.setAttribute("P_overdue", paymentDAO.getAllPaymentsByResident(email,"overdue",limit));
            request.setAttribute("P_paid", paymentDAO.getAllPaymentsByResident(email,"paid",limit));
            request.setAttribute("P_pending", paymentDAO.getAllPaymentsByResident(email,"pending",limit));
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }


        request.setAttribute("email", email);
        request.setAttribute("notifications", notif);
        request.setAttribute("unreadCount", unreadCount);
        dispatcher.forward(request, response);
    }
}

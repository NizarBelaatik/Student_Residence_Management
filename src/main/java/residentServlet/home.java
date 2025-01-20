/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package residentServlet;

import dao.*;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.*;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import static utils.DateUtils.formatTimestampToDate;

/**
 *
 * @author night
 */
@WebServlet(name = "home", urlPatterns = {"/u/home"})
public class home extends HttpServlet {
    private NotificationDAO notificationDAO = new NotificationDAO();
    private PaymentDAO paymentDAO = new PaymentDAO();
    private ResidentDAO residentDAO = new ResidentDAO();
    private RoomDAO roomDAO = new RoomDAO();
    private MaintenanceRequestsDAO maintRequestDao = new MaintenanceRequestsDAO();
    public home(){
        super();
        }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Forward the request to the actual JSP page
        HttpServletRequest req = (HttpServletRequest) request;
        HttpSession session = req.getSession(false);
        

        User user = (User) session.getAttribute("user");
        String email= user.getEmail() ;

        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/resident/home.jsp");
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

        try {

            request.setAttribute("maintenanceDATA", maintRequestDao.getAllMaintenanceRequestsByRT(email,"resident"));
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }


        Resident resident ;
        Room room;

        try{
            resident = residentDAO.getResidentByEmail(email);
            room = roomDAO.getRoomById(resident.getRoomId());
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }



        request.setAttribute("email", email);
        request.setAttribute("user_since", formatTimestampToDate(user.getCreatedAt()));
        request.setAttribute("resident", resident);
        request.setAttribute("room", room);

        dispatcher.forward(request, response);
    }
}

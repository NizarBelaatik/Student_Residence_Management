package api;

import java.io.IOException;

import dao.NotificationDAO;
import dao.PaymentDAO;
import dao.ResidentDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.sql.SQLException;
import java.sql.Timestamp;

import jakarta.servlet.http.HttpSession;
import model.Notification;
import model.Payment;
import service.EmailSender;
import service.PaymentManager;

@WebServlet(name = "MakePayments", urlPatterns = {"/admin-api/MakePayments"})
public class makePayments  extends HttpServlet{
    private PaymentManager paymentManager= new PaymentManager();
    private ResidentDAO residentDAO = new ResidentDAO();
    private PaymentDAO paymentDAO = new PaymentDAO();
    private NotificationDAO notificationDAO = new NotificationDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {


        // Set response type to JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        //String residentEmail = request.getParameter("email");
        String paymentID = request.getParameter("paymentID");


        boolean success = false;
        String message = "";
        try {
            //Resident resident = residentDAO.getResidentByEmail(residentEmail);
            //paymentManager.sendReminder(resident);
            Payment payment= paymentDAO.getPaymentByID(paymentID);
            payment.setPaymentDate(new Timestamp(System.currentTimeMillis()));
            payment.setAmountPaid(payment.getAmountDue());
            paymentDAO.PaymentPaid(payment);
            success = true;
            message = "Payment processed successfully!" ;

            // send email
            EmailSender.sendPaymentPaidEmail(payment);


            //SEND NOTIFICATION
            String subject = "Payment processed successfully!";
            String notifMSG = "Your payment of " + payment.getAmountDue() + " has been successfully processed. Payment ID: " + payment.getPaymentId() + ". Thank you!";

            Notification notif = new Notification(1,"ADMIN",payment.getEmail(),subject,notifMSG,false,"success",null,null);
            notificationDAO.add(notif);

        } catch (SQLException e) {
            // Handle SQL exceptions and set error message
            success = false;
            message = "Payment failed. Please try again.";
        }

        // Send the response as JSON
        if (success) {
            String jsonResponse = "{\"messageType\":\"success\", \"message\":\"" + message + "\"}";
            response.getWriter().write(jsonResponse);
        } else {
            String jsonResponse = "{\"messageType\":\"error\", \"message\":\"" + message + "\"}";
            response.getWriter().write(jsonResponse);
        }



    }
}

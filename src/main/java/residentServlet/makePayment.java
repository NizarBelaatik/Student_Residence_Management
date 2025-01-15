package residentServlet;

import com.google.gson.Gson;
import dao.MakePaymentDataDAO;
import dao.NotificationDAO;
import dao.PaymentDAO;
import dao.ResidentDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.*;
import service.EmailSender;
import service.PaymentManager;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

@WebServlet(urlPatterns = {"/u/make_payment"})
public class makePayment extends HttpServlet {
    private ResidentDAO residentDAO = new ResidentDAO();
    private PaymentManager paymentManager = new PaymentManager();
    private PaymentDAO paymentDAO = new PaymentDAO();
    private MakePaymentDataDAO makepaymentdataDAO = new MakePaymentDataDAO();
    private Gson gson = new Gson(); // Create a Gson instance
    NotificationDAO notificationDAO = new NotificationDAO();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Forward the request to the actual JSP page
        HttpServletRequest req = (HttpServletRequest) request;
        HttpSession session = req.getSession(false);
        User user = (User) session.getAttribute("user");
        String email= user.getEmail() ;

        String paymentId = request.getParameter("paymentId");
        request.setAttribute("paymentId", paymentId);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/resident/makePayment.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpSession session = req.getSession(false);
        User user = (User) session.getAttribute("user");
        String email= user.getEmail() ;
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        try {
            // Read JSON data from request
            MakePaymentData paymentData = gson.fromJson(request.getReader(), MakePaymentData.class);

            // Process payment (implement your payment logic here)
            MakePaymentData make_payment_data = new MakePaymentData(
                        email,
                        paymentData.getCardholderName(),
                        paymentData.getCardNumber(),
                        paymentData.getExpiryDate(),
                        paymentData.getCvc(),
                        paymentData.getPaymentId());

            boolean paymentSuccess = makepaymentdataDAO.addPaymentData(make_payment_data);

            Payment payment= paymentDAO.getPaymentByID(paymentData.getPaymentId());
            payment.setPaymentDate(new Timestamp(System.currentTimeMillis()));
            payment.setAmountPaid(payment.getAmountDue());
            paymentDAO.PaymentPaid(payment);

            //SEND NOTIFICATION
            String subject = "Payment processed successfully!";
            String notifMSG = "Your payment of " + payment.getAmountDue() + " has been successfully processed. Payment ID: " + payment.getPaymentId() + ". Thank you!";

            Notification notif = new Notification(1,"ADMIN",payment.getEmail(),subject,notifMSG,false,"success",null,null);
            notificationDAO.add(notif);

            // send email
            EmailSender.sendPaymentPaidEmail(payment);

            if (paymentSuccess) {
                out.print("{\"status\":\"success\"}");
            } else {
                out.print("{\"status\":\"failure\"}");
            }
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print("{\"status\":\"error\",\"message\":\"" + e.getMessage() + "\"}");
        } finally {
            out.close();
        }
    }
}

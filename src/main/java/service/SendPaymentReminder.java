package service;

import java.io.IOException;

import dao.ResidentDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.RequestDispatcher;

import java.sql.SQLException;

import model.Resident;

import service.PaymentManager;

/**
 *
 * @author night
 */
@WebServlet(name = "SendPaymentReminder", urlPatterns = {"/SendPaymentReminder"})
public class SendPaymentReminder extends HttpServlet{
    PaymentManager paymentManager= new PaymentManager();
    ResidentDAO residentDAO = new ResidentDAO();
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Set response type to JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String residentEmail = request.getParameter("email");


        boolean success = false;
        String message = "";
        try {
            Resident resident = residentDAO.getResidentByEmail(residentEmail);
            paymentManager.sendReminder(resident);
            success = true;
            message = "A payment reminder has been sent to resident " + resident.getFirstname() + " "+ resident.getLastname() ;


        } catch (SQLException e) {
            // Handle SQL exceptions and set error message
            success = false;
            message = "Something went wrong. Please try again.";
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

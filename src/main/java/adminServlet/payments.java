package adminServlet;


import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.RequestDispatcher;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import model.Resident;
import dao.ResidentDAO;

import model.Payment;
import dao.PaymentDAO;
import service.PaymentManager;

@WebServlet(name = "payments", urlPatterns = {"/admin/payments"})
public class payments extends HttpServlet  {

    private ResidentDAO residentDAO = new ResidentDAO();
    private PaymentManager paymentManager = new PaymentManager();
    private PaymentDAO paymentDAO = new PaymentDAO();

    public payments(){
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Forward the request to the actual JSP page
        //roomDAO RoomDAO = new roomDAO();
        List<Resident> residentList = new ArrayList<>();
        List<Payment> P_overdue = new ArrayList<>();
        try{
            residentList = residentDAO.getAllResidentsForPaymentGeneration();
            List<String> paymentL=new ArrayList<String>();
            paymentL.add("overdue");
            paymentL.add("paid");
            paymentL.add("pending");

            paymentL.forEach(p->{
                try{
                    List<Payment> p_list = paymentDAO.getPaymentsByStatus(p);
                    request.setAttribute("P_"+p, p_list);
                } catch (SQLException e) {e.printStackTrace();}

            });

        }catch(SQLException e){e.printStackTrace(); }

        //paymentManager.generatePayment();

        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/admin/payments.jsp");
        request.setAttribute("activePage", "residents");  // Set active page
        request.setAttribute("residentList", residentList);
        dispatcher.forward(request, response);
    }
}

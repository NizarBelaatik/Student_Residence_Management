package residentServlet;


import dao.PaymentDAO;
import dao.ResidentDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Payment;
import model.Resident;
import model.User;
import service.PaymentManager;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(urlPatterns = {"/u/payment_history"})
public class paymentHistory extends HttpServlet {
    private ResidentDAO residentDAO = new ResidentDAO();
    private PaymentManager paymentManager = new PaymentManager();
    private PaymentDAO paymentDAO = new PaymentDAO();


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Forward the request to the actual JSP page
        HttpServletRequest req = (HttpServletRequest) request;
        HttpSession session = req.getSession(false);
        User user = (User) session.getAttribute("user");
        String email= user.getEmail() ;

        List<Resident> residentList = new ArrayList<>();
        try{
            residentList = residentDAO.getAllResidentsForPaymentGeneration();
            List<String> paymentL=new ArrayList<String>();
            paymentL.add("overdue");
            paymentL.add("paid");
            paymentL.add("pending");

            paymentL.forEach(p->{
                try{
                    List<Payment> p_list = paymentDAO.getPaymentRByStatus(p,email);
                    request.setAttribute("P_"+p, p_list);
                } catch (SQLException e) {e.printStackTrace();}

            });




        }catch(SQLException e){e.printStackTrace(); }


        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/resident/paymentHistory.jsp");
        request.setAttribute("activePage", "residents");  // Set active page
        request.setAttribute("residentList", residentList);
        dispatcher.forward(request, response);
    }
}

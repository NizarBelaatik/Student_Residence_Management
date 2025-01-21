package api;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import service.PaymentManager;
import java.io.IOException;

@WebServlet(name = "generateMonthlyPayments", urlPatterns = {"/admin-api/generateMonthlyPayments"})
public class generateMonthlyPayments  extends HttpServlet  {//
    private PaymentManager paymentManager = new PaymentManager();
    public generateMonthlyPayments() {
        super();
        // TODO Auto-generated constructor stub
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        String csrfTokenFromSession = (String) session.getAttribute("csrfToken");
        String csrfTokenFromRequest = request.getHeader("X-CSRF-Token");
        if (csrfTokenFromRequest == null || !csrfTokenFromRequest.equals(csrfTokenFromSession)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "CSRF token validation failed");
            return;
        }
        try {
            // Call your method to generate payments here
            boolean paymentsGenerated = paymentManager.generateMonthlyPayment();  // Your existing generatePayment method
            if (paymentsGenerated) {
                response.setContentType("application/json");
                response.getWriter().write("{ \"success\": true }");
            } else {
                response.setContentType("application/json");
                response.getWriter().write("{ \"success\": false }");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.setContentType("application/json");
            response.getWriter().write("{ \"success\": false }");
        }
    }
}

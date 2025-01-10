package api;

import dao.PaymentDAO;
import jakarta.servlet.http.HttpSession;
import model.Payment;
import model.User;
import org.apache.pdfbox.pdmodel.PDDocument;
import service.PaymentReceiptGenerator;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.*;
import java.sql.SQLException;

@WebServlet("/downloadReceipt")
public class PDFDownloadServlet extends HttpServlet {
    private PaymentDAO paymentDAO = new PaymentDAO();

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
        String paymentId = request.getParameter("paymentId");
        try{
            String getPaymentEmail = paymentDAO.getPaymentByID(paymentId).getEmail();
            if(role.equals(user.getRole()) || getPaymentEmail.equals(user.getEmail()) ) {
                if (paymentId != null) {
                    // Generate the PDF content using the paymentId
                    ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
                    PDDocument document = null;

                    try {
                        // Use the PaymentDAO to fetch the Payment object for the given paymentId
                        Payment payment = paymentDAO.getPaymentByID(paymentId);  // This should return the Payment object for the given paymentId

                        // Now generate the PDF in memory
                        PaymentReceiptGenerator.generatePaymentReceiptPdf(payment, byteArrayOutputStream);  // Pass the OutputStream to generate PDF in memory

                        // Convert the byte array output to a byte array (which we will send to the client)
                        byte[] pdfBytes = byteArrayOutputStream.toByteArray();

                        // Set the response headers to prompt the user to download the file
                        response.setContentType("application/pdf");
                        response.setHeader("Content-Disposition", "attachment; filename=payment_receipt_" + paymentId + ".pdf");
                        response.setContentLength(pdfBytes.length);

                        // Write the PDF bytes to the response OutputStream
                        try (OutputStream outStream = response.getOutputStream()) {
                            outStream.write(pdfBytes);
                            outStream.flush();  // Ensure the file is written completely
                        }

                    } catch (Exception e) {
                        e.printStackTrace();
                        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error generating PDF");
                    } finally {
                        // Close any resources
                        byteArrayOutputStream.close();
                    }
                } else {
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Payment ID is required");
                }
            }
        }catch (SQLException e){

        }
    }
}

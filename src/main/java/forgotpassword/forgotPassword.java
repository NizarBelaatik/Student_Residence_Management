package forgotpassword;


import dao.EmailVerificationDAO;
import dao.UserDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.*;
import java.sql.SQLException;
import java.sql.Timestamp;

import model.EmailVerification;
import utils.GenerateRandomString;
import service.EmailSender;

@WebServlet(name = "forgot-password", urlPatterns = {"/forgot-password"})
public class forgotPassword extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private EmailVerificationDAO emailVeriDAO = new EmailVerificationDAO();
    private UserDAO userDAO = new UserDAO();


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Forward the request to the actual JSP page
        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/common/forgotpassword/forgotpassword.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");

        // For demo, we'll assume the email exists in the system. In a real system, you'd check the DB.
        if (email == null || email.isEmpty()) {
            response.getWriter().write("Invalid email!");
            return;
        }

        // Generate a reset token (simple random string for demonstration)
        String resetToken = GenerateRandomString.generateToken(20);

        // Store the token with the email in memory (or store it in DB with expiration time)
        Timestamp createdAt = new Timestamp(System.currentTimeMillis());  // Current time as Timestamp
        // Calculate expires_at by adding 30 minutes to the current time
        long thirtyMinutesInMillis = 5 * 60 * 1000;  // 30 minutes in milliseconds
        Timestamp expiresAt = new Timestamp(createdAt.getTime() + thirtyMinutesInMillis);
        try{
            boolean user_check = userDAO.findUserByEmail(email);
            if (user_check){
                EmailVerification emailVeri = new EmailVerification(email,resetToken,expiresAt);
                try{
                    emailVeriDAO.addEmailVerification(emailVeri);


                }catch (SQLException e) {

                }
                // Send email with the reset link (in a real scenario, use a proper email service)

                String subject = "Password Reset Request";
                String messageText = "Click the link to reset your password: \n" +
                        "http://localhost:8080"+request.getContextPath() +"/reset-password?email=" + email + "&token=" + resetToken;
                EmailSender.sendEmail(email,subject,messageText);
            }
        } catch (SQLException e) {

        }



        // Redirect user to a confirmation page
        response.sendRedirect(request.getContextPath() + "/reset-link-sent");
    }




}

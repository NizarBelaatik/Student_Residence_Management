package forgotpassword;

import dao.EmailVerificationDAO;
import dao.UserDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.EmailVerification;
import model.User;
import service.EmailSender;
import utils.GenerateRandomString;

import java.io.IOException;
import java.sql.SQLException;
import java.sql.Timestamp;

@WebServlet(urlPatterns = {"/change-password"})
public class changePassword extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private EmailVerificationDAO emailVeriDAO = new EmailVerificationDAO();
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");
        String email = user.getEmail();

        boolean success = false;
        String message = "";

        // Validate email
        if (email == null || email.isEmpty()) {
            message = "Invalid email!";
        } else {
            // Generate a reset token (simple random string for demonstration)
            String resetToken = GenerateRandomString.generateToken(50);

            // Store the token with the email in memory (or store it in DB with expiration time)
            Timestamp createdAt = new Timestamp(System.currentTimeMillis());
            long thirtyMinutesInMillis = 5 * 60 * 1000; // 5 minutes in milliseconds
            Timestamp expiresAt = new Timestamp(createdAt.getTime() + thirtyMinutesInMillis);

            try {
                boolean userExists = userDAO.findUserByEmail(email);
                if (userExists) {
                    EmailVerification emailVeri = new EmailVerification(email, resetToken, expiresAt);
                    emailVeriDAO.addEmailVerification(emailVeri);

                    // Send email with the reset link
                    String subject = "Password Reset Request";
                    String messageText = "Click the link to reset your password: \n" +
                            "http://localhost:8080" + request.getContextPath() + "/reset-password?email=" + email + "&token=" + resetToken;
                    EmailSender.sendEmail(email, subject, messageText);

                    success = true;
                    message = "A reset link has been sent to your email.";
                }
            } catch (SQLException e) {
                success = false;
                message = "An error occurred. Please try again.";
            }
        }

        // Send the response as JSON
        String jsonResponse = "{\"messageType\":\"" + (success ? "success" : "error") + "\", \"message\":\"" + message + "\"}";
        response.setContentType("application/json");
        response.getWriter().write(jsonResponse);
    }
}

package forgotpassword;
import dao.EmailVerificationDAO;
import dao.ResidentDAO;
import dao.UserDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.EmailVerification;
import model.Resident;
import model.User;

import java.io.*;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.*;

import utils.PasswordHasher;
@WebServlet(name = "reset-password", urlPatterns = {"/reset-password"})
public class ResetPassword extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private EmailVerificationDAO emailVeriDAO = new EmailVerificationDAO();
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the email and token from the query parameters in the URL
        String email = request.getParameter("email");
        String token = request.getParameter("token");

        // Check if both parameters exist (optional but a good practice)
        if (email == null || token == null) {
            response.sendRedirect(request.getContextPath() + "/invalid-token");
            return;
        }

        // Forward the request to the actual JSP page to allow the user to reset their password
        request.setAttribute("email", email);
        request.setAttribute("token", token);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/common/forgotpassword/resetpassword.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the form parameters (email, token, and new password)
        String email = request.getParameter("email");
        String token = request.getParameter("token");
        String newPassword = request.getParameter("newPassword");
        // Validate input
        if (email == null || token == null || newPassword == null) {
            response.sendRedirect(request.getContextPath() + "/invalid-token");
            return;
        }

        String passwordHash = PasswordHasher.hashPassword(newPassword);

        try {
            // Retrieve the email verification data by the token
            EmailVerification tokenKeyDATA = emailVeriDAO.getEmailVerificationByToken(token);

            // Check if token exists and matches the email
            if (tokenKeyDATA == null) {
                // Invalid token, redirect to error page
                response.sendRedirect(request.getContextPath() + "/invalid-token");
                return;
            }

            // Check if token and email match
            if (token.equals(tokenKeyDATA.getVerificationToken()) && email.equals(tokenKeyDATA.getEmail())) {
                // Check if token has expired
                Timestamp expiresAt = tokenKeyDATA.getExpiresAt();
                if (expiresAt.after(new Timestamp(System.currentTimeMillis()))) {
                    try {
                        // Update the user's password in the database
                        userDAO.updatePassword(email, passwordHash);

                        // Verify the token (mark it as used)
                        emailVeriDAO.verifyEmail(email, token);

                        // Redirect to success page
                        response.sendRedirect(request.getContextPath() + "/password-reset-success");
                    } catch (SQLException e) {
                        // Handle SQL exception (e.g., failed to update the password)
                        e.printStackTrace();
                        response.sendRedirect(request.getContextPath() + "/error");
                    }
                } else {
                    // Token expired, redirect to an appropriate page
                    response.sendRedirect(request.getContextPath() + "/token-expired");
                }
            } else {
                // Token or email mismatch, redirect to error page
                response.sendRedirect(request.getContextPath() + "/invalid-token");
            }
        } catch (SQLException e) {
            // Handle any database exceptions
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/error");
        }
    }
}

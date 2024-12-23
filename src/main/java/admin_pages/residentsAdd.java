
package admin_pages;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.RequestDispatcher;

import java.sql.*;

import model.Resident;
import dao.ResidentDAO;

import model.User;
import dao.UserDAO;
import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import java.util.Properties;

import utils.PasswordHasher;
import utils.GenerateRandomString;
import utils.EmailSender;
//import static utils.EmailSender.sendEmail;
/**
 *
 * @author night
 */
@WebServlet(name = "residentsAdd", urlPatterns = {"/admin/residents/addResident"})
public class residentsAdd extends HttpServlet {
    private ResidentDAO residentDAO = new ResidentDAO();
    private UserDAO userDAO = new UserDAO();
    public residentsAdd(){
        super();
        }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Forward the request to the actual JSP page

        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/admin/residentsAdd.jsp");
        request.setAttribute("activePage", "residents");  // Set active page
        dispatcher.forward(request, response);
    }
    
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
                    // Set response type to JSON
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            
            String residentEmail = request.getParameter("inputemail");
            String residentFirstname = request.getParameter("inputfirstname");
            String residentLastname = request.getParameter("inputlastname");   
            String residentGender = request.getParameter("inputgender");
            String residentPhone = request.getParameter("inputphone");
            String residentAddress = request.getParameter("inputaddress");            
            String residentRoomId = request.getParameter("inputroomId");

  
            Resident ADD_Resident = new Resident( residentEmail, residentFirstname, residentLastname, residentGender, residentPhone,residentAddress,residentRoomId);

            boolean success = false;
            String message = "";
            try {
                String password= GenerateRandomString.generatePassword();
                String passwordHashed=PasswordHasher.hashPassword(password);
                User user=new User(residentEmail,passwordHashed,"resident");
                userDAO.addUser(user);
                // Add the room via DAO
                residentDAO.addResident(ADD_Resident);
                success = true;
                message = "Resident has been successfully added!";
                
                String subject = "Your Account Has Been Created";
                String emailBody = "Dear " + residentFirstname +" "+  residentLastname + ",\n\n"
                                    + "We are pleased to inform you that your account has been successfully created in our system.\n\n"
                                    + "Your login details are as follows:\n\n"
                                    + "- Email: " + residentEmail + "\n"
                                    + "- Password: " + password + "\n\n"
                                    + "Please keep these details secure and do not share them with others. You can now log in to your account at any time.\n\n"
                                    + "If you have any questions or need further assistance, feel free to reach out to us.\n\n"
                                    + "Thank you,\n"
                                    + "[...]";

                EmailSender.sendEmail(residentEmail, subject, emailBody);
                
                
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

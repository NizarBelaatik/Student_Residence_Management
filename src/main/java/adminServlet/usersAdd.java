package adminServlet;

import dao.RoomDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;


import jakarta.servlet.http.HttpSession;
import model.User;
import dao.UserDAO;
import service.EmailSender;
import utils.GenerateRandomString;
import utils.PasswordHasher;
import model.UserAdminTInfo;
import dao.UserAdminTInfoDAO;

import java.sql.*;


@WebServlet(name = "userAdd", urlPatterns = {"/admin/users/userAdd"})
//@WebServlet("/admin/rooms/add")
public class usersAdd extends HttpServlet {
    private UserDAO userDAO = new UserDAO();
    private UserAdminTInfoDAO useradmintinfoDAO = new UserAdminTInfoDAO();

    public usersAdd(){
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Forward the request to the actual JSP page
        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/admin/usersAdd.jsp");
        request.setAttribute("activePage", "users");  // Set active page
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Set response type to JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");


        HttpSession session = request.getSession(false);
        String csrfTokenFromSession = (String) session.getAttribute("csrfToken");
        String csrfTokenFromRequest = request.getHeader("X-CSRF-Token");
        if (csrfTokenFromRequest == null || !csrfTokenFromRequest.equals(csrfTokenFromSession)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "CSRF token validation failed");
            return;
        }


        String inputemail = request.getParameter("inputemail");
        String firstname = request.getParameter("firstname");
        String lastname = request.getParameter("lastname");
        String phone = request.getParameter("phone");

        String inputRole = request.getParameter("inputRole");


        String password= GenerateRandomString.generatePassword();
        String passwordHashed= PasswordHasher.hashPassword(password);

        User add_user = new User(inputemail,passwordHashed,inputRole);
        UserAdminTInfo add_user_info = new UserAdminTInfo(inputemail , firstname, lastname,phone);
        boolean success = false;
        String message = "";
        try {
            // Add the room via DAO
            userDAO.addUser(add_user);
            useradmintinfoDAO.addUserAdminTInfo(add_user_info);
            success = true;
            message = "User has been successfully added!";

            String subject = "Your Account Has Been Created";
            String emailBody = "We are pleased to inform you that your account has been successfully created in our system.\n\n"
                    + "Your login details are as follows:\n\n"
                    + "- Email: " + inputemail + "\n"
                    + "- Password: " + password + "\n\n"
                    + "Please keep these details secure and do not share them with others. You can now log in to your account at any time.\n\n"
                    + "If you have any questions or need further assistance, feel free to reach out to us.\n\n"
                    + "Thank you,\n"
                    + "[...]";

            EmailSender.sendEmail(inputemail, subject, emailBody);

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
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package common_pages;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import dao.EmailVerificationDAO;
import dao.UserDAO;
import dao.ResidentDAO;

import model.EmailVerification;
import model.User;
import model.Resident;

import java.sql.SQLException;
import java.sql.Timestamp;



@WebServlet(name = "regiserValidation", urlPatterns = {"/regiserV"})
public class regiserVerification extends HttpServlet {

    private EmailVerificationDAO emailVeriDAO = new EmailVerificationDAO();
    private UserDAO userDAO = new UserDAO();
    private ResidentDAO residentDAO = new ResidentDAO();

    public regiserVerification() {
        super();
        // TODO Auto-generated constructor stub
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Forward the request to the actual JSP page
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String firstname = request.getParameter("firstname");
        String lastname = request.getParameter("lastname");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String email = request.getParameter("email");
        String gender = request.getParameter("gender");
        String password = request.getParameter("password");
        String passwordHash="";
        String token = request.getParameter("tokenKey");
        
        boolean success = false;
        String message = "";
        
        try{
            EmailVerification tokenKeyDATA =  emailVeriDAO.getEmailVerificationByToken(token);
            if(token.contains(tokenKeyDATA.getVerificationToken()) && email.contains(tokenKeyDATA.getEmail())){
                
                Timestamp expiresAt = tokenKeyDATA.getExpiresAt();
                if(expiresAt.after(new Timestamp(System.currentTimeMillis()))){
                    User user = new User(email,passwordHash,"resident");
                    try{
                        userDAO.addUser(user);
                        
                        
                        Resident resident = new Resident( email, firstname, lastname, gender, phone,address,null);
                        residentDAO.addResident(resident);
                        success = true;
                    }catch(SQLException e){
                        success = false;

                    }
                }else{
                    //message = "This code doesn't match the one we send you.";
                    message = "This code doesn't match the one we send you. \n Whoops, you entered the wrong KEY too many times. If you still can't get your KEY, please contact the Administration.";
                }
                
            }
        }catch(SQLException e){

        }
        
        if (success) {
            String jsonResponse = "{\"messageType\":\"success\", \"message\":\"" + message + "\"}";
            response.getWriter().write(jsonResponse);
        } else {
            
            //message = "This code doesn't match the onne we send you.";
            String jsonResponse = "{\"messageType\":\"error\", \"message\":\"" + message + "\"}";
            response.getWriter().write(jsonResponse);
        }
    }
}

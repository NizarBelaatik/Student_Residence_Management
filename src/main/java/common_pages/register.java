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
import jakarta.servlet.RequestDispatcher;

import utils.GenerateRandomString;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import java.sql.Timestamp;

import dao.EmailVerificationDAO;
import dao.UserDAO;
import dao.ResidentDAO;

import model.EmailVerification;
import model.User;

import java.sql.SQLException;




@WebServlet(name = "register", urlPatterns = {"/register"})
public class register extends HttpServlet {
    private EmailVerificationDAO emailVeriDAO = new EmailVerificationDAO();
    private UserDAO userDAO = new UserDAO();
    
    
    public register() {
        super();
        // TODO Auto-generated constructor stub
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Forward the request to the actual JSP page
        response.sendRedirect(request.getContextPath()+"/error");
        //RequestDispatcher dispatcher = request.getRequestDispatcher("/views/common/register.jsp");
        //request.setAttribute("activePage", "dashboard");  // Set active page
        //dispatcher.forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Forward the request to the actual JSP page
        response.sendRedirect(request.getContextPath()+"/error");
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirm_password = request.getParameter("confirm_password");
        
       
        
        boolean success = false;
        String message = "";
        boolean usercheck = true;
        User userchecker = null;
        try{
            userchecker = userDAO.getUserByEmail(email);
            
        }catch(SQLException e){
            usercheck =false;
            userchecker = null;
        }
        
        if(!usercheck && userchecker == null){
            if(password.contains(confirm_password) ){
            
                String Verification_token=GenerateRandomString.generateToken(8);

                Timestamp createdAt = new Timestamp(System.currentTimeMillis());  // Current time as Timestamp

                // Calculate expires_at by adding 30 minutes to the current time
                long thirtyMinutesInMillis = 5 * 60 * 1000;  // 30 minutes in milliseconds
                Timestamp expiresAt = new Timestamp(createdAt.getTime() + thirtyMinutesInMillis);


                EmailVerification emailVeri = new EmailVerification(email,Verification_token,expiresAt);
                try{
                    emailVeriDAO.addEmailVerification(emailVeri);
                    
                    
                    success = true;
                }catch (SQLException e) {
                    success = false;
                    message = "Something went wrong. Please try again.";
                }
            
            }
        }else{
            message = "Email have already been used, please try another";
        }
        
        
        
        
        if (success) {
            String jsonResponse = "{\"messageType\":\"success\", \"message\":\"" + message + "\"}";
            
            response.getWriter().write(jsonResponse);
        } else {

            String jsonResponse = "{\"messageType\":\"error\", \"message\":\"" + message + "\"}";
            response.getWriter().write(jsonResponse);
        }
    }

}

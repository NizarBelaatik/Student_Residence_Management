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

import jakarta.servlet.http.HttpSession;
import jakarta.servlet.RequestDispatcher;

import java.sql.SQLException;

import dao.UserDAO;
import model.User;
/**
 *
 * @author night
 */
@WebServlet(name = "login", urlPatterns = {"/login"})
public class login extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/login.jsp");
        dispatcher.forward(request, response);
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        UserDAO userDAO = new UserDAO();
        try {
            User user = userDAO.loginUser(email, password);
            if (user != null && user.isActive()) {
                // User is authenticated, store user info in session
                HttpSession session = request.getSession();
                session.setAttribute("user", user);

                // Redirect to the user's dashboard or homepage
                if("admin".equals(user.getRole())){
                    response.sendRedirect(request.getContextPath()+"/admin");
                }else if("resident".equals(user.getRole())){
                    response.sendRedirect(request.getContextPath()+"/u");
                }
                
            } else {
                // Invalid login or inactive user
                request.setAttribute("error", "Invalid email or password.");
                RequestDispatcher dispatcher = request.getRequestDispatcher("/views/login.jsp");
                dispatcher.forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}

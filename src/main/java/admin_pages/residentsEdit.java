/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package admin_pages;

import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


import java.sql.*;


import model.Resident;
import dao.ResidentDAO;

/**
 *
 * @author night
 */
@WebServlet(name = "residentsEdit", urlPatterns = {"/admin/residents/editResident"})
public class residentsEdit extends HttpServlet {
    private ResidentDAO residentDAO = new ResidentDAO();

    public residentsEdit(){
        super();
        }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        Resident ReData ;
        try{
            ReData = residentDAO.getResidentByEmail(email);
            request.setAttribute("Res", ReData);
        }catch(SQLException e){
        }
        
        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/admin/residentsAdd.jsp");
        request.setAttribute("activePage", "residents");  // Set active page
        dispatcher.forward(request, response);
    }
    
    
}

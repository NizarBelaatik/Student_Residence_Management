/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package adminServlet;

import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


import java.sql.*;
import java.util.ArrayList;
import java.util.List;


import model.Resident;
import dao.ResidentDAO;

import model.Room;
import dao.RoomDAO;

/**
 *
 * @author night
 */
@WebServlet(name = "residentsEdit", urlPatterns = {"/admin/residents/editResident"})
public class residentsEdit extends HttpServlet {
    private ResidentDAO residentDAO = new ResidentDAO();
    private RoomDAO roomDAO = new RoomDAO();
    public residentsEdit(){
        super();
        }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        Resident ReData ;
        List<Room> roomList = new ArrayList<>();
        try{
            ReData = residentDAO.getResidentByEmail(email);
            request.setAttribute("Res", ReData);
            roomList = roomDAO.getAllRoomsAvailable();
            request.setAttribute("roomList", roomList);
        }catch(SQLException e){
        }
        
        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/admin/residentsEdit.jsp");
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
            String contractStartDate = request.getParameter("inputStartDate");
            String contractEndDate = request.getParameter("inputEndDate");

            Resident Edit_Resident = new Resident( residentEmail, residentFirstname, residentLastname, residentGender, residentPhone,residentAddress,residentRoomId,contractStartDate,contractEndDate);

            boolean success = false;
            String message = "";
            try {
                // Add the room via DAO
                residentDAO.updateResident(Edit_Resident);
                success = true;
                message = "Resident has been successfully Edited!";
            } catch (SQLException e) {
                // Handle SQL exceptions and set error message
                success = false;
                message = "Something went wrong. Please try again."+e;
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

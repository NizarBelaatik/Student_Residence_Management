/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package admin_pages;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import model.Room;
import dao.roomDAO;
import java.sql.SQLException;

/**
 *
 * @author night
 */
@WebServlet(name = "roomsDelete", urlPatterns = {"/admin/rooms/roomsDelete"})
public class roomsDelete extends HttpServlet {
    private roomDAO RoomDAO = new roomDAO();

    public roomsDelete(){
                super();
        }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException  {


        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String roomIdParam  = request.getParameter("roomId");

        boolean success = false;
        String message = "";
        try {
            // Add the room via DAO
            RoomDAO.deleteRoom(roomIdParam);
            success = true;
            message = "Room "+roomIdParam+" has been successfully Deleted!";
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

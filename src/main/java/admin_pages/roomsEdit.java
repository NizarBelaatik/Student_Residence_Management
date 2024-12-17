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




@WebServlet(name = "roomsEdit", urlPatterns = {"/roomsEdit"})
public class roomsEdit extends HttpServlet {
    private roomDAO ROOMDAO = new roomDAO();
    
    
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException  {
        try {
            String roomIdParam  = request.getParameter("roomId");

            // Check if the roomId exists and is not empty
            if (roomIdParam == null || roomIdParam.isEmpty()) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Room ID is missing.");
                return;
            }

            // Parse room ID to integer
            //String roomId = Integer.parseInt(roomIdParam);

            // Get the updated values from the form
            String roomSize = request.getParameter("inputSize");
            String roomName = request.getParameter("inputAmenities");
            String roomPriceS = request.getParameter("inputPrice");
            String roomState = request.getParameter("inputState");

            // Convert the room price string to a float
            float roomPrice = 0.0f;
            if (roomPriceS != null && !roomPriceS.isEmpty()) {
                try {
                    roomPrice = Float.parseFloat(roomPriceS);
                } catch (NumberFormatException e) {
                    // Handle invalid float conversion
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid price format.");
                    return;
                }
            }

            // Create an updated Room object
            Room updatedRoom = new Room(roomIdParam, roomSize, roomName, roomPrice, roomState);
            //Room updatedRoom = new Room(roomId, roomSize, roomName, roomPrice, roomState);

            // Handle SQLException here by declaring the exception to be thrown

            boolean updateSuccessful = ROOMDAO.updateRoom(updatedRoom); // Now it is correctly handled.

            if (updateSuccessful) {
                response.sendRedirect("/admin/rooms/list");
            } else {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to update room.");
            }
        } catch (SQLException e) {
            // Handle SQLException (e.g., Database issues)
            e.printStackTrace();  // Log the exception details for debugging
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error occurred while updating room.");
        }
    }
}
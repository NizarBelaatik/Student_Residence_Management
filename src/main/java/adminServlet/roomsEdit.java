/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package adminServlet;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


import jakarta.servlet.http.HttpSession;
import model.Room;
import dao.RoomDAO;
import jakarta.servlet.RequestDispatcher;
import java.sql.SQLException;


@WebServlet(name = "editRoom", urlPatterns = {"/admin/rooms/editRoom"})
public class roomsEdit extends HttpServlet {
    private dao.RoomDAO RoomDAO = new RoomDAO();

    public roomsEdit(){
                super();
        }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Forward the request to the actual JSP page
        String roomId = request.getParameter("roomId");
        Room roomData ;
        try{
            roomData = RoomDAO.getRoomById(roomId);
            request.setAttribute("room", roomData);
        }catch(SQLException e){
        }
        
        // Set the response content type
        response.setContentType("text/html");
        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/admin/roomsEdit.jsp");
        
        request.setAttribute("activePage", "managerooms");  // Set active page
        dispatcher.forward(request, response);
    }

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException  {

        HttpSession session = request.getSession(false);
        String csrfTokenFromSession = (String) session.getAttribute("csrfToken");
        String csrfTokenFromRequest = request.getHeader("X-CSRF-Token");
        if (csrfTokenFromRequest == null || !csrfTokenFromRequest.equals(csrfTokenFromSession)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "CSRF token validation failed");
            return;
        }

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String roomIdParam  = request.getParameter("inputRoomId");

        String roomSize = request.getParameter("inputSize");
        String roomName = request.getParameter("inputName");
        String equipment = request.getParameter("inputEquipment");
        String roomPriceS = request.getParameter("inputPrice");
        String roomState = request.getParameter("inputState");

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
        Room Edit_Room = new Room(roomIdParam, roomName,roomSize, equipment, roomPrice, roomState);

        boolean success = false;
        String message = "";
        try {
            // Add the room via DAO
            RoomDAO.updateRoom(Edit_Room);
            success = true;
            message = "Room "+roomIdParam+" has been successfully Updated!";
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
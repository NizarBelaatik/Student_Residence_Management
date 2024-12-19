
package admin_pages;

import dao.roomDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.RequestDispatcher;

import java.io.*;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import model.Room;
import dao.roomDAO;

/**
 *
 * @author night
 */
@WebServlet(name = "rooms", urlPatterns = {"/admin/rooms"})
public class rooms extends HttpServlet {
    private roomDAO RoomDAO = new roomDAO();
    public rooms(){
            super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Forward the request to the actual JSP page
        //roomDAO RoomDAO = new roomDAO();
        List<Room> roomList = new ArrayList<>();

        try{
            roomList = RoomDAO.getAllRooms();
        }catch(SQLException e){
            
        }
        
        
        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/admin/rooms.jsp");
        request.setAttribute("activePage", "managerooms");  // Set active page
        request.setAttribute("roomList", roomList);
        dispatcher.forward(request, response);
    }

}

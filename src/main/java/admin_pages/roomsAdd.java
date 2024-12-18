
package admin_pages;

import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.RequestDispatcher;

import model.Room;
import dao.roomDAO;
import static dao.roomDAO.getConnection;



import java.sql.*;
import java.util.ArrayList;
import java.util.List;


@WebServlet(name = "roomsAdd", urlPatterns = {"/admin/rooms/addRoom"})
//@WebServlet("/admin/rooms/add")
public class roomsAdd extends HttpServlet {
    private roomDAO RoomDAO = new roomDAO();

    public roomsAdd(){
                super();
        }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Forward the request to the actual JSP page
        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/admin/roomsAdd.jsp");
        request.setAttribute("activePage", "managerooms");  // Set active page
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        
            String roomSize = request.getParameter("inputSize");
            String roomName = request.getParameter("inputAmenities");
            String roomPriceS = request.getParameter("inputPrice");
            //float roomPrice = Float.parseFloat(request.getParameter("inputPrice"));
            String roomState = request.getParameter("inputState");

            String roomIdParam="34df456";

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
            Room ADD_Room = new Room(roomIdParam, roomSize, roomName, roomPrice, roomState);

            

            String sql = "INSERT INTO rooms (amenities, size, price, state, id) VALUES (?, ?, ?, ?)";
            String url = "jdbc:mysql://localhost:3306/test";
            String driver = "com.mysql.cj.jdbc.Driver";
            String user = "root"; // Change to your MySQL username
            String password = ""; // Change to your MySQL password
            try (Connection connection = DriverManager.getConnection(url, user, password);
                PreparedStatement preparedStatement = connection.prepareStatement(sql)) {   

                    preparedStatement.setString(1, ADD_Room.getAmenities());
                    preparedStatement.setString(2, ADD_Room.getSize());
                    preparedStatement.setFloat(3, ADD_Room.getPrice());
                    preparedStatement.setString(4, ADD_Room.getState());
                    int rowsAffected = preparedStatement.executeUpdate();

            }catch (Exception e) {
			System.err.print("error connection "+e);
            }
            
               

                   
        
        
    }


}

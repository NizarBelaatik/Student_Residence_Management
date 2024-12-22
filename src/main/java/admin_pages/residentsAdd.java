
package admin_pages;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.RequestDispatcher;

import java.sql.*;

import model.Resident;
import dao.ResidentDAO;

/**
 *
 * @author night
 */
@WebServlet(name = "residentsAdd", urlPatterns = {"/admin/residents/addResident"})
public class residentsAdd extends HttpServlet {
    private ResidentDAO residentDAO = new ResidentDAO();

    public residentsAdd(){
        super();
        }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Forward the request to the actual JSP page
        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/admin/residentsAdd.jsp");
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

  
            Resident ADD_Resident = new Resident( residentEmail, residentFirstname, residentLastname, residentGender, residentPhone,residentAddress,residentRoomId);

            boolean success = false;
            String message = "";
            try {
                // Add the room via DAO
                residentDAO.addResident(ADD_Resident);
                success = true;
                message = "Resident has been successfully added!";
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


package adminServlet;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.RequestDispatcher;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import model.Resident;
import dao.ResidentDAO;

/**
 *
 * @author night
 */
@WebServlet(name = "residents", urlPatterns = {"/admin/residents"})
public class residents extends HttpServlet {
    private ResidentDAO residentDAO = new ResidentDAO();
    public residents(){
            super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Forward the request to the actual JSP page
        //roomDAO RoomDAO = new roomDAO();
        List<Resident> residentList = new ArrayList<>();

        try{
            residentList = residentDAO.getAllResidents();
        }catch(SQLException e){
            
        }
        
        
        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/admin/residents.jsp");
        request.setAttribute("activePage", "residents");  // Set active page
        request.setAttribute("residentList", residentList);
        dispatcher.forward(request, response);
    }
    
}

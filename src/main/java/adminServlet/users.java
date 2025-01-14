package adminServlet;


import dao.UserAdminTInfoDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import dao.UserDAO;
import model.User;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "users", urlPatterns = {"/admin/users"})
public class users  extends HttpServlet {
    private UserDAO userDAO = new UserDAO();
    private UserAdminTInfoDAO useradmintinfoDAO = new UserAdminTInfoDAO();
    public users(){
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Forward the request to the actual JSP page
        //roomDAO RoomDAO = new roomDAO();

        List<User> usersList = new ArrayList<>();
        try{
            usersList = userDAO.getAdminTechUsersWithoutPW();
        }catch(SQLException e){

        }
        request.setAttribute("usersList", usersList);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/admin/users.jsp");
        request.setAttribute("activePage", "users");  // Set active page
        dispatcher.forward(request, response);
    }
}

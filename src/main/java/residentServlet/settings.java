package residentServlet;

import dao.NotificationDAO;
import dao.ResidentDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Notification;
import model.Resident;
import model.Room;
import model.User;
import utils.DateUtils;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;




@WebServlet( urlPatterns = {"/u/settings"})
public class settings  extends HttpServlet {
    private ResidentDAO residentDAO = new ResidentDAO();
    NotificationDAO notificationDAO = new NotificationDAO();

    public settings(){
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpSession session = req.getSession(false);
        User user = (User) session.getAttribute("user");
        String email= user.getEmail() ;

        Resident ReData ;
        List<Room> roomList = new ArrayList<>();
        try{
            ReData = residentDAO.getResidentByEmail(email);
            request.setAttribute("Res", ReData);

        }catch(SQLException e){
        }
        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/resident/settings.jsp");
        request.setAttribute("activePage", "settings");  // Set active page
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Set response type to JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        HttpServletRequest req = (HttpServletRequest) request;
        HttpSession session = req.getSession(false);
        User user = (User) session.getAttribute("user");
        String email= user.getEmail() ;

        String residentFirstname = request.getParameter("firstname");
        String residentLastname = request.getParameter("lastname");
        String residentGender = request.getParameter("gender");
        String residentPhone = request.getParameter("phone");
        String residentAddress = request.getParameter("address");



        boolean success = false;
        String message = "";
        try {

            residentDAO.editResident(email, residentFirstname, residentLastname, residentGender, residentPhone,residentAddress);

            success = true;
            message = "Profile has been successfully Edited!";
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

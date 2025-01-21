package residentServlet;

import dao.NotificationDAO;
import dao.ResidentDAO;
import dao.RoomDAO;
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

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import static utils.DateUtils.formatTimestampToDate;

@WebServlet( urlPatterns = {"/u/profile"})
public class profile  extends HttpServlet {
    private ResidentDAO residentDAO = new ResidentDAO();
    private RoomDAO roomDAO = new RoomDAO();
    private NotificationDAO notificationDAO = new NotificationDAO();

    public profile(){
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Forward the request to the actual JSP page
        //roomDAO RoomDAO = new roomDAO();


        HttpServletRequest req = (HttpServletRequest) request;
        HttpSession session = req.getSession(false);
        User user = (User) session.getAttribute("user");
        String email= user.getEmail() ;

        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/resident/profile.jsp");
        request.setAttribute("activePage", "profile");  // Set active page



        Resident resident ;
        Room room;

        try{
             resident = residentDAO.getResidentByEmail(email);
             room = roomDAO.getRoomById(resident.getRoomId());
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }



        request.setAttribute("email", email);
        request.setAttribute("user_since", formatTimestampToDate(user.getCreatedAt()));
        request.setAttribute("resident", resident);
        request.setAttribute("room", room);
        dispatcher.forward(request, response);
    }
}

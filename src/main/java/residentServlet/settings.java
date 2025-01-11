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
import model.User;

import java.io.IOException;
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

        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/resident/settings.jsp");
        request.setAttribute("activePage", "settings");  // Set active page
        dispatcher.forward(request, response);
    }
}

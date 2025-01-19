package techServlet;


import dao.UserAdminTInfoDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Room;
import model.User;
import model.UserAdminTInfo;

import java.io.IOException;
import java.sql.SQLException;

import static utils.DateUtils.formatTimestampToDate;

@WebServlet(urlPatterns = {"/t/profile"})
public class profile  extends HttpServlet {
    private UserAdminTInfoDAO userTechDAO= new UserAdminTInfoDAO();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Forward the request to the actual JSP page
        HttpServletRequest req = (HttpServletRequest) request;
        HttpSession session = req.getSession(false);
        User user = (User) session.getAttribute("user");
        String email= user.getEmail() ;

        UserAdminTInfo tech ;
        Room room;

        try{
            tech = userTechDAO.getUserAdminTInfoByEmail(email);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        request.setAttribute("user_since", formatTimestampToDate(user.getCreatedAt()));
        request.setAttribute("techD", tech);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/tech/profile.jsp");
        dispatcher.forward(request, response);
    }

}

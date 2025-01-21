package adminServlet;

import dao.UserAdminTInfoDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.*;

import java.io.IOException;
import java.sql.SQLException;




@WebServlet( urlPatterns = {"/admin/settings"})
public class settings  extends HttpServlet {
    private UserAdminTInfoDAO userTechDAO= new UserAdminTInfoDAO();


    public settings(){
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpSession session = req.getSession(false);
        User user = (User) session.getAttribute("user");
        String email= user.getEmail() ;


        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/admin/settings.jsp");
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


        String csrfTokenFromSession = (String) session.getAttribute("csrfToken");
        String csrfTokenFromRequest = request.getHeader("X-CSRF-Token");
        if (csrfTokenFromRequest == null || !csrfTokenFromRequest.equals(csrfTokenFromSession)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "CSRF token validation failed");
            return;
        }

        String residentFirstname = request.getParameter("firstname");
        String residentLastname = request.getParameter("lastname");
        String residentPhone = request.getParameter("phone");



        boolean success = false;
        String message = "";
        UserAdminTInfo userNewData = new UserAdminTInfo(email,residentFirstname,residentLastname,residentPhone);
        try {

            userTechDAO.updateUserAdminTInfo(userNewData);

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

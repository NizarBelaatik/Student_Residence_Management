package adminServlet;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import jakarta.servlet.http.HttpSession;
import model.User;
import dao.UserDAO;
import model.UserAdminTInfo;
import dao.UserAdminTInfoDAO;

import java.io.IOException;
import java.sql.SQLException;


@WebServlet(name = "editUser", urlPatterns = {"/admin/users/editUser"})
public class usersEdit extends HttpServlet {
    private UserDAO userDAO = new UserDAO();
    private UserAdminTInfoDAO useradmintinfoDAO = new UserAdminTInfoDAO();

    public usersEdit(){
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Forward the request to the actual JSP page




        String inputemail = request.getParameter("email");
        User userData ;
        UserAdminTInfo user_info;
        try{
            userData = userDAO.getUserByEmailWithoutPW(inputemail);
            user_info = useradmintinfoDAO.getUserAdminTInfoByEmail(inputemail);
            request.setAttribute("user_info", user_info);
            request.setAttribute("user", userData);
        }catch(SQLException e){
        }

        // Set the response content type
        response.setContentType("text/html");
        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/admin/usersEdit.jsp");

        request.setAttribute("activePage", "users");  // Set active page
        dispatcher.forward(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException  {


        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");



        String inputemail = request.getParameter("inputemail");
        String firstname = request.getParameter("firstname");
        String lastname = request.getParameter("lastname");
        String phone = request.getParameter("phone");


        String inputRole = request.getParameter("inputRole");
        String inputisactive = request.getParameter("inputisactive");

        User  user_data = new User(inputemail,null,inputRole);
        UserAdminTInfo add_user_info = new UserAdminTInfo(inputemail , firstname, lastname,phone);

        boolean isactive =false;
        if (inputisactive != null && inputisactive.equals("on")) {
            // Checkbox is checked
            isactive= true;
        }
        user_data.setActive(isactive);


        boolean success = false;
        String message = "";
        try {
            // Add the room via DAO
            userDAO.updateUser(user_data);
            useradmintinfoDAO.updateUserAdminTInfo(add_user_info);
            success = true;
            message = "User "+inputemail+" has been successfully Updated!";
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
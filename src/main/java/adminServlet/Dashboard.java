
package adminServlet;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.RequestDispatcher;

import jakarta.servlet.http.HttpSession;

import model.User;

/**
 *
 * @author night
 */
@WebServlet(name = "Dashboard", urlPatterns = {"/admin/dashboard"})
public class Dashboard extends HttpServlet {

    public Dashboard() {
        super();
        // TODO Auto-generated constructor stub
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
    
        if (session == null || session.getAttribute("user") == null) {  
            response.sendRedirect("login");
            return;
        }
        
        // Get the logged-in user from the session
        User user = (User) session.getAttribute("user");
        String role="admin";
        if(role.equals(user.getRole())){
            // Forward to the dashboard JSP with user and role info
            request.setAttribute("user", user);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/views/admin/dashboardAdmin.jsp");
            request.setAttribute("activePage", "dashboard");  // Set active page
            dispatcher.forward(request, response);
        }else{
            response.sendRedirect("error");
        }
        
    }
}


package admin_pages;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.RequestDispatcher;

/**
 *
 * @author night
 */
@WebServlet(name = "rooms", urlPatterns = {"/admin/rooms"})
public class rooms extends HttpServlet {
    public rooms(){
            super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Forward the request to the actual JSP page
        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/admin/managerooms.jsp");
        request.setAttribute("activePage", "managerooms");  // Set active page
        dispatcher.forward(request, response);
    }

}

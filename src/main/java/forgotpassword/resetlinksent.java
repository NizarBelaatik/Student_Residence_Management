package forgotpassword;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "reset-link-sent", urlPatterns = {"/reset-link-sent"})
public class resetlinksent  extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Forward the request to the actual JSP page
        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/common/forgotpassword/resetlinksent.jsp");
        dispatcher.forward(request, response);
    }
}

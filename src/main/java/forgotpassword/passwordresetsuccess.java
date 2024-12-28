package forgotpassword;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;


@WebServlet(name = "password-reset-success", urlPatterns = {"/password-reset-success"})
public class passwordresetsuccess  extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Forward the request to the actual JSP page
        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/common/forgotpassword/passwordresetsuccess.jsp");
        dispatcher.forward(request, response);
    }
}

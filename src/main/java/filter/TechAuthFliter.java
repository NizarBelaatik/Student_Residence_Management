
package filter;


import model.Resident;
import model.User;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import model.UserAdminTInfo;
import dao.UserAdminTInfoDAO;
@WebFilter("/t/*")  // Filter for URLs starting with /user/
public class TechAuthFliter implements Filter {
    private UserAdminTInfoDAO userATDAO = new UserAdminTInfoDAO();
    @Override
    public void init(FilterConfig fConfig) throws ServletException {
        // No initialization needed
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);

        // Check if the user is logged in
        if (session == null || session.getAttribute("user") == null) {
            res.sendRedirect(req.getContextPath() + "/login");  // Redirect to login page if not logged in
            return;
        }

        // Get the user object from the session
        User user = (User) session.getAttribute("user");

        // Check if the user has the required role (user in this case)
        if ("tech".equals(user.getRole())) {
            // User has the correct role, continue with the request

            try{
                UserAdminTInfo tech = userATDAO.getUserAdminTInfoByEmail(user.getEmail());

                session.setAttribute("tech", tech);
            }catch(SQLException e){
                e.printStackTrace();
            }
            chain.doFilter(request, response);
        } else {
            // User does not have the correct role, redirect to error page
            res.sendRedirect(req.getContextPath() + "/error");  // Redirect to error page
        }

    }

    @Override
    public void destroy() {
        // No cleanup needed
    }
}

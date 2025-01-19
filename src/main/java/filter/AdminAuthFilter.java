/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package filter;

import dao.UserAdminTInfoDAO;
import model.User;

import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;
import model.UserAdminTInfo;

import java.io.IOException;
import java.sql.SQLException;

/**
 *
 * @author night
 */
@WebFilter("/admin/*")
public class AdminAuthFilter implements Filter {
    private UserAdminTInfoDAO userATDAO = new UserAdminTInfoDAO();

    @Override
    public void init(FilterConfig fConfig) throws ServletException {
        // No initialization needed in this case
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
        
        // Check if the user has the required role (admin in this case)
        String role = "admin"; // For example, "admin" role check
        if (role.equals(user.getRole())) {
            try{
                UserAdminTInfo admin = userATDAO.getUserAdminTInfoByEmail(user.getEmail());

                session.setAttribute("admin", admin);
            }catch(SQLException e){
                e.printStackTrace();
            }

            // User has the right role, continue with the request
            chain.doFilter(request, response);
        } else {
            // User does not have the right role, redirect to error page
            res.sendRedirect(req.getContextPath() + "/error");  // Redirect to error page
        }
    }

    @Override
    public void destroy() {
        // No cleanup needed in this case
    }
}

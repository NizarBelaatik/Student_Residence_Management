/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package common_pages;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

/**
 *
 * @author night
 */
@WebServlet(name = "main", urlPatterns = {""})
public class main extends HttpServlet {

        public main() {
            super();
            // TODO Auto-generated constructor stub
        }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            // Forward the request to the actual JSP page
        try{
            HttpSession session = request.getSession(false);
            User user = (User) session.getAttribute("user");
            String email = user.getEmail();

            if (user != null && user.isActive() && email != null) {

                // Redirect to the user's dashboard or homepage
                if("admin".equals(user.getRole())){
                    response.sendRedirect(request.getContextPath()+"/admin");
                }else if("resident".equals(user.getRole())){
                    response.sendRedirect(request.getContextPath()+"/u");
                }else if("tech".equals(user.getRole())){
                    response.sendRedirect(request.getContextPath()+"/t");
                }

            }else {
                response.sendRedirect(request.getContextPath() + "/login");
            }
        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + "/login");
        }


    }

}

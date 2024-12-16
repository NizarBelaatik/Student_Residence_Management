/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package common_pages;

import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author night
 */
@WebServlet(name = "dashboard_common", urlPatterns = {"/dashboard_common"})
public class dashboard_common extends HttpServlet {

        public dashboard_common() {
            super();
            // TODO Auto-generated constructor stub
        }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            // Forward the request to the actual JSP page
            RequestDispatcher dispatcher = request.getRequestDispatcher("/views/common/dashboard.jsp");
            request.setAttribute("activePage", "dashboard");  // Set active page
            dispatcher.forward(request, response);
        }

}

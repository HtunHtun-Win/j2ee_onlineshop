package com.mub.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

import com.mub.models.UserModel;
import com.mub.repo.UserRepo;

/**
 * Servlet implementation class UserController
 */
@WebServlet("/UserController")
public class UserController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserController() {
        super();
        // TODO Auto-generated constructor stub
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	HttpSession session = request.getSession();
        List<UserModel> users = new UserRepo().getAllUsers();
        session.setAttribute("users", users);
        response.sendRedirect("/PopWare/pages/user.jsp");
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 String action = request.getParameter("action");
		    int id = request.getParameter("id") != null ? Integer.parseInt(request.getParameter("id")) : 0;

		    UserRepo repo = new UserRepo();
		    String role = request.getParameter("role");

		    switch (action) {
		    	case "register":
		    		repo.insert(new UserModel(0,
			                request.getParameter("name"),
			                request.getParameter("phone"),
			                request.getParameter("address"),
			                request.getParameter("email"),
			                role!=null ? role : "customer"
			        			),
			        		request.getParameter("password"));
		    			response.sendRedirect("/PopWare/pages/login.jsp");
			            break;
		        case "add":
		        	repo.insert(new UserModel(0,
		                request.getParameter("name"),
		                request.getParameter("phone"),
		                request.getParameter("address"),
		                request.getParameter("email"),
		                role!=null ? role : "customer"
		        			),
		        		request.getParameter("password"));
		        	response.sendRedirect("/PopWare/UserController");
		            break;
		        case "edit":
		        	repo.update(new UserModel(id,
		                request.getParameter("name"),
		                request.getParameter("phone"),
		                request.getParameter("address"),
		                request.getParameter("email"),
		                request.getParameter("role")),
		        		request.getParameter("password"));
		        	response.sendRedirect("/PopWare/UserController");
		            break;
		        case "delete":
		        	repo.delete(id);
		        	response.sendRedirect("/PopWare/UserController");
		            break;
		    }
	}

}

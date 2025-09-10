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
@WebServlet("/ProfileController")
public class ProfileController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ProfileController() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.sendRedirect("/PopWare/pages/profile.jsp");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int id = request.getParameter("id") != null ? Integer.parseInt(request.getParameter("id")) : 0;

		UserRepo repo = new UserRepo();

		repo.profileUpdate(
				new UserModel(id, request.getParameter("name"), request.getParameter("phone"),
						request.getParameter("address"), request.getParameter("email"),null),
				request.getParameter("password"));
		UserModel user = repo.getUserById(id);
		if (user != null) {
			HttpSession session = request.getSession();
			session.setAttribute("token", user);
		}

		response.sendRedirect("/PopWare/pages/profile.jsp");
	}

}

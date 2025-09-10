package com.mub.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.mub.models.UserModel;
import com.mub.utils.DBHelper;
import com.mub.utils.PassHash;

/**
 * Servlet implementation class UserController
 */
@WebServlet("/LoginController")
public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public LoginController() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		UserModel user = (UserModel) session.getAttribute("token");
		if (user == null) {
			user = new UserModel(0, "Guest", "", "", "", "");
			session.setAttribute("token", user);
			response.sendRedirect("/PopWare/HomeController");
		} else {
			response.sendRedirect("/PopWare/HomeController");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String input_userid = request.getParameter("username");
		String input_password = request.getParameter("password");
		String sql = "SELECT * FROM users where email=? AND password=? LIMIT 1";
		Connection con = DBHelper.getInstance().getConn();
		PreparedStatement stmt = null;
		ResultSet set = null;
		UserModel user = null;
		try {
			stmt = con.prepareStatement(sql);
			stmt.setString(1, input_userid);
			stmt.setString(2, PassHash.getMD5Hash(input_password));
			set = stmt.executeQuery();
			while (set.next()) {
				user = new UserModel(set.getInt("id"), set.getString("name"), set.getString("phone"),
						set.getString("address"), set.getString("email"), set.getString("role"));
			}
			if (user != null) {
				HttpSession session = request.getSession();
				session.setAttribute("token", user);
				response.sendRedirect("/PopWare/HomeController");
			} else {
				response.sendRedirect("/PopWare/pages/login.jsp?msg=Invalid%20credentials");
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
	}

}

package com.mub.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.mub.models.ProductModel;
import com.mub.models.UserModel;
import com.mub.repo.ProductRepo;
import com.mub.utils.AuthUtil;
import com.mub.utils.DBHelper;

@WebServlet("/ProductDetailController")
public class ProductDetailController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public ProductDetailController() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String pid = request.getParameter("pid");
		ProductModel product = null;
		AuthUtil auth = new AuthUtil();
		ProductRepo productRepo = new ProductRepo();
		try {
			if (auth.isUserLoggedIn(request)) {
				product = productRepo.getById(Integer.parseInt(pid));
				if(product!=null) {
					HttpSession session = request.getSession();
					session.setAttribute("product", product);
					response.sendRedirect("/PopWare/pages/pdetail.jsp");
				}else {
					response.sendRedirect("/PopWare");
				}
			} else {
				response.sendRedirect("/PopWare/LoginController");
			}
		} catch (Exception e) {
			e.printStackTrace();
			response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
	}

}

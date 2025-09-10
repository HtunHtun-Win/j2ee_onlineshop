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

import com.mub.models.CategoryModel;
import com.mub.models.ProductModel;
import com.mub.repo.CategoryRepo;
import com.mub.repo.ProductRepo;
import com.mub.utils.AuthUtil;
import com.mub.utils.DBHelper;

@WebServlet("/HomeController")
public class HomeController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public HomeController() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		List<ProductModel> products = new ArrayList<ProductModel>();
		List<ProductModel> popular_items = new ArrayList<ProductModel>();
		List<CategoryModel> categories = new ArrayList<CategoryModel>();
		AuthUtil auth = new AuthUtil();
		HttpSession session = request.getSession();
		ProductRepo productRepo = new ProductRepo();
		CategoryRepo categoryRepo = new CategoryRepo();
		String cat_id = request.getParameter("category");
		String keyword = request.getParameter("search");
		try {
			if (auth.isUserLoggedIn(request)) {
				if(keyword!=null) {
					if(keyword.length()>0) {
						products = productRepo.getAllProductByKeyword(keyword);
						session.setAttribute("keyword", keyword);
						session.removeAttribute("selected_category");
					}else {
						products = productRepo.getAllProduct();
						session.removeAttribute("keyword");
						session.removeAttribute("selected_category");
					}
				}else if(cat_id==null) {
					products = productRepo.getAllProduct();
					session.removeAttribute("keyword");
					session.removeAttribute("selected_category");
				}else {
					products = productRepo.getAllProductByCategory(Integer.parseInt(cat_id));
					session.removeAttribute("keyword");
					session.setAttribute("selected_category", categoryRepo.getById(Integer.parseInt(cat_id)));
				}
				categories = categoryRepo.getAllCategory();
				popular_items = productRepo.getPopularProduct();
				session.setAttribute("products", products);
				session.setAttribute("pop_items", popular_items);
				session.setAttribute("categories", categories);
				response.sendRedirect("/PopWare/pages/home.jsp");
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

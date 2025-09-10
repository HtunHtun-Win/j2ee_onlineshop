package com.mub.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import com.mub.models.CategoryModel;
import com.mub.repo.CategoryRepo;
import com.mub.utils.AuthUtil;

/**
 * Servlet implementation class CategoryController
 */
@WebServlet("/CategoryController")
public class CategoryController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public CategoryController() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		List<CategoryModel> categories = new ArrayList<CategoryModel>();
		AuthUtil auth = new AuthUtil();
		HttpSession session = request.getSession();
		CategoryRepo categoryRepo = new CategoryRepo();
		try {
			if (auth.isUserLoggedIn(request)) {
				categories = categoryRepo.getAllCategory();
				session.setAttribute("categories", categories);
				response.sendRedirect("/PopWare/pages/category.jsp");
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
		AuthUtil auth = new AuthUtil();
		List<CategoryModel> categories = new ArrayList<CategoryModel>();
		CategoryRepo categoryRepo = new CategoryRepo();
		String catId = request.getParameter("id");
		String catName = request.getParameter("name");
		String action = request.getParameter("action");
        String idStr = request.getParameter("id");
		HttpSession session = request.getSession();
		try {
			if (auth.isUserLoggedIn(request)) {
				if ("delete".equals(action) && idStr != null) {
	                int id = Integer.parseInt(idStr);
	                categoryRepo.deleteCategory(id);
	            }else if(catId==null) {
					categoryRepo.insertCategory(catName);
				}else {
					categoryRepo.updateCategory(Integer.parseInt(catId), catName);
				}
				categories = categoryRepo.getAllCategory();
				session.setAttribute("categories", categories);
				response.sendRedirect("/PopWare/pages/category.jsp");
			} else {
				response.sendRedirect("/PopWare/LoginController");
			}
		} catch (Exception e) {
			e.printStackTrace();
			response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error");
		}
	}

}

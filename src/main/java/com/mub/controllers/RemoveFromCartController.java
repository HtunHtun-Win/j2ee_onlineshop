package com.mub.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

import com.mub.models.CartItem;

/**
 * Servlet implementation class RemoveFromCartController
 */
@WebServlet("/RemoveFromCart")
public class RemoveFromCartController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public RemoveFromCartController() {
        super();
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int productId = Integer.parseInt(request.getParameter("productId"));
		HttpSession session = request.getSession();
		List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");

		if (cart != null) {
			cart.removeIf(item -> item.productId == productId);
			session.setAttribute("cart", cart);
		}
		response.sendRedirect("/PopWare/pages/cart.jsp");
	}

}

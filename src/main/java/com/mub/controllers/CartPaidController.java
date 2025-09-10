package com.mub.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import com.mub.models.CartItem;
import com.mub.models.ProductModel;
import com.mub.models.UserModel;
import com.mub.repo.OrderRepo;
import com.mub.repo.ProductRepo;
import com.mub.socket.OrderWebSocket;

/**
 * Servlet implementation class CartPaidController
 */
@WebServlet("/CartPaidController")
public class CartPaidController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public CartPaidController() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		UserModel user = (UserModel) session.getAttribute("token");
		List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
		String address = request.getParameter("address");

		if (user == null || cart == null || cart.isEmpty()) {
			response.sendRedirect("/PopWare/pages/cart.jsp");
			return;
		}

		double total = 0;
		for (CartItem item : cart) {
			total += item.price * item.quantity;
		}

		double discount = 0;
		double finalTotal = total - discount;
		String orderNo = "ORD" + System.currentTimeMillis();

		OrderRepo orderRepo = new OrderRepo();
		ProductRepo productRepo = new ProductRepo();
		orderRepo.insertOrder(orderNo, user.id, total, discount, finalTotal, user.address);
		for (CartItem item : cart) {
			orderRepo.insertOrderDetail(orderNo, item.productId, item.quantity, item.price);
			productRepo.changeQty(item.productId, -item.quantity);
		}
		// Broadcast to WebSocket clients
		String now = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
		String jsonMessage = "{"
		        + "\"type\": \"new_order\","
		        + "\"orderNo\": \"" + orderNo + "\","
		        + "\"userName\": \"" + user.name + "\","
		        + "\"total\": \"" + total + "\","
		        + "\"address\": \"" + user.address + "\","
		        + "\"status\": \"Pending\","
		        + "\"date\": \"" + now + "\""
		        + "}";
		OrderWebSocket.sendUpdate(jsonMessage);
		session.removeAttribute("cart"); // clear cart
		response.sendRedirect("/PopWare/HomeController");
	}

}

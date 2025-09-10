package com.mub.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import com.mub.repo.OrderRepo;
import com.mub.repo.ProductRepo;
import com.mub.socket.OrderWebSocket;

/**
 * Servlet implementation class DeleteOrderController
 */
@WebServlet("/DeleteOrderController")
public class DeleteOrderController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public DeleteOrderController() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String orderNo = request.getParameter("orderNo");

		if (orderNo != null && !orderNo.isEmpty()) {
			OrderRepo repo = new OrderRepo();
			HttpSession session = request.getSession();
			boolean deleted = repo.deleteOrder(orderNo);
			if (deleted) {
				ProductRepo productRepo = new ProductRepo();
				session.setAttribute("products", productRepo.getAllProduct());
				session.setAttribute("pop_items", productRepo.getPopularProduct());
				String jsonMessage = "{"
					    + "\"type\": \"del_order\","
					    + "\"orderNo\": \"" + orderNo + "\""
					    + "}";
				OrderWebSocket.sendUpdate(jsonMessage);
				response.sendRedirect("/PopWare/pages/user_order_list.jsp?msg=deleted");
			} else {
				response.sendRedirect("/PopWare/pages/user_order_list.jsp?msg=error");
			}
		} else {
			response.sendRedirect("/PopWare/pages/user_order_list.jsp?msg=invalid");
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	}

}

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
 * Servlet implementation class OrderConfirmController
 */
@WebServlet("/OrderConfirmController")
public class OrderConfirmController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public OrderConfirmController() {
        super();
        // TODO Auto-generated constructor stub
    }
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String orderNo = request.getParameter("orderNo");
		String action = request.getParameter("action");
		OrderRepo repo = new OrderRepo();
		if(action.equals("confirm")) {
			if(orderNo!=null) {
				repo.orderConfirm(orderNo,"confirm");
			}
		}else {
			if(orderNo!=null) {
				repo.restoreOrderItems(orderNo);
				repo.orderConfirm(orderNo,"cancel");
				HttpSession session = request.getSession();
				ProductRepo productRepo = new ProductRepo();
				session.setAttribute("products", productRepo.getAllProduct());
				session.setAttribute("pop_items", productRepo.getPopularProduct());
			}
		}
		String jsonMessage = "{"
			    + "\"type\": \"con_order\","
			    + "\"orderNo\": \"" + orderNo + "\""
			    + "}";
		OrderWebSocket.sendUpdate(jsonMessage);
		response.sendRedirect("/PopWare/pages/user_order_list.jsp");
	}

}

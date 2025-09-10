package com.mub.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

import com.mub.models.MessageModel;
import com.mub.repo.MessageRepo;

/**
 * Servlet implementation class FeedbackController
 */
@WebServlet("/FeedbackController")
public class FeedbackController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public FeedbackController() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String filterDate = request.getParameter("filterDate");
		MessageRepo repo = new MessageRepo();
		List<MessageModel> messages;

		if (filterDate != null && !filterDate.isEmpty()) {
			messages = repo.getMessagesByDate(filterDate);
		} else {
			messages = repo.getAllMessages();
		}

		HttpSession session = request.getSession();
		session.setAttribute("messages", messages);
		session.setAttribute("selectedDate", filterDate);
		response.sendRedirect("/PopWare/pages/user_feedback.jsp");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String filterDate = request.getParameter("filterDate");
		MessageRepo repo = new MessageRepo();
		List<MessageModel> messages;

		if (filterDate != null && !filterDate.isEmpty()) {
			messages = repo.getMessagesByDate(filterDate);
		} else {
			messages = repo.getAllMessages();
		}

		HttpSession session = request.getSession();
		session.setAttribute("messages", messages);
		session.setAttribute("selectedDate", filterDate);
		response.sendRedirect("/PopWare/pages/user_feedback.jsp");	
	}

}

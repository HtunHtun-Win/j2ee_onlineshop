package com.mub.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.rmi.server.UID;

import com.mub.models.MessageModel;
import com.mub.repo.MessageRepo;

/**
 * Servlet implementation class SendController
 */
@WebServlet("/SendController")
public class SendController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
    public SendController() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String uid = request.getParameter("uid");
		String title = request.getParameter("title");
        String message = request.getParameter("message");
        if (title != null && message != null) {
            MessageModel msg = new MessageModel(title, message);
            MessageRepo repo = new MessageRepo();
            repo.insertMessage(msg,Integer.parseInt(uid));
            response.sendRedirect("/PopWare/pages/feedback.jsp");
        }
	}

}

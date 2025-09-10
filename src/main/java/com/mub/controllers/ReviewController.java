package com.mub.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;

import com.mub.models.ReviewModel;
import com.mub.models.UserModel;
import com.mub.repo.ReviewRepo;
import com.mub.utils.DBHelper;

/**
 * Servlet implementation class ReviewController
 */
@WebServlet("/ReviewController")
public class ReviewController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReviewController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		int productId = Integer.parseInt(req.getParameter("product_id"));
        int rating = Integer.parseInt(req.getParameter("rating"));
        String comment = req.getParameter("comment");

        HttpSession session = req.getSession();
        UserModel user = (UserModel) session.getAttribute("token");

        try{
        	Connection con = DBHelper.getInstance().getConn();
            ReviewRepo repo = new ReviewRepo(con);
            ReviewModel review = new ReviewModel();
            review.productId = productId;
            review.userId = user.id;
            review.rating = rating;
            review.comment = comment;
            repo.addReview(review);
        } catch (Exception e) {
            e.printStackTrace();
        }
        resp.sendRedirect("/PopWare/pages/pdetail.jsp");
	}

}

package com.mub.repo;

import com.mub.models.ReviewModel;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ReviewRepo {
    private Connection con;

    public ReviewRepo(Connection con) {
        this.con = con;
    }

    public void addReview(ReviewModel review) throws SQLException {
        String sql = "INSERT INTO reviews (product_id, user_id, rating, comment) VALUES (?, ?, ?, ?)";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setInt(1, review.productId);
        ps.setInt(2, review.userId);
        ps.setInt(3, review.rating);
        ps.setString(4, review.comment);
        ps.executeUpdate();
    }

    public List<ReviewModel> getReviewsByProduct(int productId) throws SQLException {
        List<ReviewModel> list = new ArrayList<>();
        String sql = "SELECT r.*, u.name AS user_name FROM reviews r JOIN users u ON r.user_id = u.id WHERE r.product_id=? ORDER BY r.created_at DESC";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setInt(1, productId);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            list.add(new ReviewModel(
                rs.getInt("id"),
                rs.getInt("product_id"),
                rs.getInt("user_id"),
                rs.getInt("rating"),
                rs.getString("comment"),
                rs.getString("created_at"),
                rs.getString("user_name")
            ));
        }
        return list;
    }
}

package com.mub.repo;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import com.mub.models.MessageModel;
import com.mub.utils.DBHelper;

public class MessageRepo {

	public void insertMessage(MessageModel msg, int uid) {
		try {
			Connection conn = DBHelper.getInstance().getConn();
			String sql = "INSERT INTO messages (user_id,title, message) VALUES (?, ?, ?)";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, uid);
			stmt.setString(2, msg.title);
			stmt.setString(3, msg.message);
			stmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	 public List<MessageModel> getMessagesByDate(String date) {
	        List<MessageModel> list = new ArrayList<>();
//	        String sql = "SELECT * FROM messages WHERE DATE(created_at) = ? ORDER BY created_at DESC";
	        String sql = "SELECT m.*, u.name AS user_name " +
	                 "FROM messages m " +
	                 "LEFT JOIN users u ON m.user_id = u.id " +
	                 "WHERE DATE(m.created_at) = ? " +
	                 "ORDER BY m.created_at DESC";
	        

	        try{
	        	Connection conn = DBHelper.getInstance().getConn();
	        	PreparedStatement stmt = conn.prepareStatement(sql);
	            stmt.setString(1, date);
	            ResultSet rs = stmt.executeQuery();

	            while (rs.next()) {
	                list.add(new MessageModel(
	                    rs.getInt("id"),
	                    rs.getString("title"),
	                    rs.getString("message"),
	                    rs.getTimestamp("created_at"),
	                    rs.getString("user_name")
	                ));
	            }

	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	        return list;
	    }

	public List<MessageModel> getAllMessages() {
		List<MessageModel> list = new ArrayList<>();
		try {
			Connection conn = DBHelper.getInstance().getConn();
//			String sql = "SELECT * FROM messages ORDER BY created_at DESC";
			String sql = "SELECT m.*, u.name AS user_name " +
	                 "FROM messages m " +
	                 "LEFT JOIN users u ON m.user_id = u.id " +
	                 "ORDER BY m.created_at DESC";
			
			PreparedStatement stmt = conn.prepareStatement(sql);
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				list.add(new MessageModel(rs.getInt("id"), rs.getString("title"), rs.getString("message"),
						rs.getTimestamp("created_at"),rs.getString("user_name")));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
}

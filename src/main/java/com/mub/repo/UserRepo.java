package com.mub.repo;

import com.mub.models.UserModel;
import com.mub.utils.DBHelper;
import com.mub.utils.PassHash;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserRepo {
	
	public UserModel getUserById(int id) {
		String sql = "SELECT * FROM users WHERE isdeleted=0 AND id=? ";
		PreparedStatement stmt = null;
		ResultSet set = null;
		UserModel user = null;
		try {
			Connection con = DBHelper.getInstance().getConn();
			stmt = con.prepareStatement(sql);
			stmt.setInt(1, id);
			set = stmt.executeQuery();
			while (set.next()) {
				user = new UserModel(set.getInt("id"), set.getString("name"), set.getString("phone"),
						set.getString("address"), set.getString("email"), set.getString("role"));
			}
		} catch (Exception e) {
		}
		return user;
	}
	
	public List<UserModel> getAllUsers() {
		String sql = "SELECT * FROM users WHERE isdeleted=0";
		List<UserModel> users = new ArrayList<UserModel>();
		try {
			Connection con = DBHelper.getInstance().getConn();
			PreparedStatement stmt = con.prepareStatement(sql);
			ResultSet set = stmt.executeQuery();
			while (set.next()) {
				users.add(new UserModel(set.getInt("id"), set.getString("name"),set.getString("phone"),set.getString("address"),set.getString("email"),set.getString("role")));
			}
		} catch (Exception e) {
		}
		return users;
	}
	
	public void insert(UserModel u,String pass) {
	    String sql = "INSERT INTO users (name, phone, address, email, password, role) VALUES (?, ?, ?, ?, ?, ?)";
	    try {
	    	Connection con = DBHelper.getInstance().getConn();
	    	PreparedStatement stmt = con.prepareStatement(sql);
	        stmt.setString(1, u.name);
	        stmt.setString(2, u.phone);
	        stmt.setString(3, u.address);
	        stmt.setString(4, u.email);
	        stmt.setString(5, PassHash.getMD5Hash(pass));
	        stmt.setString(6, u.role);
	        stmt.executeUpdate();
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	}

	public void update(UserModel u,String pass) {
		String sql="";
	    try{
	    	Connection con = DBHelper.getInstance().getConn();
	    	if(pass.length()<4) {
				sql = "UPDATE users SET name=?, phone=?, address=?, email=?, role=? WHERE id=?";
				PreparedStatement stmt = con.prepareStatement(sql);
		        stmt.setString(1, u.name);
		        stmt.setString(2, u.phone);
		        stmt.setString(3, u.address);
		        stmt.setString(4, u.email);
		        stmt.setString(5, u.role);
		        stmt.setInt(6, u.id);
		        stmt.executeUpdate();
			}else{
				sql = "UPDATE users SET name=?, phone=?, address=?, email=?, password=?, role=? WHERE id=?";
				PreparedStatement stmt = con.prepareStatement(sql);
		        stmt.setString(1, u.name);
		        stmt.setString(2, u.phone);
		        stmt.setString(3, u.address);
		        stmt.setString(4, u.email);
		        stmt.setString(5, PassHash.getMD5Hash(pass));
		        stmt.setString(6, u.role);
		        stmt.setInt(7, u.id);
		        stmt.executeUpdate();
			}
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	}
	
	public void profileUpdate(UserModel u,String pass) {
		String sql="";
	    try{
	    	Connection con = DBHelper.getInstance().getConn();
	    	if(pass.length()<4) {
				sql = "UPDATE users SET name=?, phone=?, address=?, email=? WHERE id=?";
				PreparedStatement stmt = con.prepareStatement(sql);
		        stmt.setString(1, u.name);
		        stmt.setString(2, u.phone);
		        stmt.setString(3, u.address);
		        stmt.setString(4, u.email);
		        stmt.setInt(5, u.id);
		        stmt.executeUpdate();
			}else{
				sql = "UPDATE users SET name=?, phone=?, address=?, email=?, password=? WHERE id=?";
				PreparedStatement stmt = con.prepareStatement(sql);
		        stmt.setString(1, u.name);
		        stmt.setString(2, u.phone);
		        stmt.setString(3, u.address);
		        stmt.setString(4, u.email);
		        stmt.setString(5, pass);
		        stmt.setInt(6, u.id);
		        stmt.executeUpdate();
			}
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	}

	public void delete(int id) {
	    String sql = "UPDATE users SET isdeleted=1 WHERE id=?";
	    try {
	    	Connection con = DBHelper.getInstance().getConn();
	    	PreparedStatement stmt = con.prepareStatement(sql);
	        stmt.setInt(1, id);
	        stmt.executeUpdate();
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	}
}


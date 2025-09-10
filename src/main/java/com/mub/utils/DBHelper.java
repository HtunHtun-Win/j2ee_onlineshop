package com.mub.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class DBHelper {
	private static final String DB_DRIVER = "com.mysql.cj.jdbc.Driver";
	private static final String DB_URL = "jdbc:mysql://localhost:3306/ecommercial_sys";
	private static final String DB_USER = "root";
	private static final String DB_PASS = "cyberlantern";
	
	private static Connection con = null;
	private static DBHelper instance = null;
	
	private DBHelper() {
		try {
			Class.forName(DB_DRIVER);
			con = DriverManager.getConnection(DB_URL,DB_USER,DB_PASS);
		} catch (Exception e) {
			System.out.println(e);
		}
	}
	
	public static DBHelper getInstance() {
		if (instance == null) {
			instance = new DBHelper();
		}
		return instance;
	}
	
	public static Connection getConn() {
		return con;
	}
	
	public static void closeConn(Connection con,PreparedStatement stmt,ResultSet set) {
		try {
			if(con!=null) con.close();
			if(stmt!=null) stmt.close();
			if(set!=null) set.close();
		} catch (Exception e) {
			System.out.println(e);
		}
	}
}

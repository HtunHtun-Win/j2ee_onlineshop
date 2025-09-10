package com.mub.repo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.mub.models.CategoryModel;
import com.mub.models.ProductModel;
import com.mub.utils.DBHelper;

public class CategoryRepo {

	public List<CategoryModel> getAllCategory() {
		String sql = "SELECT * FROM categories WHERE isdeleted=0";
		List<CategoryModel> categories = new ArrayList<CategoryModel>();
		try {
			Connection con = DBHelper.getInstance().getConn();
			PreparedStatement stmt = con.prepareStatement(sql);
			ResultSet set = stmt.executeQuery();
			while (set.next()) {
				categories.add(new CategoryModel(set.getInt("id"), set.getString("name")));
			}
		} catch (Exception e) {
		}
		return categories;
	}

	public CategoryModel getById(int cat_id) {
		String sql = "SELECT * FROM categories WHERE id=" + cat_id;
		CategoryModel category = null;
		try {
			Connection con = DBHelper.getInstance().getConn();
			PreparedStatement stmt = con.prepareStatement(sql);
			ResultSet set = stmt.executeQuery();
			while (set.next()) {
				category = new CategoryModel(set.getInt("id"), set.getString("name"));
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		return category;
	}

	public boolean insertCategory(String name) {
		boolean flag = false;
		String sql = String.format("INSERT INTO categories(name) values('%s')", name);
		try {
			Connection con = DBHelper.getInstance().getConn();
			PreparedStatement stmt = con.prepareStatement(sql);
			int result = stmt.executeUpdate();
			if (result == 1) {
				flag = true;
			}
		} catch (Exception e) {
		}
		return flag;
	}
	
	public boolean updateCategory(int cat_id,String name) {
		boolean flag = false;
		String sql = String.format("UPDATE categories SET name='%s' WHERE id=%d", name,cat_id);
		try {
			Connection con = DBHelper.getInstance().getConn();
			PreparedStatement stmt = con.prepareStatement(sql);
			int result = stmt.executeUpdate();
			if (result == 1) {
				flag = true;
			}
		} catch (Exception e) {
		}
		return flag;
	}
	
	public boolean deleteCategory(int cat_id) {
		boolean flag = false;
		String sql = String.format("UPDATE categories SET isdeleted=1 WHERE id=%d", cat_id);
		try {
			Connection con = DBHelper.getInstance().getConn();
			PreparedStatement stmt = con.prepareStatement(sql);
			int result = stmt.executeUpdate();
			if (result == 1) {
				flag = true;
			}
		} catch (Exception e) {
		}
		return flag;
	}

}

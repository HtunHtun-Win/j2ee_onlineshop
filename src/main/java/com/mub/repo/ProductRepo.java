package com.mub.repo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.mub.models.ProductModel;
import com.mub.utils.DBHelper;

public class ProductRepo {

	public List<ProductModel> getAllProduct() {
		String sql = "SELECT * FROM products WHERE isdeleted=0";
		List<ProductModel> products = new ArrayList<ProductModel>();
		try {
			Connection con = DBHelper.getInstance().getConn();
			PreparedStatement stmt = con.prepareStatement(sql);
			ResultSet set = stmt.executeQuery();
			while (set.next()) {
				products.add(new ProductModel(set.getInt("id"), set.getString("name"), set.getString("sku"),
						set.getString("image"), set.getString("description"), set.getInt("price"),
						set.getInt("quantity"), set.getInt("category_id")));
			}
		} catch (Exception e) {
		}
		return products;
	}
	
	public List<ProductModel> getAllProductByKeyword(String keyword) {
		String sql = "SELECT * FROM products WHERE isdeleted=0 AND name LIKE '%"+keyword+"%'";
		List<ProductModel> products = new ArrayList<ProductModel>();
		try {
			Connection con = DBHelper.getInstance().getConn();
			PreparedStatement stmt = con.prepareStatement(sql);
			ResultSet set = stmt.executeQuery();
			while (set.next()) {
				products.add(new ProductModel(set.getInt("id"), set.getString("name"), set.getString("sku"),
						set.getString("image"), set.getString("description"), set.getInt("price"),
						set.getInt("quantity"), set.getInt("category_id")));
			}
		} catch (Exception e) {
		}
		return products;
	}
	
	public List<ProductModel> getAllProductByCategory(int cat_id) {
		String sql = "SELECT * FROM products WHERE isdeleted=0 AND category_id="+cat_id;
		List<ProductModel> products = new ArrayList<ProductModel>();
		try {
			Connection con = DBHelper.getInstance().getConn();
			PreparedStatement stmt = con.prepareStatement(sql);
			ResultSet set = stmt.executeQuery();
			while (set.next()) {
				products.add(new ProductModel(set.getInt("id"), set.getString("name"), set.getString("sku"),
						set.getString("image"), set.getString("description"), set.getInt("price"),
						set.getInt("quantity"), set.getInt("category_id")));
			}
		} catch (Exception e) {
		}
		return products;
	}
	
	public List<ProductModel> getPopularProduct() {
		String sql = "SELECT p.*,SUM(od.quantity) AS total_quantity FROM products p INNER JOIN order_detail od ON p.id = od.product_id WHERE od.isdeleted=0 GROUP BY p.id ORDER BY total_quantity DESC LIMIT 10";
		List<ProductModel> products = new ArrayList<ProductModel>();
		try {
			Connection con = DBHelper.getInstance().getConn();
			PreparedStatement stmt = con.prepareStatement(sql);
			ResultSet set = stmt.executeQuery();
			while (set.next()) {
				products.add(new ProductModel(set.getInt("id"), set.getString("name"), set.getString("sku"),
						set.getString("image"), set.getString("description"), set.getInt("price"),
						set.getInt("quantity"), set.getInt("category_id")));
			}
		} catch (Exception e) {
//			pass
		}
		return products;
	}

	public ProductModel getById(int pid) {
		String sql = "SELECT * FROM products WHERE id=" + pid;
		ProductModel product = null;
		try {
			Connection con = DBHelper.getInstance().getConn();
			PreparedStatement stmt = con.prepareStatement(sql);
			ResultSet set = stmt.executeQuery();
			while (set.next()) {
				product = new ProductModel(set.getInt("id"), set.getString("name"), set.getString("sku"),
						set.getString("image"), set.getString("description"), set.getInt("price"),
						set.getInt("quantity"), set.getInt("category_id"));
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		return product;
	}
	
	public ProductModel getLatestProduct() {
		String sql = "SELECT * FROM products ORDER BY id DESC LIMIT 1";
		ProductModel product = null;
		try {
			Connection con = DBHelper.getInstance().getConn();
			PreparedStatement stmt = con.prepareStatement(sql);
			ResultSet set = stmt.executeQuery();
			while (set.next()) {
				product = new ProductModel(set.getInt("id"), set.getString("name"), set.getString("sku"),
						set.getString("image"), set.getString("description"), set.getInt("price"),
						set.getInt("quantity"), set.getInt("category_id"));
			}
		} catch (Exception e) {
		}
		return product;
	}

	public boolean insertProduct(ProductModel product) {
		boolean flag = false;
		String sql = String.format(
				"INSERT INTO products(name,sku,image,description,price,quantity,category_id) values('%s','%s','%s','%s',%d,%d,%d)",
				product.name, product.sku, product.image, product.description, product.price, product.quantity,
				product.cat_id);
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

	public boolean updateProduct(ProductModel product) {
		boolean flag = false;
		String sql = String.format(
				"UPDATE products SET name='%s',sku='%s',image='%s',description='%s',price=%d,quantity=%d,category_id=%d WHERE id=%d",
				product.name, product.sku, product.image, product.description, product.price, product.quantity,
				product.cat_id, product.id);
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
	
	public void changeQty(int id,int qty) {
		String sql = String.format(
				"UPDATE products SET quantity=quantity+%d WHERE id=%d",qty,id);
		try {
			Connection con = DBHelper.getInstance().getConn();
			PreparedStatement stmt = con.prepareStatement(sql);
			int result = stmt.executeUpdate();
		} catch (Exception e) {
			System.out.println(e);
		}
	}
	
	public boolean addProductLog(int id,String note,int qty) {
		boolean flag = false;
		String sql = String.format("INSERT INTO product_logs(product_id,note,quantity) VALUES(?,?,?)");
		try {
			Connection con = DBHelper.getInstance().getConn();
			PreparedStatement stmt = con.prepareStatement(sql);
			stmt.setInt(1, id);
			stmt.setString(2, note);
			stmt.setInt(3, qty);
			int result = stmt.executeUpdate();
			if (result == 1) {
				flag = true;
			}
		} catch (Exception e) {
		}
		return flag;
	}

	public boolean deleteProduct(int id) {
		boolean flag = false;
		String sql = String.format("UPDATE products SET isdeleted=1 WHERE id=%d", id);
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

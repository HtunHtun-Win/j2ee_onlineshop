package com.mub.repo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.mub.models.OrderDetailModel;
import com.mub.models.OrderItemModel;
import com.mub.models.OrderModel;
import com.mub.utils.DBHelper;

public class OrderRepo {
	private Connection conn;

	public OrderRepo() {
		try {
			conn = DBHelper.getConn();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public List<OrderModel> getUserOrdersByDate(String from, String to) {
		List<OrderModel> list = new ArrayList<>();
		String sql = "SELECT o.*, u.name AS user_name FROM `orders` o " + "JOIN users u ON o.user_id = u.id "
				+ "WHERE o.isdeleted = 0";

		if (from != null && !from.isEmpty() && to != null && !to.isEmpty()) {
			sql += " AND DATE(o.created_at) BETWEEN ? AND ?";
		}else {
			sql += " AND DATE(o.created_at) BETWEEN DATE_FORMAT(CURRENT_DATE(), '%Y-%m-01') AND LAST_DAY(CURRENT_DATE())";
		}

		sql += " ORDER BY o.created_at DESC";

		try{
			if(conn==null) {
				conn = DBHelper.getConn();
			}
			PreparedStatement stmt = conn.prepareStatement(sql);
			if (from != null && !from.isEmpty() && to != null && !to.isEmpty()) {
				stmt.setString(1, from);
				stmt.setString(2, to);
			}

			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				OrderModel o = new OrderModel();
				o.orderNo = rs.getString("order_no");
				o.userId = rs.getInt("user_id");
				o.userName = rs.getString("user_name");
				o.totalAmount = rs.getDouble("total_amount");
				o.address = rs.getString("address");
				o.status = rs.getString("status");
				o.payment = rs.getString("payment");
				o.createdAt = rs.getString("created_at");
				list.add(o);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return list;
	}
	
	public List<OrderItemModel> getUserOrderItem(String from, String to) {
	    List<OrderItemModel> list = new ArrayList<>();
	    String sql = "SELECT od.id, o.order_no, p.name, od.quantity, od.price, " +
	                 "(od.quantity * od.price) AS total " +
	                 "FROM order_detail od " +
	                 "JOIN orders o ON od.order_no = o.order_no " +
	                 "JOIN products p ON od.product_id = p.id " +
	                 "WHERE o.status='confirm' AND o.isdeleted = 0";

	    if (from != null && !from.isEmpty() && to != null && !to.isEmpty()) {
	        sql += " AND DATE(o.created_at) BETWEEN ? AND ?";
	    } else {
	        sql += " AND DATE(o.created_at) BETWEEN DATE_FORMAT(CURRENT_DATE(), '%Y-%m-01') AND LAST_DAY(CURRENT_DATE())";
	    }

	    sql += " ORDER BY o.created_at DESC";

	    try {
	        if (conn == null) {
	            conn = DBHelper.getConn();
	        }
	        PreparedStatement stmt = conn.prepareStatement(sql);

	        if (from != null && !from.isEmpty() && to != null && !to.isEmpty()) {
	            stmt.setString(1, from);
	            stmt.setString(2, to);
	        }

	        ResultSet rs = stmt.executeQuery();
	        while (rs.next()) {
	            OrderItemModel item = new OrderItemModel();
	            item.id = rs.getInt("id");
	            item.orderNo = rs.getString("order_no");
	            item.name = rs.getString("name");
	            item.qty = rs.getInt("quantity");
	            item.price = rs.getDouble("price");
	            item.total = rs.getDouble("total");
	            list.add(item);
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return list;
	}
	
	public List<OrderItemModel> getItemByOrder(String from, String to) {
	    List<OrderItemModel> list = new ArrayList<>();
	    String sql = "select p.name,p.sku,p.price,SUM(od.quantity) as qty " +
	                 "from products p " +
	                 "JOIN order_detail od on p.id=od.product_id " +
	                 "WHERE od.isdeleted=0 ";

	    if (from != null && !from.isEmpty() && to != null && !to.isEmpty()) {
	        sql += " AND DATE(od.created_at) BETWEEN ? AND ?";
	    } else {
	        sql += " AND DATE(od.created_at) BETWEEN DATE_FORMAT(CURRENT_DATE(), '%Y-%m-01') AND LAST_DAY(CURRENT_DATE())";
	    }

	    sql += " GROUP by p.id ORDER BY qty DESC";

	    try {
	        if (conn == null) {
	            conn = DBHelper.getConn();
	        }
	        PreparedStatement stmt = conn.prepareStatement(sql);

	        if (from != null && !from.isEmpty() && to != null && !to.isEmpty()) {
	            stmt.setString(1, from);
	            stmt.setString(2, to);
	        }

	        ResultSet rs = stmt.executeQuery();
	        while (rs.next()) {
	            OrderItemModel item = new OrderItemModel();
	            item.name = rs.getString("name");
	            item.price = rs.getDouble("price");
	            item.qty = rs.getInt("qty");
	            item.total = item.price*item.qty;
	            list.add(item);
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return list;
	}

	
	public List<OrderModel> getOrdersByDate(String from, String to,int userId) {
		List<OrderModel> list = new ArrayList<>();
		String sql = "SELECT o.*, u.name AS user_name FROM `orders` o " + "JOIN users u ON o.user_id = u.id "
				+ "WHERE o.isdeleted = 0 AND o.user_id=?";

		if (from != null && !from.isEmpty() && to != null && !to.isEmpty()) {
			sql += " AND DATE(o.created_at) BETWEEN ? AND ?";
		}else {
			sql += " AND DATE(o.created_at) BETWEEN DATE_FORMAT(CURRENT_DATE(), '%Y-%m-01') AND LAST_DAY(CURRENT_DATE())";
		}

		sql += " ORDER BY o.created_at DESC";

		try (PreparedStatement stmt = conn.prepareStatement(sql)) {
			stmt.setInt(1, userId);
			if (from != null && !from.isEmpty() && to != null && !to.isEmpty()) {
				stmt.setString(2, from);
				stmt.setString(3, to);
			}
			
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				OrderModel o = new OrderModel();
				o.orderNo = rs.getString("order_no");
				o.userId = rs.getInt("user_id");
				o.userName = rs.getString("user_name");
				o.totalAmount = rs.getDouble("total_amount");
				o.address = rs.getString("address");
				o.status = rs.getString("status");
				o.payment = rs.getString("payment");
				o.createdAt = rs.getString("created_at");
				list.add(o);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return list;
	}

	public void insertOrder(String orderNo, int userId, double amount, double discount, double total, String address) {
		String sql = "INSERT INTO `orders` (order_no, user_id, amount, discount, total_amount, address, status, isdeleted, created_at) VALUES (?, ?, ?, ?, ?, ?, ?, 0, NOW())";
		try (PreparedStatement stmt = conn.prepareStatement(sql)) {
			stmt.setString(1, orderNo);
			stmt.setInt(2, userId);
			stmt.setDouble(3, amount);
			stmt.setDouble(4, discount);
			stmt.setDouble(5, total);
			stmt.setString(6, address);
			stmt.setString(7, "pending");
			stmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public void insertOrderDetail(String orderNo, int productId, int quantity, double price) {
		String sql = "INSERT INTO order_detail (order_no, product_id, quantity, price, isdeleted, created_at) VALUES (?, ?, ?, ?, 0, NOW())";
		try (PreparedStatement stmt = conn.prepareStatement(sql)) {
			stmt.setString(1, orderNo);
			stmt.setInt(2, productId);
			stmt.setInt(3, quantity);
			stmt.setDouble(4, price);
			stmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public void updatePaymentProof(String orderNo, String proofFileName) {
        try{
            PreparedStatement ps = conn.prepareStatement("UPDATE orders SET payment=? WHERE order_no=?");
            ps.setString(1, proofFileName);
            ps.setString(2, orderNo);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
	
	public OrderModel getOrderByOrderNo(String orderNo) {
	    OrderModel o = null;
	    try (PreparedStatement ps = conn.prepareStatement("SELECT o.*, u.name AS userName FROM orders o JOIN users u ON o.user_id = u.id WHERE o.order_no=?")) {
	        ps.setString(1, orderNo);
	        ResultSet rs = ps.executeQuery();
	        if (rs.next()) {
	            o = new OrderModel();
	            o.orderNo = rs.getString("order_no");
	            o.userId = rs.getInt("user_id");
	            o.userName = rs.getString("userName");
	            o.address = rs.getString("address");
	            o.status = rs.getString("status");
	            o.totalAmount = rs.getDouble("total_amount");
	            o.payment = rs.getString("payment");
	            o.createdAt = rs.getString("created_at");
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return o;
	}

	public List<OrderDetailModel> getOrderDetails(String orderNo) {
	    List<OrderDetailModel> list = new ArrayList<>();
	    try (PreparedStatement ps = conn.prepareStatement(
	            "SELECT od.*, p.name AS productName " +
	            "FROM order_detail od JOIN products p ON od.product_id = p.id " +
	            "WHERE od.order_no=? AND od.isdeleted=0")) {
	        ps.setString(1, orderNo);
	        ResultSet rs = ps.executeQuery();
	        while (rs.next()) {
	            OrderDetailModel d = new OrderDetailModel();
	            d.id = rs.getInt("id");
	            d.orderNo = rs.getString("order_no");
	            d.productId = rs.getInt("product_id");
	            d.productName = rs.getString("productName");
	            d.quantity = rs.getInt("quantity");
	            d.price = rs.getDouble("price");
	            d.createdAt = rs.getString("created_at");
	            list.add(d);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return list;
	}
	
	public void orderConfirm(String orderNo,String status) {
		try{
            PreparedStatement ps = conn.prepareStatement("UPDATE orders SET status=? WHERE order_no=?");
            ps.setString(1, status);
            ps.setString(2, orderNo);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
	}
	
	public void restoreOrderItems(String orderNo) {
		try{
			OrderModel orderModel = getOrderByOrderNo(orderNo);
			if(!orderModel.status.equals("cancel")) {
				List<OrderDetailModel> datas = getOrderDetails(orderNo);
				ProductRepo repo = new ProductRepo();
				for(OrderDetailModel data : datas) {
					repo.changeQty(data.productId, data.quantity);
					repo.addProductLog(data.productId, "restore", data.quantity);
				}
			}
        } catch (Exception e) {
            e.printStackTrace();
        }
	}
	
	public boolean deleteOrder(String orderNo) {
	    try {
	    	restoreOrderItems(orderNo);
	        // Soft delete: set isdeleted = 1
	        String sql = "UPDATE orders SET isdeleted = 1 WHERE order_no = ?";
	        PreparedStatement ps = conn.prepareStatement(sql);
	        ps.setString(1, orderNo);
	        int result = ps.executeUpdate();

	        // Optional: delete order details too
	        String sql2 = "UPDATE order_detail SET isdeleted = 1 WHERE order_no = ?";
	        PreparedStatement ps2 = conn.prepareStatement(sql2);
	        ps2.setString(1, orderNo);
	        ps2.executeUpdate();

	        return result > 0;
	    } catch (Exception e) {
	        e.printStackTrace();
	        return false;
	    }
	}

}

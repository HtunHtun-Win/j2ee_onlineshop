package com.mub.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.mub.models.CategoryModel;
import com.mub.models.ProductModel;
import com.mub.repo.CategoryRepo;
import com.mub.repo.ProductRepo;
import com.mub.utils.AuthUtil;
import com.mub.utils.DBHelper;

@WebServlet("/ProductController")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 1, // 1 MB
		maxFileSize = 1024 * 1024 * 10, // 10 MB
		maxRequestSize = 1024 * 1024 * 15 // 15 MB
)
public class ProductController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public ProductController() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		List<ProductModel> products = new ArrayList<ProductModel>();
		List<CategoryModel> categories = new ArrayList<CategoryModel>();
		AuthUtil auth = new AuthUtil();
		HttpSession session = request.getSession();
		ProductRepo productRepo = new ProductRepo();
		CategoryRepo categoryRepo = new CategoryRepo();
		String cat_id = request.getParameter("category");
		String keyword = request.getParameter("search");
		try {
			if (auth.isUserLoggedIn(request)) {
				if(keyword!=null) {
					if(keyword.length()>0) {
						products = productRepo.getAllProductByKeyword(keyword);
						session.setAttribute("keyword", keyword);
						session.removeAttribute("selected_category");
					}else {
						products = productRepo.getAllProduct();
						session.removeAttribute("keyword");
						session.removeAttribute("selected_category");
					}
				}else if (cat_id == null) {
					products = productRepo.getAllProduct();
					session.removeAttribute("keyword");
					session.removeAttribute("selected_category");
				} else {
					products = productRepo.getAllProductByCategory(Integer.parseInt(cat_id));
					session.removeAttribute("keyword");
					session.setAttribute("selected_category", categoryRepo.getById(Integer.parseInt(cat_id)));
				}
				categories = categoryRepo.getAllCategory();
				session.setAttribute("products", products);
				session.setAttribute("categories", categories);
				response.sendRedirect("/PopWare/pages/product.jsp");
			} else {
				response.sendRedirect("/PopWare/LoginController");
			}
		} catch (Exception e) {
			e.printStackTrace();
			response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error");
		}
	}

//	private static final String IMAGE_UPLOAD_DIR = "/assets/images";

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		ProductRepo repo = new ProductRepo();

		try {
			// Handle delete
			String deleted_id = request.getParameter("delete_id");
			if (deleted_id != null) {
				int id = Integer.parseInt(deleted_id);
				repo.deleteProduct(id);
				response.sendRedirect("/PopWare/ProductController");
				return;
			}

			// Read common form fields
			String id_str = request.getParameter("id");
			String name = request.getParameter("name").trim();
			String sku = request.getParameter("sku").trim();
			String description = request.getParameter("description").trim();
			int price = Integer.parseInt(request.getParameter("price"));
			int quantity = Integer.parseInt(request.getParameter("quantity"));
			int cat_id = Integer.parseInt(request.getParameter("cat_id"));

			// Handle image upload
			Part imagePart = request.getPart("imageFile");
			String imageFileName = null;

			if (imagePart != null && imagePart.getSize() > 0) {
				String submittedFileName = Paths.get(imagePart.getSubmittedFileName()).getFileName().toString();
				// Sanitize and rename with timestamp
				submittedFileName = submittedFileName.replaceAll("[^a-zA-Z0-9\\.\\-]", "_");
				imageFileName = System.currentTimeMillis() + "_" + submittedFileName;

				// Prepare path and save
				// String uploadPath = getServletContext().getRealPath("/") + IMAGE_UPLOAD_DIR;
				String uploadPath = getServletContext().getRealPath("") + File.separator + "assets/images";
//				String uploadPath = "/home/htun/Documents/jakarta_ee_pj/PopWare/src/main/webapp/assets/images";
				File uploadDir = new File(uploadPath);
				if (!uploadDir.exists())
					uploadDir.mkdirs();

				imagePart.write(uploadPath + File.separator + imageFileName);
			} else if (id_str != null) {
				// No new image uploaded → preserve old image
				int id = Integer.parseInt(id_str);
				ProductModel existingProduct = repo.getById(id);
				imageFileName = (existingProduct != null) ? existingProduct.image : "default.png";
			} else {
				// New product and no image uploaded
				imageFileName = "default.png";
			}

			// Add or Update
			if (id_str == null || id_str.isEmpty()) {
				// Insert
				ProductModel newProduct = new ProductModel(0, name, sku, imageFileName, description, price, quantity,
						cat_id);
				repo.insertProduct(newProduct);
				ProductModel latest = repo.getLatestProduct();
				repo.addProductLog(latest.id, "opening", quantity);
			} else {
				// Update
				int id = Integer.parseInt(id_str);
				ProductModel oldInfo = repo.getById(id);
				ProductModel updatedProduct = new ProductModel(id, name, sku, imageFileName, description, price,
						quantity, cat_id);
				repo.updateProduct(updatedProduct);
				if(oldInfo.quantity!=updatedProduct.quantity) {
					int qty = updatedProduct.quantity - oldInfo.quantity;
					repo.addProductLog(id, "adjust", qty);
				}				
			}

			// Redirect to product list
			response.sendRedirect("/PopWare/ProductController");

		} catch (Exception e) {
			e.printStackTrace();
			response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Product operation failed.");
		}
	}

}

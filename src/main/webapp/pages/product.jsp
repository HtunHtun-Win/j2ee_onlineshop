<%@page import="com.mub.repo.CategoryRepo"%>
<%@page import="com.mub.models.CategoryModel"%>
<%@page import="java.util.List"%>
<%@page import="com.mub.models.ProductModel"%>
<%@ include file="adminHeader.jsp"%>
<!-- Main Content -->
<%
CategoryRepo categoryRepo = new CategoryRepo();
List<CategoryModel> categories = categoryRepo.getAllCategory();
%>
<main>
	<div class="content-header">
		<%
		String keyword = (String) session.getAttribute("keyword");
		if (keyword == null) {
			keyword = "";
		} else if (keyword.length() == 0) {
			keyword = "";
		}
		CategoryModel sel_category = (CategoryModel) session.getAttribute("selected_category");
		String catName = "Select Category";
		if (sel_category != null) {
			catName = sel_category.name;
		}
		List<ProductModel> products = (List<ProductModel>) session.getAttribute("products");
		%>
		<button
			onclick="document.getElementById('addDialog').style.display='block'"
			class="add-btn">Add Product</button>
		<form action="/PopWare/ProductController" method="get"
			class="searchForm">
			<input type="text" name="search" placeholder="Search..."
				value="<%=keyword%>">
			<button type="submit">Search</button>
		</form>
		<div class="dropdown">
			<a href="#" class="dropbtn"><%=catName%> (<span style="font-weight:bold; color: white !important;"><%= products.size() %></span>)</a>
			<div class="dropdown-content">
				<a href="/PopWare/ProductController">All</a>
				<%
				for (CategoryModel category : categories) {
				%>
				<a href="/PopWare/ProductController?category=<%=category.id%>"><%=category.name%></a>
				<%
				}
				%>
			</div>
		</div>
	</div>

	<div class="item-grid">
		<%
		
		if (products != null) {
			for (ProductModel product : products) {
				String image = product.image.length() != 0 ? product.image : "default.png";
		%>
		<div class="item-card">
			<div class="item-image">
				<img src="/PopWare/assets/images/<%=image%>" alt="<%=product.name%>">
			</div>
			<div class="item-info">
				<h3><%=product.name%></h3>
			</div>
			<div class="mini-info">
				<p class="sku">
					SKU:
					<%=product.sku%></p>
				<p class="price">
					Price:
					<%=product.price%>
					MMK
				</p>
				<p class="quantity">
					Qty:
					<%=product.quantity%>
					pcs
				</p>
			</div>
			<div class="card-actions">
				<button
					onclick="openEditDialog(<%=product.id%>,'<%=product.name%>','<%=product.sku%>','<%=product.price%>','<%=product.description%>','<%=product.quantity%>','<%=product.cat_id%>')"
					class="edit-btn">Edit</button>
				<button onclick="confirmDelete(<%=product.id%>)" class="delete-btn">Delete</button>
			</div>
		</div>
		<%
		}
		}
		%>
	</div>

</main>

<!--add Dialog -->
<div id="addDialog" class="dialog">
	<div class="dialog-content">
		<span class="close"
			onclick="document.getElementById('addDialog').style.display='none'">&times;</span>
		<h2 class="dialog-title">Add New Product</h2>

		<form method="post" action="/PopWare/ProductController"
			class="form-grid" enctype="multipart/form-data">
			<!-- Column 1 -->
			<div class="form-col">
				<label>Name</label> <input type="text" name="name" required>

				<label>SKU</label> <input type="text" name="sku" required> <label>Image
					URL</label> <input type="file" name="imageFile" multiple> <label>Price</label>
				<input type="number" name="price" required>
			</div>

			<!-- Column 2 -->
			<div class="form-col">
				<label>Description</label>
				<textarea name="description" rows="3" required></textarea>

				<label>Quantity</label> <input type="number" name="quantity"
					required> <label>Category</label> <select name="cat_id"
					required>
					<%
					for (CategoryModel category : categories) {
					%>
					<option value="<%=category.id%>"><%=category.name%></option>
					<%
					}
					%>
				</select>
			</div>

			<!-- Full-width Submit button -->
			<div class="form-submit">
				<button type="submit" class="submit-btn">Add Product</button>
			</div>
		</form>

	</div>
</div>

<!-- Edit Dialog -->
<div id="editDialog" class="dialog">
	<div class="dialog-content">
		<span class="close" onclick="closeEditDialog()">&times;</span>
		<h3>Edit Product</h3>
		<form method="post" action="/PopWare/ProductController"
			class="form-grid" enctype="multipart/form-data">
			<input type="hidden" name="id" id="editId" />
			<!-- Column 1 -->
			<div class="form-col">
				<label>Name</label> <input type="text" name="name" id="editName"
					required> <label>SKU</label> <input type="text" name="sku"
					id="editSKU" required> <label>Image URL</label> <input
					type="file" name="imageFile"> <label>Price</label> <input
					type="number" name="price" id="editPrice" required>
			</div>

			<!-- Column 2 -->
			<div class="form-col">
				<label>Description</label>
				<textarea name="description" rows="3" id="editDesc" required></textarea>

				<label>Quantity</label> <input type="number" name="quantity"
					id="editQty" required> <label>Category</label> <select
					name="cat_id" id="editCat" required>
					<%
					for (CategoryModel category : categories) {
					%>
					<option value="<%=category.id%>"><%=category.name%></option>
					<%
					}
					%>
				</select>
			</div>
			<!-- Full-width Submit button -->
			<div class="form-submit">
				<button type="submit" class="edit-btn">Save Changes</button>
			</div>
		</form>
	</div>
</div>

<!-- Delete Confirmation Dialog -->
<div id="deleteDialog" class="dialog">
	<div class="dialog-content">
		<h3>Confirm Delete</h3>
		<p>Are you sure you want to delete this product?</p>
		<form method="post" action="/PopWare/ProductController">
			<input type="hidden" name="delete_id" id="deleteId" />
			<div style="display: flex; justify-content: flex-end; gap: 10px;">
				<button type="button" class="edit-btn" onclick="closeDeleteDialog()">Cancel</button>
				<button type="submit" class="delete-btn">Delete</button>
			</div>
		</form>
	</div>
</div>

<script>
function openEditDialog(id,name,sku,price,desc,qty,cat_id) {
	  document.getElementById('editId').value = id;
	  document.getElementById('editName').value = name;
	  document.getElementById('editSKU').value = sku;
	  document.getElementById('editPrice').value = price;
	  document.getElementById('editDesc').value = desc;
	  document.getElementById('editQty').value = qty;
	  document.getElementById('editCat').value = cat_id;
	  document.getElementById('editDialog').style.display = 'block';
	}

	function closeEditDialog() {
	  document.getElementById('editDialog').style.display = 'none';
	}

	function confirmDelete(id) {
	  document.getElementById('deleteId').value = id;
	  document.getElementById('deleteDialog').style.display = 'block';
	}

	function closeDeleteDialog() {
	  document.getElementById('deleteDialog').style.display = 'none';
	}
</script>

<%@ include file="footer.jsp"%>

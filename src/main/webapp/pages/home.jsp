<%@page import="com.mub.repo.CategoryRepo"%>
<%@page import="com.mub.models.CategoryModel"%>
<%@page import="java.util.List"%>
<%@page import="com.mub.models.ProductModel"%>
<%@ include file="header.jsp"%>
<!-- Main Content -->
<main>
	<div class="content-header">
		<%
		CategoryRepo categoryRepo = new CategoryRepo();
		CategoryModel sel_category = (CategoryModel) session.getAttribute("selected_category");
		List<ProductModel> pop_items = (List<ProductModel>) session.getAttribute("pop_items");
		List<ProductModel> products = (List<ProductModel>) session.getAttribute("products");
		List<CategoryModel> categories = categoryRepo.getAllCategory();
		int hotCount = 1;
		String keyword = (String) session.getAttribute("keyword");
		if (keyword == null) {
			keyword = "";
		} else if (keyword.length() == 0) {
			keyword = "";
		}
		String catName = "Select Category";
		if (sel_category != null) {
			catName = sel_category.name;
		}
		%>
		<h3></h3>
		<form action="/PopWare/HomeController" method="get" class="searchForm">
			<input type="text" name="search" placeholder="Search..."
				value="<%=keyword%>">
			<button type="submit">Search</button>
		</form>
		<div class="dropdown">
			<a href="#" class="dropbtn"><%=catName%> (<span
				style="font-weight: bold; color: white !important;"><%=products.size()%></span>)</a>
			<div class="dropdown-content">
				<a href="/PopWare/HomeController">All</a>
				<%
				for (CategoryModel category : categories) {
				%>
				<a href="/PopWare/HomeController?category=<%=category.id%>"><%=category.name%></a>
				<%
				}
				%>
			</div>
		</div>
	</div>
	<%
	if (pop_items != null && pop_items.size() != 0) {
	%>
	<h1>Popular Items</h1>
	<%
	}
	%>
	<div class="item-grid">
		<%
		if (pop_items != null) {
			for (ProductModel product : pop_items) {
				String image = product.image.length() != 0 ? product.image : "default.png";
		%>
		<a href="/PopWare/ProductDetailController?pid=<%=product.id%>"
			class="item-card">
			<div class="item-image">
				<img src="/PopWare/assets/images/<%=image%>" alt="<%=product.name%>">
			</div>
			<div class="item-info">
				<h3><%=product.name%></h3>
			</div>
			<div class="mini-info">
				<p class="sku">
					SKU:
					<%=product.sku%>
					<%
					if (hotCount <= 3) {
					%>
					<span class="hot-badge">Hot Item</span>
					<%
					hotCount++;
					}
					%>
				</p>

				<p class="price">
					Price:
					<%=product.price%>
					MMK
				</p>
				<p class="quantity">
					Qty:
					<%
				if (product.quantity > 0) {
				%>
					<%=product.quantity%>pcs
					<%
					} else {
					%>
					<span class="hot-badge">Out of stock</span>
					<%
					}
					%>
					
				</p>
			</div>
		</a>
		<%
		}
		}
		%>
	</div>

	<%
	if (products != null && products.size() != 0) {
	%>
	<h1>Suggest For You</h1>
	<%
	}
	%>

	<div class="item-grid">
		<%
		if (products != null) {
			for (ProductModel product : products) {
				String image = product.image.length() != 0 ? product.image : "default.png";
		%>
		<a href="/PopWare/ProductDetailController?pid=<%=product.id%>"
			class="item-card">
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
					<%
				if (product.quantity > 0) {
				%>
					<%=product.quantity%>pcs
					<%
					} else {
					%>
					<span class="hot-badge">Out of stock</span>
					<%
					}
					%>
				</p>
			</div>
		</a>
		<%
		}
		}
		%>
	</div>

</main>

<%@ include file="footer.jsp"%>

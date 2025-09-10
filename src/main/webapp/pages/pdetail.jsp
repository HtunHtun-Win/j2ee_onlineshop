<%@page import="com.mub.utils.DBHelper"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.mub.models.ReviewModel"%>
<%@page import="com.mub.repo.ReviewRepo"%>
<%@page import="com.mub.models.ProductModel"%>
<%@ include file="header.jsp"%>
<!-- Main Content -->

<%
ProductModel product = (ProductModel) session.getAttribute("product");
String image = product.image.length() != 0 ? product.image : "default.png";
Connection con = DBHelper.getInstance().getConn();
ReviewRepo reviewRepo = new ReviewRepo(con);
List<ReviewModel> reviews = reviewRepo.getReviewsByProduct(product.id);
%>
<main>
	<div class="product-detail-card">
		<div class="detail_flex">
			<div>
				<a class="back-btn" href="/PopWare/pages/home.jsp"> <%="<"%></a>
			</div>
			<div>
				<%
				if (user.id != 0) {
					if (product.quantity > 0) {
				%>
				<form method="post" action="/PopWare/AddToCartController">
					<input type="hidden" name="id" value="<%=product.id%>">

					<div class="quantity-wrapper">
						<button type="button" onclick="decreaseQty(this)">
							<i class="fa fa-minus"></i>
						</button>
						<input type="number" name="quantity" value="1" min="1"
							max="<%=product.quantity%>" required readonly>
						<button type="button"
							onclick="increaseQty(this, <%=product.quantity%>)">
							<i class="fa fa-plus"></i>
						</button>
					</div>


					<button class="addbtn" type="submit">Add to Cart</button>
					<%
					}
					%>
				</form>
				<%
				}
				%>
			</div>
		</div>

		<div class="pdetail">
			<img src="/PopWare/assets/images/<%=image%>" alt="Item 1"
				class="product-img">

			<table class="pdetail_table">
				<tr>
					<td>Name</td>
					<td><%=product.name%></td>
				</tr>
				<tr>
					<td>Price</td>
					<td><%=product.price%> MMK</td>
				</tr>
				<tr>
					<td>SKU</td>
					<td><%=product.sku%></td>
				</tr>
				<tr>
					<td>Available Stock:</td>
					<td><%=product.quantity%> pcs</td>
				</tr>
				<tr>
					<td>Description</td>
					<td><%=product.description%></td>
				</tr>
			</table>
		</div>





	</div>

	<%
	if (user.id != 0) {
	%>
	<!-- Add Review Form -->
	<div class="add-review">
		<form method="post" action="/PopWare/ReviewController">
			<input type="hidden" name="product_id" value="<%=product.id%>">
			<label>Rating:</label> <select name="rating" style="font-size: 200%;"
				required>
				<option value="5">*****</option>
				<option value="4">****</option>
				<option value="3">***</option>
				<option value="2">**</option>
				<option value="1">*</i></option>
			</select> <br>
			<textarea name="comment" placeholder="Write your review..." required></textarea>
			<br>
			<button type="submit">Submit Review</button>
		</form>
	</div>
	<%
	}
	%>

	<!-- Review Section -->
	<%
	if (reviews.size() > 0) {
	%>
	<div class="reviews">
		<h2>Customer Reviews</h2>
		<%
		for (ReviewModel r : reviews) {
		%>
		<div class="review-card">
			<p>
				<strong><%=r.userName%></strong> - <span class="stars"> <%
 for (int i = 1; i <= 5; i++) {
 %> <i class="fa fa-star <%=i <= r.rating ? "checked" : ""%>"></i> <%
 }
 %>
				</span>
			</p>
			<p><%=r.comment%></p>
			<small><%=r.createdAt%></small>
		</div>
		<%
		}
		%>
	</div>
	<%
	}
	%>

</main>

<script>
  function increaseQty(btn, max) {
    const input = btn.parentNode.querySelector("input");
    let current = parseInt(input.value) || 1;
    if (current < max) {
      input.value = current + 1;
    }
  }

  function decreaseQty(btn) {
    const input = btn.parentNode.querySelector("input");
    let current = parseInt(input.value) || 1;
    if (current > 1) {
      input.value = current - 1;
    }
  }
</script>


<%@ include file="footer.jsp"%>

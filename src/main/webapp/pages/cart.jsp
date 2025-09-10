<%@ page import="java.util.List" %>
<%@ page import="com.mub.models.CartItem" %>
<%@ include file="header.jsp" %>

<main>
	<div class="item-list">
		<table class="mytable">
			<thead>
				<tr>
					<th>Name</th>
					<th>Quantity</th>
					<th>Price</th>
					<th></th>
				</tr>
			</thead>
			<tbody>
				<%
					double total = 0;
					if (cart != null && !cart.isEmpty()) {
						for (CartItem item : cart) {
							double subtotal = item.price * item.quantity;
							total += subtotal;
				%>
				<tr>
					<td>
						<div class="itemgp">
							<img src="/PopWare/assets/images/<%= item.image %>" alt="<%= item.name %>" />
							<h4><%= item.name %></h4>
						</div>
					</td>
					<td><input class="chQty" type="text" value="<%= item.quantity %>" readonly /></td>
					<td><%= String.format("%.2f", item.price) %> MMK</td>
					<td>
						<form action="/PopWare/RemoveFromCart" method="post">
							<input type="hidden" name="productId" value="<%= item.productId %>" />
							<button class="delbtn" type="submit">Remove</button>
						</form>
					</td>
				</tr>
				<%
						}
					} else {
						response.sendRedirect("/PopWare/pages/home.jsp");
					}
				%>

				<tr>
					<td></td>
					<td>
						<h4>Total Amount</h4>
					</td>
					<td>
						<p>$<%= String.format("%.2f", total) %></p>
					</td>
					<td>
						<form action="/PopWare/CartPaidController" method="post">
							<button class="paidbtn" type="submit">Submit</button>
						</form>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
</main>

<%@ include file="footer.jsp" %>

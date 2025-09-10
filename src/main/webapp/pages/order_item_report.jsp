<%@page import="com.mub.models.OrderItemModel"%>
<%@page import="com.mub.repo.OrderRepo"%>
<%@page import="com.mub.models.OrderModel"%>
<%@ include file="adminHeader.jsp"%>
<%@page import="java.util.List"%>

<%
String fromDate = request.getParameter("fromDate");
String toDate = request.getParameter("toDate");

OrderRepo repo = new OrderRepo();
List<OrderItemModel> items = repo.getUserOrderItem(fromDate, toDate);
%>

<main>
	<div class="filter-section">
		<form method="get" action="order_item_report.jsp">
			From: <input type="date" name="fromDate"
				value="<%=fromDate != null ? fromDate : ""%>" /> To: <input
				type="date" name="toDate" value="<%=toDate != null ? toDate : ""%>" />
			<button type="submit">Filter</button>
		</form>
	</div>

	<table class="order-table">
		<thead>
			<tr>
				<th>Order No</th>
				<th>Name</th>
				<th>Price</th>
				<th>Qty</th>
				<th>Amount</th>
			</tr>
		</thead>
		<tbody>
			<%
			double total = 0;
			for (OrderItemModel item : items) {
				total+=item.total;
			%>
			<tr>
				<td><%=item.orderNo%></td>
				<td><%=item.name%></td>
				<td><%=item.price%> MMK</td>
				<td><%=item.qty%></td>
				<td><%=item.total%> MMK</td>
			</tr>
			<%
			}
			%>
			<tr>
				<td colspan="5"></td>
			</tr>
		</tbody>
	</table>

	<!-- Fixed total section -->
	<div class="total-bar">
		<span>Total:</span> <strong><%=total%> MMK</strong>
	</div>

	<div id="deleteDialog" class="custom-dialog hidden">
		<div class="custom-dialog-content">
			<p>Are you sure you want to delete this voucher?</p>
			<div class="custom-dialog-buttons">
				<button onclick="confirmDelete()" class="approve-btn">Delete</button>
				<button onclick="hideDeleteDialog()" class="cancel-btn">Cancel</button>
			</div>
		</div>
	</div>

</main>

<script>
	let selectedOrderNo = null;

	function showDeleteDialog(orderNo) {
		selectedOrderNo = orderNo;
		document.getElementById("deleteDialog").classList.remove("hidden");
	}

	function hideDeleteDialog() {
		document.getElementById("deleteDialog").classList.add("hidden");
		selectedOrderNo = null;
	}

	function confirmDelete() {
		if (selectedOrderNo) {
			window.location.href = "/PopWare/DeleteOrderController?orderNo="
					+ selectedOrderNo;
		}
	}
</script>

<%@ include file="footer.jsp"%>

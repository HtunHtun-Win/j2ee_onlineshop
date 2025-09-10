<%@page import="com.mub.repo.OrderRepo"%>
<%@page import="com.mub.models.OrderModel"%>
<%@ include file="adminHeader.jsp"%>
<%@page import="java.util.List"%>

<%
String fromDate = request.getParameter("fromDate");
String toDate = request.getParameter("toDate");

OrderRepo repo = new OrderRepo();
List<OrderModel> orders = repo.getUserOrdersByDate(fromDate, toDate);
%>

<main>
	<div class="filter-section">
		<form method="get" action="order_report.jsp">
			From: <input type="date" name="fromDate"
				value="<%=fromDate != null ? fromDate : ""%>" /> To: <input
				type="date" name="toDate" value="<%=toDate != null ? toDate : ""%>" />
			<button type="submit">Filter</button>
		</form>
	</div>

	<table class="order-table">
		<thead>
			<tr>
				<th>No</th>
				<th>Date</th>
				<th>Order No</th>
				<th>User Name</th>
				<th>Address</th>
				<th>Amount</th>
			</tr>
		</thead>
		<tbody>
			<%
			double total = 0;
			int no = 1;
			for (OrderModel o : orders) {
				if (o.status.equals("confirm")) {
					total += o.totalAmount;
			%>
			<tr>
				<td><%=no%></td>
				<td><%=o.createdAt%></td>
				<td><%=o.orderNo%></td>
				<td><%=o.userName%></td>
				<td><%=o.address%></td>
				<td><%=o.totalAmount%> MMK</td>
			</tr>
			<%
			no++;}
			}
			%>
		</tbody>
	</table>

	<!-- Fixed total section -->
	<div class="total-bar">
		<span>Total Voucher: <%=no-1%> </span>
		<strong> <span>Total:</span> <%=total%> MMK</strong>
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

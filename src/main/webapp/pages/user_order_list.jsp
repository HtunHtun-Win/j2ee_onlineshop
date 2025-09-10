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
		<form method="get" action="user_order_list.jsp">
			From: <input type="date" name="fromDate"
				value="<%=fromDate != null ? fromDate : ""%>" /> To: <input
				type="date" name="toDate" value="<%=toDate != null ? toDate : ""%>" />
			<button type="submit">Filter</button>
		</form>
	</div>

	<table id="orderTable" class="order-table">
		<thead>
			<tr>
				<th>Order No</th>
				<th>User Name</th>
				<th>Total</th>
				<th>Address</th>
				<th>Status</th>
				<th>Date</th>
				<th>Proof</th>
				<th>Details</th>
				<th>#</th>
			</tr>
		</thead>
		<tbody>
			<%
			for (OrderModel o : orders) {
			%>
			<tr>
				<td><%=o.orderNo%></td>
				<td><%=o.userName%></td>
				<td><%=o.totalAmount%> MMK</td>
				<td><%=o.address%></td>
				<td
					class="<%if (o.status.equals("pending")) {
	out.print("p-color");
} else if (o.status.equals("confirm")) {
	out.print("s-color");
} else {
	out.print("c-color");
}%>"><%=o.status%></td>
				<td><%=o.createdAt%></td>
				<td>
					<%
					if (o.payment != null && !o.payment.isEmpty()) {
					%> <img src="/PopWare/uploads/<%=o.payment%>" width="60"
					height="60" /> <%
 } else {
 %>
					<p>---</p> <%
 }
 %>
				</td>
				<td><a href="uorderDetail.jsp?orderNo=<%=o.orderNo%>">View</a></td>
				<td><a href="javascript:void(0);"
					onclick="showDeleteDialog('<%=o.orderNo%>')" class="delete-btn">
						<i class="fa fa-trash"></i>
				</a></td>
			</tr>
			<%
			}
			%>
		</tbody>
	</table>

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
//Connect to WebSocket
let socket = new WebSocket("ws://localhost:8080/PopWare/orderSocket");

socket.onmessage = function(event) {
	let data = JSON.parse(event.data);

	if (data.type === "new_order") {
		let table = document.getElementById("orderTable");
        if(!table) return; // safety check
        window.location.href = "/PopWare/pages/user_order_list.jsp"
	}
};
//
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

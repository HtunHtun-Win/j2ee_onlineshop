<%@page import="com.mub.repo.OrderRepo"%>
<%@page import="com.mub.models.OrderModel"%>
<%@ include file="header.jsp"%>
<%@page import="java.util.List"%>

<%
String fromDate = request.getParameter("fromDate");
String toDate = request.getParameter("toDate");

OrderRepo repo = new OrderRepo();
List<OrderModel> orders = repo.getOrdersByDate(fromDate, toDate,user.id);
%>

<main>
	<div class="filter-section">
		<form method="get" action="order_list.jsp">
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
				<th>User Name</th>
				<th>Total</th>
				<th>Address</th>
				<th>Status</th>
				<th>Date</th>
				<th>Proof</th>
				<th>Details</th>
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
				<td class="<%
				
				if(o.status.equals("pending")){
					out.print("p-color");
				}else if(o.status.equals("confirm")){
					out.print("s-color");
				}else{
					out.print("c-color");
				}
				
				%>"><%=o.status%></td>
				<td><%=o.createdAt%></td>
				<td>
					<%
					if (o.payment != null && !o.payment.isEmpty()) {
					%> <img
					src="/PopWare/uploads/<%=o.payment%>" width="60" height="60" />
					<%
					} else {
					%>
					<form action="/PopWare/UploadProofController" method="post"
						enctype="multipart/form-data" id="uploadForm-<%=o.orderNo%>">
						<input type="hidden" name="orderNo" value="<%=o.orderNo%>" />

						<!-- Hidden file input -->
						<input type="file" id="fileInput-<%=o.orderNo%>" name="proof"
							accept="image/*" style="display: none;"
							onchange="document.getElementById('uploadForm-<%=o.orderNo%>').submit();" />
						<% if(!o.status.equals("cancel")){ %>
						<button type="button"
							onclick="document.getElementById('fileInput-<%=o.orderNo%>').click();">
							Upload</button>
						<% }%>
					</form> <%
 }
 %>
				</td>
				<td><a href="orderDetail.jsp?orderNo=<%=o.orderNo%>">View</a></td>
			</tr>
			<%
			}
			%>
		</tbody>
	</table>

</main>

<script>
//Connect to WebSocket
let socket = new WebSocket("ws://localhost:8080/PopWare/orderSocket");

socket.onmessage = function(event) {
	let data = JSON.parse(event.data);

	if (data.type === "del_order" || data.type === "con_order") {
        window.location.href = "/PopWare/pages/order_list.jsp"
	}
};
</script>

<%@ include file="footer.jsp"%>

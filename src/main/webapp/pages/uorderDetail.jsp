<%@page import="com.mub.models.OrderModel"%>
<%@page import="com.mub.repo.OrderRepo"%>
<%@page import="com.mub.models.OrderDetailModel"%>
<%@page import="java.util.List"%>
<%@ include file="adminHeader.jsp"%>

<%
String orderNo = request.getParameter("orderNo");
OrderRepo repo = new OrderRepo();
List<OrderDetailModel> details = repo.getOrderDetails(orderNo);
OrderModel order = repo.getOrderByOrderNo(orderNo);
%>
<main>
<button class="print-btn" onclick="window.print()">Print</button>

<div class="voucher-container">
	<div class="voucher-header">
		<h2>Order Voucher</h2>
		<small>Thank you for your order</small>
	</div>

	<div class="voucher-info">
		<p>
			<strong>Order No:</strong>
			<%=order.orderNo%></p>
		<p>
			<strong>Date:</strong>
			<%=order.createdAt%></p>
		<p>
			<strong>Customer:</strong>
			<%=order.userName%></p>
		<p>
			<strong>Address:</strong>
			<%=order.address%></p>
	</div>

	<table class="voucher-table">
		<thead>
			<tr>
				<th>Product</th>
				<th>Price</th>
				<th>Qty</th>
				<th>Subtotal</th>
			</tr>
		</thead>
		<tbody>
			<%
			double grandTotal = 0;
			%>
			<%
			for (OrderDetailModel d : details) {
				double subtotal = d.price * d.quantity;
				grandTotal += subtotal;
			%>
			<tr>
				<td><%=d.productName%></td>
				<td><%=d.price%> MMK</td>
				<td><%=d.quantity%></td>
				<td><%=subtotal%> MMK</td>
			</tr>
			<%
			}
			%>
		</tbody>
	</table>

	<div class="voucher-footer">
		Total: <%=grandTotal%> MMK
	</div>
	
	<div class="no-print">
    <% if(order.payment != null && !order.payment.isEmpty()) { %>
        <p><strong>Payment Proof:</strong></p>
        <img class="proof-img" src="/PopWare/uploads/<%=order.payment%>"/>
    <% } %>

<% if(order.status.equals("pending")) { %>
    <form action="/PopWare/OrderConfirmController" method="post">
    	<input type="hidden" name="action" value="confirm" />
        <input type="hidden" name="orderNo" value="<%=order.orderNo%>" />
        <button type="submit">Confirm Order</button>
    </form>
    <% } %>
    <div style="height: 5px"></div>
    <% if(!order.status.equals("cancel")) { %>
    <form action="/PopWare/OrderConfirmController" method="post">
    	<input type="hidden" name="action" value="cancel" />
        <input type="hidden" name="orderNo" value="<%=order.orderNo%>" />
        <button type="submit">Cancel Order</button>
    </form>
    <% } %>
</div>
</div>
<main>
<%@ include file="footer.jsp"%>

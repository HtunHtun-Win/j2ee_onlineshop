<%@page import="com.mub.models.CartItem"%>
<%@page import="java.util.List"%>
<%@page import="com.mub.models.UserModel"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Shop</title>
<%
String servletPath = request.getServletPath();
String theme = servletPath.substring(servletPath.lastIndexOf("/") + 1);
String pageName = theme.replace(".jsp", "");
List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
int cartCount = 0;
if (cart != null && !cart.isEmpty()) {
	cartCount = cart.size();
}
%>
<link rel="stylesheet" href="/PopWare/assets/css/<%=pageName%>.css" />
<link rel="stylesheet" href="/PopWare/assets/css/header_footer.css" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
</head>
<body>
	<%
	UserModel user = (UserModel) session.getAttribute("token");
	if (user == null) {
		user = new UserModel(0, "Guest", "", "", "", "");
		session.setAttribute("token", user);
	}
	%>
	<div class="container">
		<!-- Sidebar -->
		<nav class="sidebar">
			<div class="shopname">
				<h1>PopWare</h1>
			</div>
			<ul>
				<li><a href="home.jsp">Home</a></li>
				<%
				if (!user.role.equals("")) {
				%>
				<li><a href="#">Orders</a></li>
				<%}%>
				<li><a href="/PopWare/pages/feedback.jsp">Feedback</a></li>
				<li><a href="/PopWare/pages/about.jsp">About Us</a></li>
				<li><a href="/PopWare/Logout">Logout</a></li>
			</ul>
		</nav>
		<!-- Right Side: Header + Content + Footer -->
		<div class="main-layout">
			<!-- Header -->
			<%
			if (!user.role.equals("")) {
			%>
			<header>
				<div class="cart_role">
				<%
				if (user.role.equals("admin")) {
				%>
				<a href="/PopWare/pages/product.jsp">AdminPanel</a>
				<%}%>
					<div class="user-profile">
						<span> <%
 if (user != null) {
 	out.print(user.name);
 }
 %>
						</span> <a href="profile.jsp"> <img
							src="/PopWare/assets/pf_img/default.png" alt="User Profile" />
						</a>

					</div>

					<a href="cart.jsp" class="cart-container"> <img
						src="/PopWare/assets/icons/cartw.png" alt="Cart" width="40"
						height="40" /> <span class="cart-badge"><%= cartCount %></span>
					</a>


				</div>
			</header>
			<%}%>
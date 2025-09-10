<%@page import="com.mub.utils.AuthUtil"%>
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
	if (!AuthUtil.isAdmin(request)) {
		response.sendRedirect("/PopWare/pages/home.jsp");
	}
	%>
	<div class="container">
		<!-- Sidebar -->
		<nav class="sidebar">
			<div class="shopname">
				<a href="/PopWare/pages/home.jsp"><h1>PopWare</h1></a>
			</div>
			<ul>
				<li><a href="/PopWare/pages/user_order_list.jsp">User Orders</a></li>
				<li><a href="/PopWare/ProductController">Product</a></li>
				<li><a href="/PopWare/CategoryController">Category</a></li>
				<li><a href="/PopWare/pages/order_report.jsp">Order Reports</a></li>
				<li><a href="/PopWare/pages/order_item_report.jsp">Order Item Reports</a></li>
				<li><a href="/PopWare/pages/item_by_order.jsp">Item by orders</a></li>
				<li><a href="/PopWare/FeedbackController">User Feedback</a></li>
				<li><a href="/PopWare/UserController">Users</a></li>
				<li><a href="/PopWare/Logout">Logout</a></li>
			</ul>
		</nav>
		<!-- Right Side: Header + Content + Footer -->
		<div class="main-layout">
			<!-- Header -->
			<header>
				<div class="cart_role">
				<b><a href="/PopWare/pages/home.jsp">Home</a></b>
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
				</div>
			</header>
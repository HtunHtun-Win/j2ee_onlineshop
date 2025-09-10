<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Shop</title>
<link rel="stylesheet" href="/PopWare/assets/css/login.css">
</head>
<body>
	<div class="login-container">
		<h2 class="shopname">PopWare</h2>
		<form action="/PopWare/LoginController" method="post">
			<%
			String msg = request.getParameter("msg");
			if (msg != null) {
			%>
			<p style="color: red;"><%=msg%></p>
			<%
			}
			%>
			<label for="username">Email:</label> <input type="email"
				id="username" name="username" required> <label
				for="password">Password:</label> <input type="password"
				id="password" name="password" required>

			<button type="submit">Login</button>
			<h4>
				Don't have an account? <a href="/PopWare/pages/register.jsp">Register</a>
				<br>
				<a href="/PopWare/LoginController" class="guest-btn">Login As Guest</a>
			</h4>
		</form>
	</div>
</body>
</html>
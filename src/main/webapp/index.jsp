<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>StyleHeaven</title>
<link rel="stylesheet" href="assets/css/login.css">
</head>
<body>
	<%
	if (session.getAttribute("token") == null) {
		response.sendRedirect("/PopWare/pages/login.jsp");
	} else {
		response.sendRedirect("/PopWare/pages/home.jsp");
	}
	%>
</body>
</html>
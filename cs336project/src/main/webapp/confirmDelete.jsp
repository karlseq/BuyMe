<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Delete Account</title>
	</head>	
	<body>
	
	<b>Are you sure you want to delete your account?</b>
	<br>
	<br>
		<form method="get" action="deleteAccount.jsp">
			<input type="submit" value="Yes">
		</form>
		<br>
		<form method="get" action="buyorsell.jsp">
			<input type="submit" value="No">
		</form>
	<br>

</body>
</html>
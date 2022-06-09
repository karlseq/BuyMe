<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Login/Register Page</title>
	</head>
	
	<body>
	<h1>Welcome to BuyMe</h1>
	<h2>Login/Register</h2>
	<b>Enter username and password to login:</b>
	<br>
		<form method="get" action="query.jsp">
			<table>
				<tr>    
					<td>Username</td><td><input type="text" name="username"></td>
				</tr>
				<tr>
					<td>Password</td><td><input type="text" name="password"></td>
				</tr>
			</table>
			<input type="submit" value="Login">
		</form>
	<br>
	<br>
	<br>
	<b>Register for new account:</b>
	<br>
		<form method="get" action="createAccount.jsp">
			<table>
				<tr>    
					<td>Username</td><td><input type="text" name="newUsername"></td>
				</tr>
				<tr>
					<td>Password</td><td><input type="text" name="newPassword"></td>
				</tr>
			</table>
			<input type="submit" value="Create new account">
		</form>
	<br>

	</body>
</html>
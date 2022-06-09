<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Customer Rep</title>
	</head>
	
	<body>
	<%String currentUser = (String)session.getAttribute("currentUser"); %>
	<h2>Welcome to BuyMe <%= currentUser%></h2>
	<br>
	<p><a href="questAns.jsp">Manage Question and Answers</a></p>
	<h4>Delete Auction</h4>
		<form method="get" action="deleteAuction.jsp">
			<table>
				<tr>    
					<td>Auction ID</td><td><input type="text" name="itemID"></td>
				</tr>				
			</table>
			<br>
			<input type="submit" value="Delete">
		</form>
		
	<h4>Delete Bid</h4>
		<form method="get" action="deleteBid.jsp">
			<table>
				<tr>    
					<td>Auction ID</td><td><input type="text" name="itemID"></td>
				</tr>
				<tr>    
					<td>Bid Value</td><td><input type="text" name="bidValue"></td>
				</tr>									
			</table>
			<br>
			<input type="submit" value="Delete">
		</form>
	<h4>Reset User Password</h4>
		<form method="get" action="resetPassword.jsp">
			<table>
				<tr>    
					<td>Username</td><td><input type="text" name="username"></td>
				</tr>
				<tr>    
					<td>New Password</td><td><input type="text" name="password"></td>
				</tr>									
			</table>
			<br>
			<input type="submit" value="Reset">
		</form>
		<h4>Delete User Account</h4>
		<form method="get" action="deleteAccount.jsp">
			<table>
				<tr>    
					<td>Username</td><td><input type="text" name="username"></td>
				</tr>
			</table>
			<br>
			<input type="submit" value="Delete">
		</form>
	
	<p><a href="login.jsp">Logout</a></p>

</body>
</html>
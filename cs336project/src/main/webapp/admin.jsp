<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Welcome Admin</title>
	</head>
	
	<body>
	
	<h2>Welcome Administrator</h2>
	<b>Create account for customer rep:</b>
	<br>
		<form method="get" action="createCustomerRepAccount.jsp">
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
    <b>Generate Sales Reports For:</b>
    <br>
    <a href='salesReportProcess.jsp?for=total'>Total Earnings</a>
    <br>
    <a href='salesReportProcess.jsp?for=perItem'>Earnings Per Item</a>
    <br>
    <a href='salesReportProcess.jsp?for=perItemType'>Earnings Per Item Type</a>
    <br>
    <a href='salesReportProcess.jsp?for=perUser'>Earnings Per End-User</a>
    <br>
    <a href='salesReportProcess.jsp?for=bestSelling'>Best-Selling Items</a>
    <br>
    <a href='salesReportProcess.jsp?for=biggestSpenders'>Biggest Spenders</a>


	<br>
	<br>
	<p><a href="login.jsp">Logout</a></p>
	
	</body>
</html>
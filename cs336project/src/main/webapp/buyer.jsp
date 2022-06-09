<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Buyer Page</title>
	</head>
	
	<body>
	
	<h2>Search for vehicles</h2>
	<b>Enter all item information below to start a search:</b>
	<br>
	<br>
		<form method="get" action="displayItemsBuyer.jsp">
			<table>
				<tr>
					<td class = "select">Type of Vehicle</td>
					<td>
					<select name = "typeVehicle">
  						<option value="car">Car</option>
  						<option value="truck">Truck</option>
  						<option value="motorcycle">Motorcycle</option>
					</select>
					</td>
				</tr>
				<tr>    
					<td>Make</td><td><input type="text" name="make"></td>
				</tr>
				<tr>
					<td>Model</td><td><input type="text" name="model"></td>
				</tr>
				<tr>    
					<td>Color</td><td><input type="text" name="color"></td>
				</tr>
			</table>
			<input type="submit" value="Search">
			<br>
			<br>
			<p><a href="buyorsell.jsp">Go back to Buy/Sell Page</a></p>
			<p><a href="login.jsp">Logout</a></p>
			
		</form>
	<br>

</body>
</html>
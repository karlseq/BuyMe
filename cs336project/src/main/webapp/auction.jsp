<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.GregorianCalendar" %>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Auction Page</title>
	</head>
	
	<body>
	
	<h2>Start an auction</h2>
	<b>Enter all item information below to start auction:</b>
	<br>
	<br>
		<form method="get" action="createItem.jsp">
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
					<td>VIN</td><td><input type="text" name="vin"></td>
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
				<tr>
					<td>Initial Price</td><td><input type="text" name="initialPrice"></td>
				</tr>   
        <%
            Calendar cal = new GregorianCalendar();
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm");
            dateFormat.setTimeZone(cal.getTimeZone());
            timeFormat.setTimeZone(cal.getTimeZone());
            String date = dateFormat.format(cal.getTime());
            cal.add(Calendar.MINUTE, 2); // Min auction length is 2 minutes
            String time = timeFormat.format(cal.getTime());
        %>
				<tr>    
					<td>Closing Date/Time</td><td><input type="datetime-local" name="closingTime" min="<%out.print(date);%>T<%out.print(time);%>" required></td>
				</tr>
				<tr>    
					<td>Minimum Selling Price</td><td><input type="text" name="minPrice"></td>
				</tr>
				<tr>
					<td>Bid Increment</td><td><input type="text" name="bidIncrement"></td>
				</tr>
			</table>
			<input type="submit" value="Start Auction">
			<br>
			<br>
			<p><a href="buyorsell.jsp">Go back to Buy/Sell Page</a></p>
		</form>
		<br>
		<br>
		<p><a href="login.jsp">Logout</a></p>

</body>
</html>
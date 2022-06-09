<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Display Auction Vehicles</title>
</head>
<body>
	<%
		try {
			String currentUser = (String)session.getAttribute("currentUser");
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Get the values from the buyer.jsp
			String type = request.getParameter("typeVehicle").trim();
			String str = "select * from Auction_Item where typeOfVehicle='" + type + "'";
			String make = request.getParameter("make").toLowerCase().trim();
			if (make != ""){str += " and make='" + make + "'";}
			String model = request.getParameter("model").toLowerCase().trim();
			if (model != ""){str += " and model='" + model + "'";}
			String color = request.getParameter("color").toLowerCase().trim();
			if (color != ""){str +=" and color='" + color + "'";}
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
		
	%>
	<h3>Vehicles being auctioned</h3>
	<!--  Make an HTML table to show the results in: -->
	<table style="width:50%" border="1" border-collapse="collapse">
		<tr>
			<th>Auction Id</th>  
			<th>Type</th>
			<th>Make</th>
			<th>Model</th>
			<th>Color</th>
			<th>Initial Price</th>
			<th>Bid Increment</th>
			<th>List Date</th>
			<th>Close Date</th>
			<th>Seller</th>
			<th>Current Bid<th>
		</tr>
			<%
			//parse out the results
			while (result.next()) { %>
				<tr>
					<%
					//get auction info like bidValue (current bid) for that itemID 
					Connection con1 = db.getConnection();	
					//Create a SQL statement
					Statement stmt1 = con1.createStatement();
					ResultSet result1 = stmt1.executeQuery("select MAX(bidValue) from Bid where itemID =" + result.getInt("itemID") + ";");
			        result1.next();
			        float maxBid = result1.getFloat("MAX(bidValue)");
					db.closeConnection(con1);
					%>
						<td>
							<%= result.getInt("itemID")%>
						</td>					 
						<td>
							<%= result.getString("typeOfVehicle")%>
						</td>   
						<td>
							<%= result.getString("make")%>
						</td>   
						<td>
							<%= result.getString("model")%>
						</td>   
						<td>
							<%= result.getString("color")%>
						</td>
						<td>
							<%= result.getInt("initialPrice")%>
						</td>
						<td>
							<%= result.getInt("bidIncrement")%>
						</td>
						<td>
							<%= result.getString("listDate")%>
						</td>
						<td>
							<%= result.getString("closingDate")%>
						</td>
						<td>
							<%= result.getString("seller")%>
						<td>
							<%= maxBid%>
						</td>
				</tr>

			<% } %>
		</table>

			
		<%
			//close the connection.
			db.closeConnection(con);
		
		} catch (Exception e) {
			out.print(e);
		}%>
	
		<br>
		<h3>Bid on Auction ID</h3>
		<form method="get" action="createBid.jsp">
			<table>
				<tr>    
					<td>Auction ID</td><td><input type="text" name="itemID"></td>
				</tr>
				<tr>
					<td>Bid Price</td><td><input type="text" name="bidValue"></td>
				</tr>   
				
			</table>
			<br>
			<input type="submit" value="Bid">
			<br>
			<br>
			<p><a href="buyer.jsp">Go back to Search for Vehicles Page</a></p>			
		</form>
		<br>
		<br>
		<p><a href="login.jsp">Logout</a></p>

	</body>
</html>
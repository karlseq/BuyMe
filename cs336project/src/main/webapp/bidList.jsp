<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Display Auctions</title>
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
			/*String type = request.getParameter("typeVehicle").trim();
			String str = "select * from Auction_Item where typeOfVehicle='" + type + "'";
			String make = request.getParameter("make").toLowerCase().trim();
			if (make != ""){str += " and make='" + make + "'";}
			String model = request.getParameter("model").toLowerCase().trim();
			if (model != ""){str += " and model='" + model + "'";}
			String color = request.getParameter("color").toLowerCase().trim();
			if (color != ""){str +=" and color='" + color + "'";}*/
			//Run the query against the database.
			String str = "select * from Auction_Item A, Bid B where A.itemID=B.itemID and "
							+ "B.bidder='" + currentUser + "'";
			ResultSet result = stmt.executeQuery(str);
		
	%>
	<h3>Bids</h3>
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
					/*Connection con1 = db.getConnection();	
					//Create a SQL statement
					Statement stmt1 = con1.createStatement();
					ResultSet result1 = stmt1.executeQuery("SELECT MAX(bidValue) FROM Bid WHERE itemID =" + result.getInt("itemID") + 
															" and bidder='" + currentUser + "'");
			        result1.next();
			        float maxBid = result1.getFloat("MAX(bidValue)");
					db.closeConnection(con1);*/
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
							<%= result.getFloat("bidValue")%>
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
		<br>
		<p><a href="buyorsell.jsp">Go back to Buy/Sell Page</a></p>	
		<p><a href="login.jsp">Logout</a></p>

	</body>
</html>
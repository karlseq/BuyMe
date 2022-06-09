<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Auction Creation</title>
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
			int vin = Integer.parseInt(request.getParameter("vin").trim());
			String make = request.getParameter("make").toLowerCase().trim();
			String model = request.getParameter("model").toLowerCase().trim();
			String color = request.getParameter("color").toLowerCase().trim();
			String typeVehicle = request.getParameter("typeVehicle").toLowerCase();
			float initialPrice = Float.parseFloat(request.getParameter("initialPrice").trim());
			String closingDate = request.getParameter("closingTime");
		    closingDate = closingDate.substring(0,10)+" "+closingDate.substring(11);
		    //String listDate = closingDate;
			float minPrice = Float.parseFloat(request.getParameter("minPrice").trim());
			float bidIncrement = Float.parseFloat(request.getParameter("bidIncrement").trim());
			
			String insert = "INSERT INTO Auction_Item(vin,typeOfVehicle,make,model,color,initialPrice,minPrice,bidIncrement,closingDate,listDate,seller)"
					+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ? ,now(), ?)";
			//Create a Prepared SQL statement allowing you to introduce the parameters of the query
			PreparedStatement ps = con.prepareStatement(insert);
	
			//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
			ps.setInt(1, vin);
			ps.setString(2, typeVehicle);
			ps.setString(3, make);
			ps.setString(4, model);
			ps.setString(5, color);
			ps.setFloat(6, initialPrice);
			ps.setFloat(7, minPrice);
			ps.setFloat(8, bidIncrement);
			ps.setString(9, closingDate);
			ps.setString(10, currentUser);
			//Run the query against the DB
			int result = ps.executeUpdate();

			if (result < 1) {
	            out.println("<p>There was a problem creating your auction <br><a href=\"buyorsell.jsp\">Try Again</a>.</p>");
	        } else {
			//close the connection.
				con.close();			
				out.print("Auction successfully created");
	        }

		} catch (Exception e) {
			out.print("Oops! Error starting auction. Try again.");
		}
	%>
	</body>
	<body>
		<form method="get" action="auction.jsp">
			<table>
				<tr>
			</table>
			<input type="submit" value="Back to Auction page">
		</form>
		<br>
		<br>
		<p><a href="login.jsp">Logout</a></p>
		
	</body>
</html>
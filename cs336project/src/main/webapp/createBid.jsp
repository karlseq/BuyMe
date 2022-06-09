<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Bid Creation</title>
</head>
<body>
	<%
		try {
			String currentUser = (String)session.getAttribute("currentUser");
			
			// Get auction details for that itemID to compare user bid to current auction status
			float maxBid = 0;
    		int itemID = Integer.parseInt(request.getParameter("itemID"));		
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			ResultSet result = stmt.executeQuery("select * from Auction_Item where itemID = " + itemID + ";");
			result.next();

			// store all current values of the auction needed to compare the user bid against.
			// to see if it is violation of bidding constraints set by seller.
			float bidIncrement = result.getInt("bidIncrement");
			float initialPrice = result.getInt("initialPrice");
			//close the connection.
			con.close();			

			Connection con2 = db.getConnection();
			Statement stmt2 = con2.createStatement();
			ResultSet result2 = stmt2.executeQuery("SELECT MAX(bidValue) FROM Bid WHERE itemID =" + itemID + ";");
	        result2.next();
	        maxBid = result2.getFloat("MAX(bidValue)");
			
			float bidValue = Float.parseFloat(request.getParameter("bidValue").trim());
						
			//Check that the bidValue does not violate the bidding contrainst set by the seller.
			if (maxBid == 0) { // very first bid for auction
				if ((bidValue < initialPrice) || (bidValue < (initialPrice+bidIncrement))) { //ERROR
					out.print("Not a valid bid");
					response.sendRedirect("buyer.jsp");
				}
				else {
					Connection con1 = db.getConnection();			
					//Create a SQL statement
					Statement stmt1 = con1.createStatement();
					String insert = "insert into Bid(itemID,bidder,bidValue,bidDate)"
							+ "values (?, ?, ?, now())";			
					//Create a Prepared SQL statement allowing you to introduce the parameters of the query
					PreparedStatement ps1 = con1.prepareStatement(insert);
			
					//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
					ps1.setInt(1, itemID);
					ps1.setString(2, currentUser.trim());
					ps1.setFloat(3, bidValue);
					//Run the query against the DB
					int result1 = ps1.executeUpdate();
					if (result1 < 1) {
			            out.println("<p>There was a problem creating your bid. <br><a href=\"buyorsell.jsp\">Try Again.</a></p>");
			        } else {
					//close the connection.
						con1.close();
						response.sendRedirect("bidAlert.jsp?itemID=" + itemID);
						out.println("<p>Bid successfully created.<br><br><a href=\"auctionList.jsp\">View Bids</a></p>");						
			        }
				}
			}
			else {
				if ((bidValue < maxBid) || (bidValue < (maxBid+bidIncrement))) {
					out.print("Not a valid bid");
					response.sendRedirect("buyer.jsp");
				}
				else {
					Connection con1 = db.getConnection();			
					//Create a SQL statement
					Statement stmt1 = con1.createStatement();
					String insert = "insert into Bid(itemID,bidder,bidValue,bidDate)"
							+ "values (?, ?, ?, now())";			
					//Create a Prepared SQL statement allowing you to introduce the parameters of the query
					PreparedStatement ps1 = con1.prepareStatement(insert);
			
					//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
					ps1.setInt(1, itemID);
					ps1.setString(2, currentUser);
					ps1.setFloat(3, bidValue);
					//Run the query against the DB
					int result1 = ps1.executeUpdate();
					if (result1 < 1) {
			            out.println("<p>There was a problem creating your bid <br><a href=\"buyorsell.jsp\">Try Again</a></p>");
			        } else {
					//close the connection.
						con1.close();
						response.sendRedirect("bidAlert.jsp?itemID=" + itemID);
						out.println("<p>Bid successfully created. <br><br><a href=\"auctionList.jsp\">View Bids</a></p>");
			        }
				}
			}

		} catch (Exception e) {
			out.print("Oops! Error creating. Try again.");
		}
	%>
	</body>
	<body>
		<p><a href="buyer.jsp">Search for Vehicles</a></p>
		<p><a href="buyorsell.jsp">Go back to Buy/Sell Page</a></p>
		<p><a href="login.jsp">Logout</a></p>
		
	</body>
</html>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>

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
            response.setIntHeader("Refresh", 10);
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();	
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			String str = "select * from Auction_Item where seller='" + currentUser + "' order by listDate desc" ;
			ResultSet result = stmt.executeQuery(str);

%>
<h3>Auctions</h3>
<!--  Make an HTML table to show the results in: -->

			
			<!--  Make an HTML table to show the results in: -->
			<table style="width:70%" border="1" border-collapse="collapse">
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
					<th>Current Bid</th>
					<th>Status</th>
					<th>Sold Price</th>
					<th>Buyer</th>
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
							float maxBid = 0;
							int itemID = result.getInt("itemID");
							ResultSet result1 = stmt1.executeQuery("SELECT MAX(bidValue), bidder FROM Bid WHERE itemID =" + result.getInt("itemID")
																	+ " group by bidder");
					        result1.next();
					        maxBid = result1.getFloat("MAX(bidValue)");
					        String buyer = "";
					        float soldPrice = 0;
					        
							String status = "Open";
							if (result.getString("buyer") == null) {
	                        String closingDate = new SimpleDateFormat("MM/dd/yyyy hh:mm:ss").format(result.getTimestamp("closingDate"));
	                        Date date = new Date();
	                        String currentDate = new SimpleDateFormat("MM/dd/yyyy hh:mm:ss").format(date);
	                        SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy hh:mm:ss");
	                        
	                        if (sdf.parse(closingDate).before(sdf.parse(currentDate))) {
	                            out.println("completed");
	                            status = "Completed";
	                            //update buyer in Auction_Item
	                            buyer = result1.getString("bidder");
					        	out.println("buyer is " + buyer);
	                            Connection con4 = db.getConnection();
	        					String query4 = "update Auction_Item set buyer = ?, soldPrice = ? where itemID = ?;";
	        					// Add parameters to query
	        					PreparedStatement ps4 = con.prepareStatement(query4);

	        					ps4.setString(1, buyer);
	        					ps4.setFloat(2, maxBid);
	        					ps4.setInt(3, itemID);
	        					int result4;
	        					result4 = ps4.executeUpdate();

	                            out.println("send alert");
	                		    			Connection con2 = db.getConnection();
	                		    			PreparedStatement psC = null;
	                		                String topic = "Auction Won for auction ID = " + itemID;
	                		                String message = "Congrats. You have won the auction.";
	                		                String query = "INSERT INTO alert (alertUser, alertTopic, alertMsg, isRead) VALUES (?, ?, ?, ?);";
	                		                psC = con2.prepareStatement(query);
	                		                psC.setString(1, buyer);
	                		                psC.setString(2, topic);
	                		                psC.setString(3, message);
	                		                psC.setBoolean(4, false);
	                		                int result2;
	                		                int finalResult = 1;
	                		                result2 = psC.executeUpdate();
	                		                if (result2 < 1) {
	                		                    finalResult = 0;
	                		                }
	                		        		if (finalResult < 1) {
	                		        		} else {
	                		            		out.println("Auction has closed, but winner of the bid was failed to be notified");
	                		        		}
	                		        		db.closeConnection(con2);
	                        }
							} else {
								buyer = result.getString("buyer");
								status = "Completed";
							}


							//db.closeConnection(con1);
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
								</td>
								<td>
									<%= result1.getFloat("MAX(bidValue)")%>
								</td>
								<td>
									<%= status %>
								</td>								
								<td>
									<%= result.getFloat("soldPrice")%>
								</td>
								<td>
									<%= buyer %>
								</td>								
								
						</tr>

					<% 
					db.closeConnection(con1);
					}
					%>
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
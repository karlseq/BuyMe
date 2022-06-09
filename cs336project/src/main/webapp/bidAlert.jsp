<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Bid Alert</title>
</head>
<body>
	<%
		try {
			
			String currentUser = (String)session.getAttribute("currentUser");
			ApplicationDB dbA = new ApplicationDB();
		    Connection connA = null;
		    Statement stA = null;
		    ResultSet rsA = null;
		    Connection connB = null;
		    Statement stB = null;
		    ResultSet rsB = null;
		    Connection connC = null;
		    PreparedStatement psC = null;
		    ArrayList<String> bidderList = new ArrayList<String>();
		    String maxBidder = "";
		    int finalResult = 1;
		    int itemID = Integer.parseInt(request.getParameter("itemID"));
		    try {
		        // Open DB Connection and get parameters
		        connA = dbA.getConnection();
		        stA = connA.createStatement();
		        rsA = stA.executeQuery("SELECT * FROM bid WHERE itemID =" + itemID + " AND bidValue = (Select MAX(bidValue) from bid where itemID = " + itemID + ")");
		        if (rsA.next()) {
		            maxBidder = rsA.getString("bidder");
		        } else {
		            out.println("There are no other bids.");
		        }
		    } catch (SQLException se) {
		        out.print("<p>Error connecting to MYSQL server.</p>");
		        se.printStackTrace();
		    } catch (Exception e) {
		        e.printStackTrace();
		    } finally {
		        // Close
		        try {
		            if (rsA != null) rsA.close();
		        } catch (Exception e) {
		            e.printStackTrace();
		        }
		        try {
		            if (stA != null) stA.close();
		        } catch (Exception e) {
		            e.printStackTrace();
		        }
		        try {
		            if (connA != null) dbA.closeConnection(connA);
		        } catch (Exception e) {
		            e.printStackTrace();
		        }
		    }
		    try {
		        if (maxBidder.equals("")) {
		            out.println("There is no Bid");
		        }
		        connB = dbA.getConnection();
		        stB = connB.createStatement();
		        rsB = stB.executeQuery("SELECT * FROM bid WHERE itemID='" + itemID + "' ORDER BY bidValue asc;");
		        if (rsB.next()) {
		            do {
		                String bidder = rsB.getString("bidder");
		                if (!bidder.equals(maxBidder)) {
		                    if (bidderList.contains(bidder)) {
		                        continue;
		                    } else {
		                        bidderList.add(bidder);
		                    }
		                }
		            } while (rsB.next());
		        }
		    } catch (Exception se) {
		        se.printStackTrace();
		    } finally {
		        // Close
		        try {
		            if (rsB != null) rsB.close();
		        } catch (Exception e) {
		            e.printStackTrace();
		        }
		        try {
		            if (stB != null) stB.close();
		        } catch (Exception e) {
		            e.printStackTrace();
		        }
		        try {
		            if (connB != null) dbA.closeConnection(connB);
		        } catch (Exception e) {
		            e.printStackTrace();
		        }
		    }
		    try {
		        connC = dbA.getConnection();
		        for (String bidder : bidderList) {
		            if (!bidder.equals(maxBidder)) {
		                String topic = "Higher Bid on itemID = " + itemID;
		                String message = "Another user has placed a bid that is higher than your bid.";
		                String query = "INSERT INTO alert (alertUser, alertTopic, alertMsg, isRead) VALUES (?, ?, ?, ?);";
		                psC = connC.prepareStatement(query);
		                psC.setString(1, bidder);
		                psC.setString(2, topic);
		                psC.setString(3, message);
		                psC.setBoolean(4, false);
		                int result;
		                result = psC.executeUpdate();
		                if (result < 1) {
		                    finalResult = 0;
		                }
		            }
		        }
		        if (finalResult < 1) {
		        } else {
		            out.println("Other users have been notified of bid placement.");
		        }
		    } catch (Exception se) {
		        se.printStackTrace();
		    } finally {
		        try {
		            if (psC != null) psC.close();
		        } catch (Exception e) {
		            e.printStackTrace();
		        }
		        try {
		            if (connC != null) dbA.closeConnection(connC);
		        } catch (Exception e) {
		            e.printStackTrace();
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

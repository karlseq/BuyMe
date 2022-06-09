<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Auction Deletion</title>
</head>
<body>
	<%
		try {
			String currentUser = (String)session.getAttribute("currentUser");
			//Get the database connection
			PreparedStatement psAlert;
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			int itemID = Integer.parseInt(request.getParameter("itemID").trim());
			String str = "select * from Auction_Item where itemID= " + itemID;
			ResultSet result1 = stmt.executeQuery(str);
			String seller = null;
			while (result1.next()) {
				seller = result1.getString("seller");
			}
			String delete = "delete from Auction_Item where itemID = " + itemID;
			//Create a Prepared SQL statement allowing you to introduce the parameters of the query
			PreparedStatement ps = con.prepareStatement(delete);
			
			int result = ps.executeUpdate();

			if (result < 1) {
	            out.println("<p>There was a problem deleting the auction <br><a href=\"customerRep.jsp\">Try Again</a>.</p>");
	        } else {
			//close the connection.
				con.close();			
	            con = db.getConnection();
	            String topic = "Auction Deletion";
	            String message = "Auction for item ID "+itemID+" was deleted by Customer Representative";
	            String query = "insert into alert (alertUser, alertTopic, alertMsg, isRead) values (?, ?, ?, ?);";
	            psAlert = con.prepareStatement(query);
	            // Add parameters to query
	            psAlert.setString(1, seller);
	            psAlert.setString(2, topic);
	            psAlert.setString(3, message);
	            psAlert.setBoolean(4, false);
	            int result2 = psAlert.executeUpdate();
	            if (result2 < 1) {
	                out.println("<div class=\"container signin\"><p>Error: Alert to inform user was not created but auction was deleted. <br> <br><a href=\"customerRep.jsp\">Back to customer rep page</a>.</p></div>");
	            } else {
	                out.println("<div class=\"container signin\"><p>Auction deleted successfully <br> <br><a href=\"customerRep.jsp\">Back to customer rep page</a>.</p></div>");
	            }
	        }

		} catch (Exception e) {
			out.print("Oops! Error deleting auction. Try again.");
		}
	%>
	</body>
	<body>
		<br>
		<p><a href="login.jsp">Logout</a></p>
		
	</body>
</html>
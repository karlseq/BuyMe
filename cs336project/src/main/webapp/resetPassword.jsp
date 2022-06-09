<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Password Resetting</title>
</head>
<body>
	<%
		try {
			String currentUser = (String)session.getAttribute("currentUser");
			//Get the database connection
			//PreparedStatement psAlert;
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			String username = request.getParameter("username").trim();
			String password = request.getParameter("password").trim();

			//Statement stmt = con.createStatement();
			String reset = "update Users set passwrd = ? where username = ?;";
			//Create a Prepared SQL statement allowing you to introduce the parameters of the query
			PreparedStatement ps = con.prepareStatement(reset);
	        ps.setString(1, password);
	        ps.setString(2, username);
			int result = ps.executeUpdate();

			if (result < 1) {
	            out.println("<p>There was a problem resetting the password <br><a href=\"customerRep.jsp\">Try Again</a>.</p>");
	        } else {
			//close the connection.
				con.close();				
				Connection con1 = db.getConnection();
	            String topic = "Password reset";
	            String message = "Password for user '" +  username + "' was reset by Customer Representative";
	            String query = "insert into Alert (alertUser, alertTopic, alertMsg, isRead) values (?, ?, ?, ?)";
	            PreparedStatement ps1 = con1.prepareStatement(query);
	            // Add parameters to query
	            ps1.setString(1, username);
	            ps1.setString(2, topic);
	            ps1.setString(3, message);
	            ps1.setBoolean(4, false);
	            int result1 = ps1.executeUpdate();
	            if (result1 < 1) {
	                out.println("<div class=\"container signin\"><p>Error: Alert to inform user was not created but password was reset. <br> <br><a href=\"customerRep.jsp\">Back to customer rep page</a>.</p></div>");
	            } else {
	            	con1.close();
	                out.println("<div class=\"container signin\"><p>Password reset successfully <br> <br><a href=\"customerRep.jsp\">Back to customer rep page</a>.</p></div>");
	            }

	        }

		} catch (Exception e) {
			out.print("Oops! Error resetting password. Try again.");
		}
	%>
	</body>
	<body>
		<br>
		<p><a href="login.jsp">Logout</a></p>
		
	</body>
</html>
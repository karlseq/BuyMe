<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Delete Account</title>
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
			String username = request.getParameter("username").trim();
			String str = "delete from Users where username='" + username + "'";
			
			int result = stmt.executeUpdate(str);
			
			if (result < 1) {
	            out.println("<p>There was a problem deleting the account <br><a href=\"customerRep.jsp\">Try Again</a>.</p>");
	        } else {
				//close the connection.
				con.close();
				//no alert will be send as the user account no longer exists
				//out.println("<p>Account successfully deleted ");
                out.println("<div class=\"container signin\"><p>Account deleted successfully <br> <br><a href=\"customerRep.jsp\">Back to customer rep page</a>.</p></div>");

	        }

		} catch (Exception e) {
			out.print("Oops! Error deleting. Try again.");
		}
	%>
	</body>
	<body>
		<br>
		<p><a href="login.jsp">Logout</a></p>
			
</body>
</html>
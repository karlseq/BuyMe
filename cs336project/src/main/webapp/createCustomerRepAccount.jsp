<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Customer Rep Account Creation Check</title>
</head>
<body>
	<%	
		try {

			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Get the combobox from the index.jsp
			String username = request.getParameter("newUsername");
			String password = request.getParameter("newPassword");
			
			if (username=="" || password=="") { //username and/or password is not filled
				out.print("Oops! Username or Password has not been filled. Try again.");
			}
			else {
			String insert = "INSERT INTO Users(username, passwrd, isAdmin, isCustomerRep)"
					+ "VALUES (?, ?, ?, ?)";
			//Create a Prepared SQL statement allowing you to introduce the parameters of the query
			PreparedStatement ps = con.prepareStatement(insert);
	
			//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
			ps.setString(1, username);
			ps.setString(2, password);
			ps.setBoolean(3, false);
			ps.setBoolean(4, true);
			//Run the query against the DB
			ps.executeUpdate();			
			out.print("Customer Rep Account successfully created!");
			
			}
			//close the connection.
			con.close();

		} catch (Exception e) {
			out.print("Oops! Error encountered. Try again.");
		}
	%>
	</body>
	<body>
		<form method="get" action="admin.jsp">
			<table>
				<tr>
			</table>
			<input type="submit" value="Back to Admin page">
		</form>
		<br>
		<br>
		<p><a href="login.jsp">Logout</a></p>
		
	</body>
</html>
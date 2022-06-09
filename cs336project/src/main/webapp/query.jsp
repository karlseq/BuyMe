<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Login Check</title>
</head>
<body>
	<%
		String currentUser = "";

		try {
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Get the combobox from the index.jsp
			String username = request.getParameter("username");
			String password = request.getParameter("password");
			//Class.forName("com.mysql.jdbc.Driver");
			//Make a SELECT query from the sells table with the price range specified by the 'price' parameter at the index.jsp
			//String str = "SELECT * FROM Login WHERE username=" + username + "and passwrd=" + password;
			String str = "select * from Users where username='" + username + "' and passwrd='" + password + "'";

			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
			String actualUsername = "";
			String actualPassword = "";
			boolean isAdmin = false, isCustomerRep = false;
			while (result.next()) {
				actualUsername = result.getString("username");
				actualPassword = result.getString("passwrd");
				isAdmin = result.getBoolean("isAdmin");
				isCustomerRep = result.getBoolean("isCustomerRep");
			}
			if (actualUsername=="" || actualPassword=="") { //username and/or password are not filled
				out.print("Oops! Incorrect username or password. Try again.");
				//response.sendRedirect("login.jsp");
			}
			else {
				if (actualUsername.equals(username) && actualPassword.equals(password)) {
					currentUser = username;
					session.setAttribute("currentUser", currentUser);
					out.print("Successfully logged on! Welcome " + username);
					if (isAdmin==true && isCustomerRep==false) {
						response.sendRedirect("admin.jsp");
					}
					else if (isAdmin==false && isCustomerRep==true) {
						response.sendRedirect("customerRep.jsp");
					}
					else { //customer (buyer or seller) is logging in
						response.sendRedirect("buyorsell.jsp");
					}
					
				}
				else {
					out.print("Oops! Username or Password did not match. Try again.");
					//response.sendRedirect("login.jsp");
				}
			}

			//close the connection.
			con.close();

		} catch (Exception e) {
			out.print("Oops! Error encountered. Try again.");
		}
	%>
	</body>
	<body>
		<form method="get" action="login.jsp">
			<table>
				<tr>
			</table>
			<input type="submit" value="Back to Login/Register page">
		</form>
		
	</body>
</html>
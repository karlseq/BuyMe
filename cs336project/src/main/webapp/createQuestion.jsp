<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Question Creation</title>
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
			String topic = request.getParameter("topic").trim();
			String question = request.getParameter("question").trim();			
			String insert = "INSERT INTO Question(topic,question,askedBy,askDate)"
					+ "VALUES (?, ?, ?, now())";
			//Create a Prepared SQL statement allowing you to introduce the parameters of the query
			PreparedStatement ps = con.prepareStatement(insert);
	
			//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
			ps.setString(1, topic);
			ps.setString(2, question);
			ps.setString(3, currentUser);
			//Run the query against the DB
			int result = ps.executeUpdate();

			if (result < 1) {
	            out.println("<p>There was a problem creating your question <br><a href=\"question.jsp\">Try Again</a>.</p>");
	        } else {
			//close the connection.
				con.close();	
				out.println("<p><br>Your question will be answered by a customer rep <br><br><a href=\"questAns.jsp\">Go to question list</a>.</p>");
			}

		} catch (Exception e) {
			out.print("Oops! Error starting auction. Try again.");
		}
	%>
	</body>
	<body>
		<p><a href="buyorsell.jsp">Go back to Buy/Sell Page</a></p>
		<br>
		<p><a href="login.jsp">Logout</a></p>
		
	</body>
</html>
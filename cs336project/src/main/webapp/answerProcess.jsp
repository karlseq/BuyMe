<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.text.SimpleDateFormat" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Display Questions and Answers</title>
</head>
<body>
		<%
		try {
			String currentUser = (String)session.getAttribute("currentUser");
			String answer = request.getParameter("answer");
	        int questionID = Integer.parseInt(request.getParameter("qid"));
	        
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			//Statement stmt = con.createStatement();
			//Create a SQL statement

	        // Build the SQL query with placeholders for parameters
	        String query = "update Question set answer = ?, answerBy = ?, answerDate = now() where questionID = ?;";
	        // Add parameters to query
	        PreparedStatement ps = con.prepareStatement(query);

	        ps.setString(1, answer);
	        ps.setString(2, currentUser);
	        ps.setInt(3, questionID);
	        int result;
	        result = ps.executeUpdate();
	        if (result < 1) {
	            out.println("<div class=\"container signin\"><p>There was a problem processing your answer <br><a href=\"quest.jsp\">Try Again</a>.</p> </div>");
	        } else {
	            out.println("<div class=\"container signin\"><p>You have answered the question <br><a href=\" questAns.jsp\">Go back to questions list</a>.</p> </div>");
	        }

			//close the connection.
			db.closeConnection(con);			
			} catch (Exception e) {
				out.print(e);
			}%>
		</body>
	</html>
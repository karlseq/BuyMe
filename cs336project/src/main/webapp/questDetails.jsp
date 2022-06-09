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
			int questID = Integer.parseInt(request.getParameter("qid"));

			int isAdmin = 0;
			int isCustomerRep = 0;
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con1 = db.getConnection();	
			
			//Create a SQL statement
			Statement stmt1 = con1.createStatement();			
			//get current user info
			String str1 = "select * from Users where username='" + currentUser + "'";
			ResultSet result1 = stmt1.executeQuery(str1);
			while (result1.next()) {
			isAdmin = result1.getInt("isAdmin");
			isCustomerRep = result1.getInt("isCustomerRep");
			}
			db.closeConnection(con1);
			
			Connection con = db.getConnection();	
			//Create a SQL statement
			Statement stmt = con.createStatement();	
			String str = "select * from Question where questionID=" + questID + "";
			ResultSet rs = stmt.executeQuery(str);
			out.print("<h3>Question and Answer Details</h3>");
			
			if (!rs.next()) {
        		out.print("<h4>No questions asked yet</h4>");
			} else {
        		do {
            		int questionId = rs.getInt("questionID");
            		String topic = rs.getString("topic");
            		String question = rs.getString("question");
            		String askedBy = rs.getString("askedBy");
            		String askDate = new SimpleDateFormat("MM/dd/yyyy hh:mm:ss a").format(rs.getTimestamp("askDate"));
            		String answerBy = rs.getString("answerBy");
            		String answer = rs.getString("answer");
            %>
            		<form action="answerProcess.jsp?qid=<%out.println(questionId);%>" method="POST">
            	    	<h4>Topic: <%out.println(topic);%></h4>
            	        <label for="question"><b>Question</b></label>
            	        <br>
            	        <textarea name="question" id="question" readonly> <%out.println(question);%></textarea>
            	        <br>
            	        <label for="answer"><b>Answer</b></label>
            	        <br>
        				<%if ( isCustomerRep == 1) {%>
        					<textarea name="answer" id="answer"><%if (answer!=null) { out.print(answer); } else { out.print(""); }%></textarea>
        					<br>

        					<button type="submit" class="loginbtn">Answer Question/Update Answer</button>
        				<%} else { %>
        					<textarea name="answer" id="answer" readonly> <%if (answer!=null) { out.print(answer); } else { out.print(""); }%></textarea>
        				<br>
        				<% } %>
            		</form>
            <%
        		} while(rs.next());
			}
			
			//close the connection.
			db.closeConnection(con);			
			} catch (Exception e) {
				out.print(e);
			}%>
			<p><a href="questAns.jsp">View Question and Answers</a></p>		
			<p><a href="login.jsp">Logout</a></p>
		</body>
	</html>
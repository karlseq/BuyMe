<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Post Questions</title>
	</head>
	
	<body>
	
	<h2>Post a question</h2>
	<b>Enter all information below to post a question:</b>
	<form method="get" action="createQuestion.jsp">
		<br>
		<table>
		<tr>
		<td class = "select">Topic</td>
					<td>
					<select name = "topic">
  						<option value="Delete Auction">Delete Auction (provide Auction ID)</option>
  						<option value="Delete Bid">Delete Bid (provide Auction ID and Bid Value)</option>
  						<option value="Reset Password">Reset Password</option>
  						<option value="Delete Account">Delete Account</option>
  						<option value="Other">Other</option>
					</select>
					</td>
		</tr>
		</table>
		<br>
        <label for="question">Question</label>
        <br>
        <br>
        <textarea name="question" id="question"></textarea>
        <br>
        <br>
			<input type="submit" value="Post">
			<br>
			<br>
			<p><a href="questAns.jsp">View Question and Answers</a></p>
			<p><a href="buyorsell.jsp">Go back to Buy/Sell Page</a></p>
			<p><a href="login.jsp">Logout</a></p>			
		</form>
	<br>

</body>
</html>

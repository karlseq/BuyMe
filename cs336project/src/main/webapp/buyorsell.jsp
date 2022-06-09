<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Buy or Sell</title>
	</head>
	
	<body>
	<%String currentUser = (String)session.getAttribute("currentUser"); %>
	<h2>Welcome to BuyMe, <%= currentUser%></h2>
	<b>Would you like to buy or sell an item?</b>
	<br>
	<br>
		<form method="get" action="buyer.jsp">
			<input type="submit" value="Buy Item">
		</form>
		<br>
		<form method="get" action="auction.jsp">
			<input type="submit" value="Sell Item">
		</form>
	<br>
	<br>
	<p><a href="bidList.jsp">View your Bids</a></p>
	<p><a href="auctionList.jsp">View your Auctions</a></p>
	<p><a href="question.jsp">Ask a question to the Customer Representative</a></p>
	<p><a href="questAns.jsp">View Question and Answers</a></p>	
	<p><a href="login.jsp">Logout</a></p>

</body>
</html>
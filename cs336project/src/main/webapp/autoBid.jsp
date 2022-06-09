<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="java.text.NumberFormat" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Customer Rep</title>
	</head>
	<body>
	
<form action="autobidPlaceProcess.jsp" method="POST">
    <div class="container">
        <h1>Place an Auto-bid</h1>
        <p>Please fill in this form to set up your auto-bid.</p>
        <hr>
        <%double bidValue = Double.parseDouble(request.getParameter("bidValue")); %>
        <label for="bidValue">Bid Amount</label>
        <input type="number" id="bidValue" name="bidValue" placeholder="Enter a Bid That is <%out.print(NumberFormat.getCurrencyInstance().format(bidValue+1.00));%> or Higher" min="<%out.print(bidValue+1.00);%>" step="0.01" required>

        <label for="ceiling">Price Ceiling</label>
        <input type="number" placeholder="Enter the maximum amount you would bid in USD" name="ceiling" id="ceiling" min="<%out.print(bidValue+1.00);%>" required>

        <label for="increment">Bid Increment Amount</label>
        <input type='number' placeholder='Enter the amount to increment above the current highest bid in USD' name='increment' id='increment' min="1" required>

        <input type='hidden' name='listingID' value="<% out.println(request.getParameter("listingId2")); %>">

        <button type="submit" class="registerbtn">Submit</button>
    </div>
</form>
	<br>

</body>
</html>
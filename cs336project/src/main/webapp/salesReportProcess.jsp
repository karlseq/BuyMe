<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.text.NumberFormat" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Sales Report</title>
</head>
	<body>
    <%
		ApplicationDB db = new ApplicationDB();
        String salesReport = request.getParameter("for");
        Connection conn = null;
        Statement st = null;
        ResultSet rs = null;
    %>

    <% try {
        // Open DB Connection and get parameters
        conn = db.getConnection();
        st = conn.createStatement();
        Locale locale = new Locale("en", "US");
        NumberFormat currency = NumberFormat.getCurrencyInstance(locale);
        // Create query for login validation
        if (salesReport.equals("total")) {
            out.print("<table class=\"center\" style=\"width: 15%;\">");
            //out.print("<caption style=\"text-align: center;\">Total Earnings</caption>");
            out.print("<tr> <th style=\"text-align: center;\">Total Earnings</th> </tr>");
            rs = st.executeQuery("SELECT SUM(minPrice) AS `Total Earnings` FROM Auction_Item;");
            if (!rs.next()) {
                out.print("<tr> <td style=\"text-align:center\">No earnings recorded</td> </tr>");
            } else {
                do {
                    double earnings = rs.getDouble("Total Earnings");
                    out.print("<tr> <td style=\"text-align: center;\">" + currency.format(earnings) + "</td> </tr>");
                } while (rs.next());
            }
            out.print("</table>");
        } else if (salesReport.equals("perItem")) {
            out.print("<table class=\"center\">");
            out.print("<caption style=\"text-align: center;\">Earnings Per Item</caption>");
            out.print("<tr>");
            out.print("<th style=\"text-align: center;\">Model</th>");
            out.print("<th style=\"text-align: center;\">Quantity</th>");
            out.print("<th style=\"text-align: center;\">Earnings</th>");
            out.print("</tr>");
            rs = st.executeQuery("SELECT model AS Model, COUNT(model) AS Quantity, SUM(minPrice) AS Earnings " +
                    "FROM Auction_Item " +
                    "GROUP BY model;");
            if (!rs.next()) {
                out.print("<tr> <td  colspan=\"4\" style=\"text-align:center\">No earnings recorded</td> </tr>");
            } else {
                do {
                    String model = rs.getString("Model");
                    int quantity = rs.getInt("Quantity");
                    double earnings = rs.getDouble("Earnings");
                    out.print("<tr>");
                    out.print("<td style=\"text-align: left;\">" + model + "</td>");
                    out.print("<td style=\"text-align: left;\">" + quantity + "</td>");
                    out.print("<td style=\"text-align: left;\">" + currency.format(earnings) + "</td>");
                    out.print("</tr>");
                } while (rs.next());
            }
            out.print("</table>");
        } else if (salesReport.equals("perItemType")) {
            out.print("<table class=\"center\">");
            out.print("<caption style=\"text-align: center;\">Earnings Per Item Type</caption>");
            out.print("<tr>");
            out.print("<th style=\"text-align: center;\">Item Type</th>");
            out.print("<th style=\"text-align: center;\">Earnings</th>");
            out.print("</tr>");
            rs = st.executeQuery("SELECT typeOfVehicle AS `Item Type`, SUM(minPrice) AS `Earnings` " +
                    "FROM Auction_Item " +
                    "GROUP BY typeOfVehicle;");
            if (!rs.next()) {
                out.print("<tr> <td  colspan=\"2\" style=\"text-align:center\">No earnings recorded</td> </tr>");
            } else {
                do {
                    String itemType = rs.getString("Item Type");
                    double earnings = rs.getDouble("Earnings");
                    out.print("<tr>");
                    out.print("<td style=\"text-align: left;\">" + itemType + "</td>");
                    out.print("<td style=\"text-align: left;\">" + currency.format(earnings) + "</td>");
                    out.print("</tr>");
                } while (rs.next());
            }
            out.print("</table>");
        } else if (salesReport.equals("perUser")) {
            out.print("<table class=\"center\">");
            out.print("<caption style=\"text-align: center;\">Earnings Per End-User</caption>");
            out.print("<tr>");
            out.print("<th style=\"text-align: center;\">username</th>");
            out.print("<th style=\"text-align: center;\">Earnings</th>");
            out.print("</tr>");
            rs = st.executeQuery("SELECT a.username, SUM(aI.minPrice) AS Earnings " +
                    "FROM Users a INNER JOIN Auction_Item aI " +
                    "ON a.username = aI.seller " +
                    "GROUP BY aI.seller;");
            if (!rs.next()) {
                out.print("<tr> <td  colspan=\"4\" style=\"text-align:center\">No earnings recorded</td> </tr>");
            } else {
                do {
                    String username = rs.getString("username");
                    double earnings = rs.getDouble("Earnings");
                    out.print("<tr>");
                    out.print("<td style=\"text-align: left;\">" + "<a href=\"userProfile.jsp?userProfile=" + username + "\">" + username + "</a>" + "</td>");
                    out.print("<td style=\"text-align: left;\">" + currency.format(earnings) + "</td>");
                    out.print("</tr>");
                } while (rs.next());
            }
            out.print("</table>");
        } else if (salesReport.equals("bestSelling")) {
            out.print("<table class=\"center\">");
            out.print("<caption style=\"text-align: center;\">Top 5 Selling Items</caption>");
            out.print("<tr>");
            out.print("<th style=\"text-align: center;\">Manufacturer</th>");
            out.print("<th style=\"text-align: center;\">Model</th>");
            out.print("<th style=\"text-align: center;\">Quantity</th>");
            out.print("<th style=\"text-align: center;\">Earnings</th>");
            out.print("</tr>");
            rs = st.executeQuery("SELECT model AS Model, COUNT(model) AS Quantity, SUM(minPrice) AS Earnings " +
                    "FROM Auction_Item " +
                    "WHERE minPrice IS NOT NULL " +
                    "GROUP BY model " +
                    "ORDER BY Quantity DESC " +
                    "LIMIT 5;");
            if (!rs.next()) {
                out.print("<tr> <td  colspan=\"4\" style=\"text-align:center\">No earnings recorded</td> </tr>");
            } else {
                do {
                    String model = rs.getString("Model");
                    int quantity = rs.getInt("Quantity");
                    double earnings = rs.getDouble("Earnings");
                    out.print("<tr>");
                    out.print("<td style=\"text-align: left;\">" + model + "</td>");
                    out.print("<td style=\"text-align: left;\">" + quantity + "</td>");
                    out.print("<td style=\"text-align: left;\">" + currency.format(earnings) + "</td>");
                    out.print("</tr>");
                } while (rs.next());
            }
            out.print("</table>");
        } else if (salesReport.equals("biggestSpenders")) {
            out.print("<table class=\"center\">");
            out.print("<caption style=\"text-align: center;\">Top 5 Biggest Spenders</caption>");
            out.print("<tr>");
            out.print("<th style=\"text-align: center;\">username</th>");
            out.print("<th style=\"text-align: center;\">Total Money Spent</th>");
            out.print("</tr>");
            rs = st.executeQuery("SELECT a.username, SUM(aI.minPrice) AS `Total Money Spent` " +
                    "FROM Users a INNER JOIN Auction_Item aI " +
                    "ON a.username = aI.buyer " +
                    "GROUP BY aI.buyer " +
                    "ORDER BY `Total Money Spent` " +
                    "DESC LIMIT 5;");
            if (!rs.next()) {
                out.print("<tr> <td  colspan=\"4\" style=\"text-align:center\">No earnings recorded</td> </tr>");
            } else {
                do {
                    String username = rs.getString("username");
                    double spendings = rs.getDouble("Total Money Spent");
                    out.print("<tr>");
                    out.print("<td style=\"text-align: left;\">" + "<a href=\"userProfile.jsp?userProfile=" + username + "\">" + username + "</a>" + "</td>");
                    out.print("<td style=\"text-align: left;\">" + currency.format(spendings) + "</td>");
                    out.print("</tr>");
                } while (rs.next());
            }
            out.print("</table>");
        }
    } catch (SQLException se) {
        out.print("<p>Error connecting to MYSQL server.</p>");
        se.printStackTrace();
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        // Close
        try {
            if (rs != null) rs.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        try {
            if (st != null) st.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        try {
            if (conn != null) db.closeConnection(conn);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    %>
    <br>
    <p ><a href="admin.jsp">Go back to Admin Page</a>.</p>
    

	</body>
</html>
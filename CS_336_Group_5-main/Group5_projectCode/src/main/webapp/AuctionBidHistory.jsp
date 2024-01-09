<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="group5.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

	<%
    	if (session == null || session.getAttribute("username") == null) {
    		response.sendRedirect("LandingPage.jsp");
    	}
    %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>User Participation History</title>
</head>
<body>

		<h1>Auction Bid History</h1>
	    
	    <%     

		// Handle newQuestion insertion for END users
	
		    try {
		    	
		    	ApplicationDB db = new ApplicationDB();
				Connection con = db.getConnection();

				if (request.getParameter("auctionID") == null) {
					response.sendRedirect("HomePage.jsp");
				}
				
				//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
				String query = "SELECT bid_id, bidder_username, amount FROM auction JOIN bid USING (auction_id) WHERE auction_id = ? ORDER BY bid_id DESC";
				//Run the query against the database.
				PreparedStatement ps = con.prepareStatement(query);
				ps.setString(1,request.getParameter("auctionID"));
				ResultSet rs = ps.executeQuery();
				
				out.print("<style>");
			    out.print("table { border-collapse: collapse; width: 100%; }");
			    out.print("th, td { border: 1px solid black; padding: 8px; text-align: center; }");
			    out.print("</style>");
	
			    out.print("<table>");
			    
			    // Create header row with column names
			    out.print("<tr>");
			    out.print("<th>Bid ID</th>");
			    out.print("<th>Bidder</th>");
			    out.print("<th>Bid Amount</th>");
			    out.print("</tr>");
	
			    // Parse and display the results
			    while (rs.next()) {
			        out.print("<tr>");
			        out.print("<td>" + rs.getString("bid_id") + "</td>");
			        out.print("<td><a href='ParticipationHistory.jsp?username=" + rs.getString("bidder_username") + "'>" + rs.getString("bidder_username") + "</a></td>");
			        out.print("<td>$ " + rs.getString("amount") + "</td>");
			        out.print("</tr>");
			    }
	
			    out.print("</table>");
			
		    } catch (Exception e) {
                e.printStackTrace();
            }
			    
		
		%>
</body>
</html>

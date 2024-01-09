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

		<h1>Participation History</h1>
	    
	    <%     

		// Handle newQuestion insertion for END users
	
		    try {
		    	
		    	ApplicationDB db = new ApplicationDB();
				Connection con = db.getConnection();

				String username = request.getParameter("username") == null ? session.getAttribute("username").toString() : request.getParameter("username"); 
		    	//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
				String query = "SELECT DISTINCT auction_id FROM auction JOIN bid USING (auction_id) WHERE seller_username = ? OR bidder_username = ?";
				//Run the query against the database.
				PreparedStatement ps = con.prepareStatement(query);
				ps.setString(1,username);
				ps.setString(2,username);
				ResultSet rs = ps.executeQuery();
				
				out.print("<style>");
			    out.print("table { border-collapse: collapse; width: 100%; }");
			    out.print("th, td { border: 1px solid black; padding: 8px; text-align: center; }");
			    out.print("</style>");
	
			    out.print("<table>");
			    
			    // Create header row with column names
			    out.print("<tr>");
			    out.print("<th>Auction ID</th>");
			    out.print("</tr>");
	
			    // Parse and display the results
			    while (rs.next()) {
			        out.print("<tr>");
			        out.print("<td><a href='Auction.jsp?auctionID=" + rs.getString("auction_id") + "'>" + rs.getString("auction_id") + "</a></td>");
			        out.print("</tr>");
			    }
	
			    out.print("</table>");
			
		    } catch (Exception e) {
                e.printStackTrace();
            }
			    
		
		%>
		<br>
	    <form action="HomePage.jsp" method="post">
	        <input type="submit" value="Home">
	    </form>
		<br>
		  <form action="LandingPage.jsp" method="post">
	        <input type="submit" value="Log Out">
	    </form>
</body>
</html>

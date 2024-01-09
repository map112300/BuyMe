<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="group5.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
    
    <%
    	if (session == null || session.getAttribute("username") ==  null) {
    		response.sendRedirect("LandingPage.jsp");
    	}
    %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>This is the list of all current bids</title>
</head>

	<%
	
			try {
				
				//Get the database connection
				ApplicationDB db = new ApplicationDB();	
				Connection con = db.getConnection();		

				//Create a SQL statement
				Statement stmt = con.createStatement();
				//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
				String str = "SELECT * FROM bid";
				//Run the query against the database.
				ResultSet result = stmt.executeQuery(str);
				
				out.print("<style>");
			    out.print("table { border-collapse: collapse; width: 100%; }");
			    out.print("th, td { border: 1px solid black; padding: 8px; text-align: left; }");
			    out.print("</style>");

			    out.print("<table>");
			    
			    // Create header row with column names
			    out.print("<tr>");
			    out.print("<th>Bid ID</th>");
			    out.print("<th>Auction ID</th>");
			    out.print("<th>Bid Username</th>");
			    out.print("<th>Amount</th>");
			    out.print("<th>Bid Time</th>");
			    out.print("</tr>");

			    // Parse and display the results
			    while (result.next()) {
			        out.print("<tr>");
			        out.print("<td>" + result.getString("bid_id") + "</td>");
			        out.print("<td>" + result.getString("auction_id") + "</td>");
			        out.print("<td>" + result.getString("bidder_username") + "</td>");
			        out.print("<td>" + result.getString("amount") + "</td>");
			        out.print("<td>" + result.getString("bid_time") + "</td>");
			        out.print("</tr>");
			    }

			    out.print("</table>");
			    
			    
			 // Delete logic
		        String bid_id = request.getParameter("bid_id"); 
		        String auction_id = request.getParameter("auction_id");
		        String username = request.getParameter("username");
		        
		    

		        if (bid_id != null && username != null && auction_id != null) {
		        	
		            
		        	String deleteQuery = "DELETE FROM bid WHERE bid_id = ? and auction_id = ? and bidder_username = ?";
		            
		            PreparedStatement deleteStatement = con.prepareStatement(deleteQuery);
		            
		            int bidValue = Integer.valueOf(bid_id);
		            int auctionValue = Integer.valueOf(auction_id);
		            
		            deleteStatement.setInt(1, bidValue);
		            deleteStatement.setInt(2, auctionValue);
		            deleteStatement.setString(3, username);
		            
		            deleteStatement.executeUpdate();
		            
		            
					response.sendRedirect("RemoveBids.jsp");
		        } 

				//close the connection.
				db.closeConnection(con);
			} catch (Exception e) {
				out.print("To Delete a bid all fields must be filled");
			}			
	
	%>



	<div id="remove-bid container" >
		<h2>Enter the requested information to remove a bid!</h2>
		
		<form action="RemoveBids.jsp" method = "post">
		<label for="username">User name:</label>
		<input type="text" id="username" name="username">
		
		<br><br>
		
		<label for="bid_id">Bid ID:</label>
		<input type="text" id="bid_id" name="bid_id">
		
		<br><br>
		
		<label for="auction_id">Auction ID:</label>
		<input type="text" id="auction_id" name="auction_id">
		
		<br><br>
		
		<input type="submit" value="Remove Bid">
		
		</form>
		
		<br><br>

		<form action="CustomerRepHomePage.jsp" method = "post">
		<input type="submit" value="Home Page">
		</form>
		
		
	 </div>
<body>

</body>
</html>
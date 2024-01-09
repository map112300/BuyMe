<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="group5.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

 
    <%
    	if (session == null || session.getAttribute("username") == null) {
    		response.sendRedirect("LandingPage.jsp");
    	}
    
    	/* if (request.getParameter("auction_id") == null) {
    		response.sendRedirect("CustomerRepHomePage.jsp");
    	} */
    %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>This is the list of all current auctions</title>
</head>

	<%
	
			try {
				
				//Get the database connection
				ApplicationDB db = new ApplicationDB();	
				Connection con = db.getConnection();		

				//Create a SQL statement
				Statement stmt = con.createStatement();
				//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
				String str = "SELECT auction_id, manufacture_id, current_price, seller_username, buyer_username FROM auction";
				//Run the query against the database.
				ResultSet result = stmt.executeQuery(str);
				
				out.print("<style>");
			    out.print("table { border-collapse: collapse; width: 100%; }");
			    out.print("th, td { border: 1px solid black; padding: 8px; text-align: left; }");
			    out.print("</style>");

			    out.print("<table>");
			    
			    // Create header row with column names
			    out.print("<tr>");
			    out.print("<th>Auction ID</th>");
			    out.print("<th>Manufacture ID</th>");
			    out.print("<th>Current Price</th>");
			    out.print("<th>Seller</th>");
			    out.print("<th>Buyer Username</th>");
			    out.print("</tr>");

			    // Parse and display the results
			    while (result.next()) {
			        out.print("<tr>");
			        out.print("<td>" + result.getString("auction_id") + "</td>");
			        out.print("<td>" + result.getString("manufacture_id") + "</td>");
			        out.print("<td>" + result.getString("current_price") + "</td>");
			        out.print("<td>" + result.getString("seller_username") + "</td>");
			        out.print("<td>" + result.getString("buyer_username") + "</td>");
			        out.print("</tr>");
			    }

			    out.print("</table>");
			    
			    
			 // Delete logic
		    
		        String auction_id = request.getParameter("auction_id");

		        if (auction_id != null) {
		        	
		  
		            
		        	String deleteQuery = "DELETE FROM auction WHERE auction_id = ?";
		            
		            PreparedStatement deleteStatement = con.prepareStatement(deleteQuery);

		            int auctionValue = Integer.valueOf(auction_id);
		            
		            
		            deleteStatement.setInt(1, auctionValue);
		            deleteStatement.executeUpdate();		            
					response.sendRedirect("RemoveAuction.jsp");
		        } 

				//close the connection.
				db.closeConnection(con);
			} catch (Exception e) {
				out.print("To Delete a auction all fields must be filled");
			}			
	
	%>



	<div id="remove-bid container" >
		<h2>Enter the "Auction ID" of the Auction you would like to remove!</h2>
		
		<form action="RemoveAuction.jsp" method = "post">
		<label for="auction_id">Auction ID:</label>
		<input type="text" id="auction_id" name="auction_id">
		
		<br><br>
		<input type="submit" value="Remove Auction">
		
		</form>
		
		<br><br>

		<form action="CustomerRepHomePage.jsp" method = "post">
		<input type="submit" value="Home Page">
		</form>
		
		
	 </div>
<body>

</body>
</html>
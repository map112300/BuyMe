<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="group5.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.text.SimpleDateFormat"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
    
    <%
    	if (session == null || session.getAttribute("username") ==  null) {
    		response.sendRedirect("HomePage.jsp");
    	}
    %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Alerts</title>

</head>
<body>

<center>
<h1 style="font-size:35px"><strong> Alert List</strong></h1>

<h2 style="font-size:25px"><strong> Set Item Alert</strong></h2>
<h3 style="font-size:18px"><strong> Set an alert for a clothing item you are interested in (Select One)!</strong></h3>
<form action="AlertConfirmation.jsp">
	<table>
	<tr>    
		<td><input type="checkbox" id="checkBox" name="checkBox" value="1" checked></td><td><label> Tops</label></td>
	</tr>

	<tr>
		<td><input type="checkbox" id="checkBox" name="checkBox" value="2"></td><td><label> Bottoms</label></td>
	</tr>

	<tr>
		<td> <input type="checkbox" id="checkBox" name="checkBox" value="3"></td><td><label> Footwear</label></td>
	</tr>
	</table>
	<br>
  <input type="submit" style="font-size:20px;height:30px;width:150px" value="Place Alert">
</form>
<br></br>


	<h1>Your Alerts!</h1>
        <%
	    	try {
	    		
	    		
	    		ApplicationDB db = new ApplicationDB();
	    		Connection con = db.getConnection();
	    		
	    		//create SQL statement
	    		Statement stmt = con.createStatement();
	    		Statement stmtTwo = con.createStatement();
	    		//select query
	    		String alertQuery = "SELECT DISTINCT a.username, a.alert_id FROM alerts a JOIN auction ON a.alert_id = auction.manufacture_id";
	    		String wonAuctionQuery = "SELECT a.buyer_username, a.auction_id FROM auction a ORDER BY a.auction_id DESC";
	    		//select highest bid placed by the user for each auction
	    		String auctionQuery = "SELECT auction_id, (SELECT MAX(amount) FROM bid WHERE bidder_username = ? AND auction_id = b.auction_id) AS your_highest_bid, (SELECT MAX(amount) FROM bid WHERE auction_id = b.auction_id) AS highest_bid_auction, (SELECT MAX(amount) FROM bid) AS highest_bid_overall FROM bid b GROUP BY auction_id ORDER BY auction_id DESC";
	    		//query to be used for upper limit alerts		
	    		String upperLimitQuery = "SELECT a.auction_id, MAX(CASE WHEN b.bidder_username = ? THEN b.amount END) AS your_highest_bid, MAX(a.highest_bid_auction) AS highest_bid_auction, a.highest_bid_overall, MAX(bs.autobid_upper_limit) AS autobid_upper_limit FROM (SELECT auction_id, MAX(amount) AS highest_bid_auction, (SELECT MAX(amount) FROM bid) AS highest_bid_overall FROM bid GROUP BY auction_id) a LEFT JOIN bid b ON a.auction_id = b.auction_id LEFT JOIN bidsetting bs ON a.auction_id = bs.auction_id AND b.bidder_username = bs.bidder_username GROUP BY a.auction_id, a.highest_bid_auction, a.highest_bid_overall";
				// Strin upperLimitQuery = "SELECT DISTINCT a.auction_id FROM bid JOIN bidsetting bs USING (auction_id, bidder_username) WHERE bs.bidder_username = ? AND bs.autobid_upper_limit < bs.autobid_increment + (SELECT MAX(b.amount) FROM bid b WHERE b.auction_id = bs.auction_id)";	
	    				
	    		//execute the created query
	    		ResultSet result = stmt.executeQuery(alertQuery);
	    		ResultSet wonResults = stmtTwo.executeQuery(wonAuctionQuery);
	    		//gets username of active session
	    		String username = (String)session.getAttribute("username");
	    		
	    		PreparedStatement auctionFind = con.prepareStatement(auctionQuery);
	    		auctionFind.setString(1, username);
	    		ResultSet bidResults = auctionFind.executeQuery();
	    		
	    		PreparedStatement upperLimits = con.prepareStatement(upperLimitQuery);
	    		upperLimits.setString(1, username);
	    		ResultSet limitResults = upperLimits.executeQuery();
	    		
	    		//Make an HTML table to show the results in:
				out.print("<table>");

				//make a row
				out.print("<tr>");
				//make a column
				out.print("<td>");
				//print out column header
				out.print("<center>");
				out.print("Your Current Alerts:");
				out.print("</center>");
				
				out.print("</td>");
				//make a column
				out.print("<td>");
				
				out.print("</td>");
				out.print("</tr>");
	    		
				//iterate through item alerts
	    		while(result.next()) {
	    			//only print necessary results
		    		//make a row
					out.print("<tr>");
					//make a column
					out.print("<td>");
	    			String match = result.getString(1);
	    			int type = result.getInt(2);
	    			out.print("<center>");
	    			if(match.equals(username)){
	    				if(type == 1){
	    					out.print("You have an alert for tops, there are currently available tops in the auction!");
	    				}else if(type == 2){
	    					out.print("You have an alert for bottoms, there are currently available items of this sort in the auction");
	    				}else if(type == 3){
	    					out.print("You have an alert for footwear, footwear items are currenlty available in the auction");
	    				}
	    			}
	    			out.print("</center>");
	    			
	    		}
	    		
				//iterate through won auction results
	    		while(wonResults.next()) {
	    			//only print necessary results
		    		//make a row
					out.print("<tr>");
					//make a column
					out.print("<td>");
					out.print("<center>");
	    			String match = wonResults.getString(1);
	    			int type = wonResults.getInt(2);
	    			if(match != null){	
		    			if(match.equals(username)){
		    				out.print("You have won auction number " + type + " congrats on your new purchase!");
		    			}
	    		}
	    			out.print("</center>");
	    	}
				
				//alert buyer if a higher bid has been placed 
			while(bidResults.next()) {
				out.print("<tr>");
				//make a column
				out.print("<td>");
				out.print("<center>");
				
				int auction = bidResults.getInt(1);
				int userHighest = bidResults.getInt(2);
				int auctionHighest = bidResults.getInt(3);
				
				if(auctionHighest > userHighest) {
					out.print("There is a higher bid then yours on auction " + auction + " place a higher bid, or you may lose the auction"); 
				}
			}
			out.print("</center>");
			
				//alert buyer if someone has bid more then their upper limit
			while(limitResults.next()) {
				out.print("<tr>");
				//make a column
				out.print("<td>");
				out.print("<center>");
				
				int auction = limitResults.getInt(1);
				int upperLimit = limitResults.getInt(5);
				int auctionHighest = limitResults.getInt(3);
				
				
				if(auctionHighest > upperLimit) {
					out.print("Someone has placed a higher bid then your upper limit in auction " + auction + " place a higher bid, or increase your upper limit to avoid losing the item"); 
				}
			}
			out.print("</center>");
	    		
	    		
	    		
	    		out.print("</table>");

		    	db.closeConnection(con);				
	    	} catch(Exception e) {
	    		out.print(e);
	    	}
	    
	    %>

<br><br>
	<form action="HomePage.jsp">
		<input type="submit" style="font-size:20px;height:30px;width:150px" value="Main Menu">
	</form>
<br><br>

<br></br>
</center>
</body>


</html>
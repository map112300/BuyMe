<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="group5.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.text.SimpleDateFormat"%>
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
		<title>Insert Bid</title>
</head>
<body>
    <% 
        if (request.getMethod().equalsIgnoreCase("post")) {
        	try {
    			
        		//Get the database connection
       			ApplicationDB db = new ApplicationDB();	
       			Connection con = db.getConnection();
    			
				// Prepare the query using PreparedStatement 
                String bidQuery = "INSERT INTO bid (bid_id, auction_id, bidder_username, amount) SELECT IF(ISNULL(MAX(bid_id)), 1, MAX(bid_id)+1), ?, ?, ? FROM auction left join bid USING (auction_id) WHERE auction_id = ? AND ? >= current_price + minimum_bid_increment GROUP BY auction_id;";
                PreparedStatement ps = con.prepareStatement(bidQuery);

                // Set the parameters in the PreparedStatement
                ps.setInt(1, Integer.valueOf(request.getParameter("auctionID")));
                ps.setString(2, session.getAttribute("username").toString());
                ps.setDouble(3, Double.valueOf(request.getParameter("amount")));
                ps.setInt(4, Integer.valueOf(request.getParameter("auctionID")));
                ps.setDouble(5, Double.valueOf(request.getParameter("amount")));

                if (ps.executeUpdate() > 0) {
                	
                	//Update current price for auction
                	String auctionUpdate = "UPDATE auction SET current_price = (SELECT MAX(amount) FROM bid WHERE auction_id = ?) WHERE auction_id = ?";
                    ps = con.prepareStatement(auctionUpdate);

                    // Set the parameters in the PreparedStatement
                    ps.setInt(1, Integer.valueOf(request.getParameter("auctionID")));
                    ps.setInt(2, Integer.valueOf(request.getParameter("auctionID")));
                        
                    ps.executeUpdate();             	
                }
                
                ps.close();
                con.close();
                
                response.sendRedirect("Auction.jsp?auctionID=" + request.getParameter("auctionID"));

            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    %>
</body>
</html>
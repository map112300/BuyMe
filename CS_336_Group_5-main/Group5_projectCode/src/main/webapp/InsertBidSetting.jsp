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
		<title>Insert Bid Setting</title>
</head>
<body>
    <% 
        if (request.getMethod().equalsIgnoreCase("post")) {
        	try {
    			
        		//Get the database connection
       			ApplicationDB db = new ApplicationDB();	
       			Connection con = db.getConnection();
    			
       			String bidSettingQuery;
       			PreparedStatement ps;
       			
				int flag = Integer.valueOf(request.getParameter("existence"));
				
				
				if (flag == -1) {
					// Prepare the query using PreparedStatement
	                bidSettingQuery = "INSERT INTO bidsetting VALUES (?, ?, ?, ?, ?, ?)";
	                ps = con.prepareStatement(bidSettingQuery);

	                // Set the parameters in the PreparedStatement
	                ps.setInt(1, Integer.valueOf(request.getParameter("auctionID")));
	                ps.setString(2, session.getAttribute("username").toString());
	                ps.setBoolean(3, Boolean.valueOf(request.getParameter("anonymousORnot")));
	                ps.setBoolean(4, Boolean.valueOf(request.getParameter("autobiddingORnot")));
	                ps.setDouble(5, Double.valueOf(request.getParameter("autobid_upper_limit")));
	                ps.setDouble(6, Double.valueOf(request.getParameter("autobid_increment")));

	                ps.executeUpdate();
	                ps.close();
				}
				else if (flag == 1) {
					// Prepare the query using PreparedStatement
	                bidSettingQuery = "UPDATE bidsetting SET anonymousORnot = ?, autobiddingORnot = ?, autobid_upper_limit = ?, autobid_increment = ? WHERE auction_id = ? AND bidder_username = ?";
	                ps = con.prepareStatement(bidSettingQuery);

	                // Set the parameters in the PreparedStatement
	                ps.setBoolean(1, Boolean.valueOf(request.getParameter("anonymousORnot")));
	                ps.setBoolean(2, Boolean.valueOf(request.getParameter("autobiddingORnot")));
	                ps.setDouble(3, Double.valueOf(request.getParameter("autobid_upper_limit")));
	                ps.setDouble(4, Double.valueOf(request.getParameter("autobid_increment")));
	                ps.setInt(5, Integer.valueOf(request.getParameter("auctionID")));
	                ps.setString(6, session.getAttribute("username").toString());

	                ps.executeUpdate();
	                ps.close();
				}
				
                con.close();
                
                response.sendRedirect("Auction.jsp?auctionID=" + request.getParameter("auctionID"));

            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    %>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="group5.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
    
    <%
    	if (session == null || session.getAttribute("username") ==  null) {
    		response.sendRedirect("LandingPage.jsp");
    	}
    %>    
   
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	</head>
	<body>	
	
   <h1>All Auctions</h1>
<h2> Auctions List:</h2>
     <%
        try {
            // Get the database connection
            ApplicationDB db = new ApplicationDB();    
            Connection con = db.getConnection();

            Statement stmt = con.createStatement();

            // Retrieve all auction records from the database
            String allauctionquery = "SELECT * FROM auction JOIN CLOTHES USING (manufacture_id) ";
            ResultSet rs = stmt.executeQuery(allauctionquery);


            while (rs.next()) {
                String auctionId = rs.getString("auction_id");
               
                out.print("<p><br><a href='Auction.jsp?auctionID=" + auctionId + "'>" + auctionId + "</a></p>");
            }

            // Close the resources
            rs.close();
            con.close();


        }catch (Exception e) {
			out.print(e);
		}
    %>
    
    <form action="HomePage.jsp" method = "post">
		<input type="submit" value="Home Page">
		</form>
		
		<br><br>
		<form action="AuctionHistory.jsp" method = "post">
		<input type="submit" value="Auction History">
		</form>
		
    
	</body>
</html>
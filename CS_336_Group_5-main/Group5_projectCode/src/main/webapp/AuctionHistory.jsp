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
<title>Auction History</title>
</head>
<body>	
	
   <h1>Below is a History of Auctions</h1>
<h2> Auction History:</h2>
     <%
        try {
            // Get the database connection
            ApplicationDB db = new ApplicationDB();    
            Connection con = db.getConnection();

            Statement stmt = con.createStatement();

            // Retrieve all auction records from the database
            String auctionHistory = "SELECT * FROM auction JOIN CLOTHES USING (manufacture_id) WHERE auction.end_time < NOW()";
            ResultSet rs = stmt.executeQuery(auctionHistory);


            while (rs.next()) {
                String auctionId = rs.getString("auction_id");
                String brand = rs.getString("brand");
                String gender = rs.getString ("gender");
               
                out.print("<p><br><a href='Auction.jsp?auctionID=" + auctionId + "'>" + auctionId + "</a>" + ",&nbsp brand:  " + brand + ",&nbsp gender:  " + gender + "</p>");
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

    
	</body>
</html>
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
    <title>Auctions with Similar Items</title>
</head>
<body>

		<h1>Auctions with Similar Items</h1>
	    
	    <%     

		// Handle newQuestion insertion for END users
	
		    try {
		    	
		    	ApplicationDB db = new ApplicationDB();
				Connection con = db.getConnection();

				if (request.getParameter("auctionID") == null) {
					response.sendRedirect("HomePage.jsp");
				}
				
				//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
				String query = "SELECT * " + 
		                       "FROM (SELECT manufacture_id, brand, gender, age, 'bottoms' AS `category`, type AS `attr1`, waist_length AS `attr2`, rise_type AS `attr3` " +
		                             "FROM clothes JOIN bottoms USING (manufacture_id) " +
			                         "UNION " +
			                         "SELECT manufacture_id, brand, gender, age, 'footwear' AS `category`, type_of_footwear AS `attr1`, size AS `attr2`, lace_color AS `attr3` " +
			                         "FROM clothes JOIN footwear USING (manufacture_id) " +
			                         "UNION " +
			                         "SELECT manufacture_id, brand, gender, age, 'top' AS `category`, Neck_type AS `attr1`, size AS `attr2`, sleeve_length AS `attr3` " +
			                         "FROM clothes JOIN top USING (manufacture_id)) C JOIN auction USING (manufacture_id) " +
			                         "WHERE auction_id = ?";
			           
				//Run the query against the database.
				PreparedStatement ps = con.prepareStatement(query);
				ps.setString(1,request.getParameter("auctionID"));
				ResultSet rs = ps.executeQuery();
				
				if (rs.next()) {
					String similarItemsQuery = "SELECT auction_id, current_price, end_time, IF(category LIKE ?, 5, 0) + IF(brand LIKE ?, 3, 0) + IF(gender LIKE ?, 3, 0) + IF(age LIKE ?, 3, 0) + IF(attr1 LIKE ?, 2, 0) + IF(attr2 LIKE ?, 2, 0) + IF(attr3 LIKE ?, 2, 0) AS `score` " + 
 		                                       "FROM (SELECT manufacture_id, brand, gender, age, 'bottoms' AS `category`, type AS `attr1`, waist_length AS `attr2`, rise_type AS `attr3` " +
 			                                   "FROM clothes JOIN bottoms USING (manufacture_id) " +
  			                                   "UNION " +
  			                                   "SELECT manufacture_id, brand, gender, age, 'footwear' AS `category`, type_of_footwear AS `attr1`, size AS `attr2`, lace_color AS `attr3` " +
  			                                   "FROM clothes JOIN footwear USING (manufacture_id) " +
  			                                   "UNION " +
  			                                   "SELECT manufacture_id, brand, gender, age, 'top' AS `category`, Neck_type AS `attr1`, size AS `attr2`, sleeve_length AS `attr3` " +
  			                                   "FROM clothes JOIN top USING (manufacture_id)) C JOIN auction USING (manufacture_id) " +
  			                                   "WHERE auction_id <> ? " +
  			                                   "ORDER BY score DESC";
				    
					ps = con.prepareStatement(similarItemsQuery);
					ps.setString(1,rs.getString("category"));
					ps.setString(2,rs.getString("brand"));
					ps.setString(3,rs.getString("gender"));
					ps.setString(4,rs.getString("age"));
					ps.setString(5,rs.getString("attr1"));
					ps.setString(6,rs.getString("attr2"));
					ps.setString(7,rs.getString("attr3"));
					ps.setInt(8,Integer.valueOf(request.getParameter("auctionID")));
					
					rs = ps.executeQuery();
					
					out.print("<style>");
				    out.print("table { border-collapse: collapse; width: 100%; }");
				    out.print("th, td { border: 1px solid black; padding: 8px; text-align: center; }");
				    out.print("</style>");
		
				    out.print("<table>");
				    
				    // Create header row with column names
				    out.print("<tr>");
				    out.print("<th>Auction ID</th>");
				    out.print("<th>Current Price</th>");
				    out.print("<th>End Time</th>");
				    out.print("</tr>");
				    
				    if (rs.next()) {
				    	rs.beforeFirst();
				    	while (rs.next()) {
			  				out.print("<tr>");    
			  					out.print("<td><a href='Auction.jsp?auctionID=" + rs.getString("auction_id") + "'>" + rs.getString("auction_id") + "</a></td>");
			  					out.print("<td>$ " + rs.getString("current_price") + "</td>");
			  					out.print("<td>" + rs.getString("end_time") + "</td>");
			  				out.print("</tr>");
				    	}
				    
		  			}
				    else {
				    	out.print("<tr>");
				    	out.print("<td colspan='3'>No Auctions with Similar Items Found</td>");
				    	out.print("</tr>");
				    }
				}
				else {
					response.sendRedirect("HomePage.jsp");
				}
				
				rs.close();
			    ps.close();
			    con.close();
			        
			} catch (Exception e) {
				out.print(e);
			}
		%>
		
		<br>
	    <form action="HomePage.jsp" method="post">
	        <input type="submit" value="Home">
	    </form>
		<br>
		  <form action="Logout.jsp" method="post">
	        <input type="submit" value="Log Out">
	    </form>
</body>
</html>

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
		<title>Create an Auction</title>
	</head>
	
	

	<%
	if (request.getMethod().equalsIgnoreCase("post")) {
    		try {
			
    		//Get the database connection
   			ApplicationDB db = new ApplicationDB();	
   			Connection con = db.getConnection();
			
   			String checkQuery = "SELECT manufacture_id FROM clothes JOIN " + request.getParameter("type") + " USING (manufacture_id) WHERE brand = ? AND gender = ? AND age = ?";
   			String clothesQuery = "INSERT INTO clothes (brand, gender, age) VALUES (?, ?, ?)";
   			String subcategoryQuery = "INSERT INTO " + request.getParameter("type") + " VALUES (?, ?, ?, ?)";
   			String auctionQuery = "INSERT INTO auction (manufacture_id, end_time, current_price, seller_username, hidden_minimum_price, minimum_bid_increment) VALUES (?, ?, ?, ?, ?, ?)";
			
   			if (request.getParameter("type").equals("top")) {
   				checkQuery += " AND Neck_type = ? AND size = ? AND sleeve_length = ?";
   			}
   			else if (request.getParameter("type").equals("bottoms")) {
   				checkQuery += " AND type = ? AND waist_length = ? AND rise_type = ?";
   			}
   			else if (request.getParameter("type").equals("footwear")) {
   				checkQuery += " AND type_of_footwear = ? AND size = ? AND lace_color = ?";
   			}
   			else {
   				response.sendRedirect("HomePage.jsp");
   			}
   			
   			
   	    	PreparedStatement ps = con.prepareStatement(checkQuery);
   	    	ps.setInt(1, Integer.valueOf(request.getParameter("brand")));
			ps.setInt(2, Integer.valueOf(request.getParameter("gender")));
			ps.setInt(3, Integer.valueOf(request.getParameter("age")));
			ps.setInt(4, Integer.valueOf(request.getParameter("attr1")));
			ps.setInt(5, Integer.valueOf(request.getParameter("attr2")));
			ps.setInt(6, Integer.valueOf(request.getParameter("attr3")));
			
			ResultSet rs = ps.executeQuery();
			
			int key = -1;
			
			if (!rs.next()) {
   	    	
   	    		ps = con.prepareStatement(clothesQuery, Statement.RETURN_GENERATED_KEYS);	
				//prepare the statements
				ps.setInt(1, Integer.valueOf(request.getParameter("brand")));
				ps.setInt(2, Integer.valueOf(request.getParameter("gender")));
				ps.setInt(3, Integer.valueOf(request.getParameter("age")));
				
				// Execute the querys
				ps.executeUpdate();
				
				try (ResultSet keys = ps.getGeneratedKeys()){
					if (keys.next()) {
						key = keys.getInt(1);
					}
				}
			
				if (key == -1) {
					response.sendRedirect("HomePage.jsp");
				}
				
				ps = con.prepareStatement(subcategoryQuery);
				
				ps.setInt(1, key);
				ps.setInt(2, Integer.valueOf(request.getParameter("attr1")));
				ps.setInt(3, Integer.valueOf(request.getParameter("attr2")));
				ps.setInt(4, Integer.valueOf(request.getParameter("attr3")));
			
				ps.executeUpdate();				
			}
			else {
				key = rs.getInt("manufacture_id");
			}
			
			java.sql.Timestamp closingTimeDate= new java.sql.Timestamp(new SimpleDateFormat("yyyy-MM-dd'T'HH:mm").parse(request.getParameter("closingDateTime")).getTime());
			
			java.sql.Timestamp currentTimeDate= new java.sql.Timestamp(System.currentTimeMillis());

			
			if (closingTimeDate.after(currentTimeDate)) {
			ps = con.prepareStatement(auctionQuery, Statement.RETURN_GENERATED_KEYS);
			
			ps.setInt(1, key);
			ps.setTimestamp(2, closingTimeDate);
			ps.setDouble(3, Double.valueOf(request.getParameter("price")));
			ps.setString(4, session.getAttribute("username").toString());
			ps.setDouble(5, Double.valueOf(request.getParameter("hiddenPrice")));
			ps.setDouble(6, Double.valueOf(request.getParameter("bidIncrement")));
			
			ps.executeUpdate();
			}
			
			else {
				
				response.sendRedirect("HomePage.jsp");
			}
			
			key = -1;
			try (ResultSet keys = ps.getGeneratedKeys()){
				if (keys.next()) {
					key = keys.getInt(1);
				}
			}
			
			if (key == -1) {
				response.sendRedirect("HomePage.jsp");
			}
			else {
				response.sendRedirect("Auction.jsp?auctionID=" + key);
			}		
			
		}
		catch (Exception e) {
			e.printStackTrace();
		}
	}
	%>	
	
</body>
</html>
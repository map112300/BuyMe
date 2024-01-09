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
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Sales Reports:</title>
</head>
<body>

<h1>Below is the Sales Report previously selected</h1>

<%
	try {
		
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
		
			Statement stmt = con.createStatement();
			Statement tempTable = con.createStatement();
			//query creates auction history table
			String query = "CREATE temporary table auction_history SELECT * from auction WHERE buyer_username IS NOT NULL and end_time < NOW()";
			tempTable.executeUpdate(query);
			
			//report style 1
			String totalEarnings = "SELECT sum(current_price) as total_earnings FROM auction_history";
			
			//report style 2
			String earningsPerItem = "SELECT manufacture_id, sum(current_price) as earnings_per_item FROM auction_history GROUP BY manufacture_id";
			
			//report style 3
			String earningsPerItemType = "SELECT manufacture_id, sum(current_price) as earnings_per_item FROM auction_history GROUP BY manufacture_id";
			//these will turn into the appropriate queries
			
			//report style 4
			String earningsPerEndUser = "SELECT seller_username, sum(current_price) as earnings_per_end_user FROM auction_history GROUP BY seller_username";
			
			//report style 5
			String bestSellingItems = "SELECT manufacture_id, sum(current_price) as total_sold FROM auction_history GROUP BY manufacture_id ORDER BY total_sold DESC LIMIT 5";
			
			//report style 6
			String bestBuyers = "SELECT buyer_username, sum(current_price) as total_spent FROM auction_history GROUP BY buyer_username ORDER BY total_spent DESC LIMIT 5";
			
			int reportType = Integer.valueOf(request.getParameter("reportStyle"));
			
			
			out.print("<style>");
		    out.print("table { border-collapse: collapse; width: 20%; }");
		    out.print("th, td { border: 1px solid black; padding: 8px; text-align: left; }");
		    out.print("</style>");

		    out.print("<table>");
		    
			ResultSet result;
			if(reportType == 1) {
				result = stmt.executeQuery(totalEarnings);
				out.print("<tr>");
			    out.print("<th>Total Earnings:</th>");
			    out.print("</tr>");
			    
			    while(result.next()){
			    	out.print("<tr>");
			        out.print("<td>" + result.getString("total_earnings") + "</td>");
			        out.print("</tr>");
			    }

			} else if(reportType == 2) {
				result = stmt.executeQuery(earningsPerItem);
				out.print("<tr>");
			    out.print("<th>Item Type:</th>");
			    out.print("<th>Earnings Per Item:</th>");
			    out.print("</tr>");
			    
			    while(result.next()){
			    	out.print("<tr>");
			    		String itemType;
			    		int type = Integer.valueOf(result.getString("manufacture_id"));
			    		if(type == 1){ itemType = "Tops";}
			    		else if(type ==2){itemType = "Bottoms";}
			    		else{itemType = "Footwear";}
			    		out.print("<td>" + itemType + "</td>");
			        out.print("<td>" + result.getString("earnings_per_item") + "</td>");
			        out.print("</tr>");
			    }
				
				
			} else if(reportType == 3) {
				result = stmt.executeQuery(earningsPerItemType);
				out.print("<tr>");
			    out.print("<th>Item Type:</th>");
			    out.print("<th>Earnings Per Item:</th>");
			    out.print("</tr>");
			    
			    while(result.next()){
			    	out.print("<tr>");
			    		String itemType;
			    		int type = Integer.valueOf(result.getString("manufacture_id"));
			    		if(type == 1){ itemType = "Tops";}
			    		else if(type ==2){itemType = "Bottoms";}
			    		else{itemType = "Footwear";}
			    		out.print("<td>" + itemType + "</td>");
			        out.print("<td>" + result.getString("earnings_per_item") + "</td>");
			        out.print("</tr>");
			    }
				
			} else if(reportType == 4) {
				result = stmt.executeQuery(earningsPerEndUser);
				out.print("<tr>");
			    out.print("<th>Seller Username:</th>");
			    out.print("<th>Earnings Per End User</th>");
			    out.print("</tr>");
			    
			    while(result.next()){
			    	out.print("<tr>");
			    		out.print("<td>" + result.getString("seller_username") + "</td>");
			        out.print("<td>" + result.getString("earnings_per_end_user") + "</td>");
			        out.print("</tr>");
			    }
				
			} else if(reportType == 5) {
				result = stmt.executeQuery(bestSellingItems);
				out.print("<tr>");
			    out.print("<th>Items:</th>");
			    out.print("<th>Total Sold:</th>");
			    out.print("</tr>");
			    
			    while(result.next()){
			    	out.print("<tr>");
			    		String itemType;
			    		int type = Integer.valueOf(result.getString("manufacture_id"));
			    		if(type == 1){ itemType = "Tops";}
			    		else if(type ==2){itemType = "Bottoms";}
			    		else{itemType = "Footwear";}
			    		out.print("<td>" + itemType + "</td>");
			        out.print("<td>" + result.getString("total_sold") + "</td>");
			        out.print("</tr>");
			    }
				
				
			} else if(reportType == 6) {
				result = stmt.executeQuery(bestBuyers);
				out.print("<tr>");
			    out.print("<th>Buyer Username:</th>");
			    out.print("<th>Total Bought</th>");
			    out.print("</tr>");
			    
			    while(result.next()){
			    	out.print("<tr>");
			    		out.print("<td>" + result.getString("buyer_username") + "</td>");
			        out.print("<td>" + result.getString("total_spent") + "</td>");
			        out.print("</tr>");
			    }
				
			}
					
			out.print("</table>");
			
	}
	catch (Exception e) {
		out.print(e);
	}


%>


		<br><br>
				<form action="AdminHomePage.jsp">
					<input type="submit" style="font-size:20px;height:30px;width:150px" value="Main Menu">
				</form>
		<br><br>

</body>
</html>
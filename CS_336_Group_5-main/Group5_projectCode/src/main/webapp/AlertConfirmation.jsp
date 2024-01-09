<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="group5.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.text.SimpleDateFormat"%>
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
<title>Alert Confirmation</title>
</head>
	<body>
	    <div style="text-align: center; margin-top: 50px;">
	        <h1>Alert Confirmation</h1>
		 	<br><br>
				<form action="Alerts.jsp">
					<input type="submit" style="font-size:20px;height:30px;width:150px" value="Alerts Page">
				</form>
			<br><br>
	    </div>
	    
	    <%
	    	try {
	    		
	    		
	    		ApplicationDB db = new ApplicationDB();
	    		Connection con = db.getConnection();
	    		
	    		String insertAlert = "INSERT IGNORE INTO alerts(alert_id, username, message)"
	    				+ "VALUES (?, ?, ?)";
	    		
	    		String username = (String)session.getAttribute("username");
	    		int alertType = Integer.valueOf(request.getParameter("checkBox"));
	    		//need to handle error case of unchecked box
	    		
	    		PreparedStatement ps = con.prepareStatement(insertAlert);
	    		ps.setInt(1, alertType);
	    		ps.setString(2, username);
	    		
	    		String message;
	    		if(alertType == 1){
	    			message = "An alert has been set for tops, we will notify you when they become available";
	    		} else if(alertType == 2) {
	    			message = "An alert has been set for bottoms, we will notify you when they become available";
	    					
	    		} else {
	    			message = "An alert has been set for footwear, we will notify you when they become available";
	    		}
	    		
	    		ps.setString(3, message);
	    					
	    		if(alertType == 1 || alertType == 2 || alertType == 3) { 
	    		
	    				ps.executeUpdate(); %>
	    				<center>
		    			<p>Your alert has been placed.</p>
		    	        <p>If you want to place another alert, click the button above:</p>
		    	        <p>Remember to check the alerts page to see if your interested item is now available</p>
	    				</center>
	    		<% 	
	    		} 
	    		
	    		ps.close();
		    	con.close();
	
	    	} catch(Exception e) {
	    		%> 
    			<center>
    			<p>Your alert was not placed.</p>
    	        <p>Please make sure you are selecting only one item to place an alert for.</p>
				</center>
				<%
	    	}
	    
	    %>
	
	</body>
</html>
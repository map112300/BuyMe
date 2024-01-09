<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
    <%
    	if (session == null || session.getAttribute("username") == null || !"END".equals(session.getAttribute("user_type"))) {
    		response.sendRedirect("LandingPage.jsp");
    	}
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">

    <title>Welcome</title>
</head>
<body>

    <h1>Welcome!</h1>
    <p>You have logged in!</p>
    <br>
    <!-- Header for viewing items -->
	  <h2>View Clothes Currently Up For Auction</h2>

		  
	    <form action="SearchResult.jsp" method="get">
        <input type="submit" style="font-size:20px;height:30px;width:150px" value="Search">
        </form>
        
		<br>
        
        <form action="AllAuctions.jsp" method="get">
        <input type="submit" style="font-size:20px;height:30px;width:150px" value="View All">
	   	</form>
	    
	    <br>
	    
	  <h2>Sell Clothes In An Auction</h2>
		
		<form action="SellClothes.jsp" method="get">
        <input type="submit" style="font-size:20px;height:30px;width:150px" value="Sell Clothes">
	   	</form>
	   	
	   	<br>

	
	
	
	  <h2>Other</h2>  
	  <!-- Footer buttons -->
	  	<form action="ParticipationHistory.jsp" method="post">
	        <input type="submit" style="font-size:20px;height:30px;width:150px"  value="View History">
	    </form>
	    <br>
		<form action="DeleteAccount.jsp" method="post">
	        <input type="submit" style="font-size:20px;height:30px;width:150px"  value="Delete Account">
	    </form>
	    <br>
	    <form action="FAQs.jsp" method="post">
	        <input type="submit" style="font-size:20px;height:30px;width:150px"  value="FAQ's">
	    </form>
	    <br>
	    <form action="Alerts.jsp" method="post">
	        <input type="submit" style="font-size:20px;height:30px;width:150px"  value="View Alerts">
	    </form>
	    <br>
	    <form action="Logout.jsp" method="post">
	        <input type="submit" style="font-size:20px;height:30px;width:150px"  value="Logout">
	    </form>
	    
	   
</body>
</html>

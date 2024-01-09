<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="group5.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
    
    <%
    	if (session == null || session.getAttribute("username") == null || !"CR".equals(session.getAttribute("user_type"))) {
    		response.sendRedirect("LandingPage.jsp");
    	}
    %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Customer Representative's</title>
</head>
<body>
		<h1>Welcome Customer Representative!</h1>
	    <p>You have logged in!</p>
	    
	    <!-- Header for viewing items -->
		  <h3>Remove an Item From Auction</h3>
		  <form action="RemoveAuction.jsp" method="post">
		  <input type="submit" value="View All Auction Items">
		  </form>
		  
		  
		  <h3>Remove Bids!</h3>
	 	 <form action="RemoveBids.jsp" method="post">
	        <input type="submit" value="View All Current Bids">
	     </form>
		  
		  
		  <!-- Header Deleting an Account -->
	 	 <h3>Delete User Account Information!</h3>
	 	 <form action="DeleteAccount.jsp" method="post">
	        <input type="submit" value="Delete Account">
	     </form>
	     
	     
	     <h3>Answer Customer Question's</h3>
	     <form action="FAQs.jsp" method="post">
	        <input type="submit" value="FAQ's">
	    </form>
	    
	    <br>
	    <br>
	    <form action="Logout.jsp" method="post">
	        <input type="submit" value="Logout">
	    </form>


</body>
</html>
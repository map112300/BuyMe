<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="group5.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
    
    <%
    	if (session == null || session.getAttribute("username") ==  null || !"ADMIN".equals(session.getAttribute("user_type"))) {
    		response.sendRedirect("LandingPage.jsp");
    	}
    %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Administrative Accounts</title>
</head>
<body>
		<h1>Welcome Admin!</h1>
	    <p>You have logged in!</p>
	    
	    <!-- Header for viewing items -->
		  <h3>Add a Customer Representative Account!</h3>
		  <br>
		 <form method="post" action="RegisterRedirect.jsp">
		 <table>
		 <tr>    
		 <td>Name:</td><td><input type="text" name="name"></td>
		 </tr>
		 <tr>
		 <td>Phone number:</td><td><input type="text" name="phonenumber"></td>
		 </tr>
		 <tr>
		 <td>Username:</td><td><input type="text" name="username"></td>
		 </tr>
		
		 <tr>
		 <td>Password:</td><td><input type="password" name="password"></td>
		 </tr>
		
		
		</table>
		<input type="submit" value="Register">
		</form>
	<br><br>
		  
	
		<h1>Generate Sales Report</h1>
	  	<form action="SalesReport.jsp" method="post">
	  	
	  	
		<label for="reportStyle">Sales Report Style:</label>
		<select name="reportStyle" id="reportStyle">
		<option value="1">Total Earnings</option>
  		<option value="2">Earnings Per Item</option>
		<option value="3">Earnings Per Item Type</option>
		<option value="4">Earnings Per End-User</option>
		<option value="5">Best-Selling Items</option>
		<option value="6">Best Buyers</option>
		</select>
	   	<br><br>
	   	
	   	<input type="hidden" name="type" value="reportStyle">
	    <button type="submit">Generate Report</button>
	    
	   	</form>
	   	
	   	
		  <!-- Header Deleting an Account -->
	 	 
	 	
	     <br><br>
	     <form action="Logout.jsp" method="post">
	        <input type="submit" value="Logout">
	    </form>
	     
	     
	   


</body>
</html>
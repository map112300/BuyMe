<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="group5.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
    
    <%
    	if (session != null && session.getAttribute("username") !=  null) {
    		if ("END".equals(session.getAttribute("user_type"))) {
    			response.sendRedirect("HomePage.jsp");
    		}
    		else if ("CR".equals(session.getAttribute("user_type"))) {
    			response.sendRedirect("CustomerRepHomePage.jsp");
    		}
    		else if ("ADMIN".equals(session.getAttribute("user_type"))) {
    			response.sendRedirect("AdminHomePage.jsp");
    		}
    		else {
    			response.sendRedirect("Logout.jsp");
    		}
    	}
    %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Welcome to BuyMe!</title>
</head>
<body>
	Welcome to BuyMe, an online auction site that specializes in clothes!
	<div id="login-container" >
		<h2>Login Here!</h2>
		
		<form action="LoginRedirect.jsp" method = "post">
		<label for="username">User name:</label>
		<input type="text" id="username" name="username">
		
		<br>
		
		<label for="password">Password:</label>
		<input type="password" id="password" name="password">
		
		<br>
		
		<input type="submit" value="Login">
		
		
		</form>
	 </div>
	 
	<h2>Register here</h2> 
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
	<br>
	
	
</body>
</html> 


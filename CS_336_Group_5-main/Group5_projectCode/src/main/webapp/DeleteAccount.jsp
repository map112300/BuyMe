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
<title>Delete Accounts</title>
</head>
<body>
		<h1>You are about to delete account!</h1>
	    
	    <!-- Header for delete account -->
		  <h3>Delete an Account!</h3>
		  <br>
		  
		  <%
			String userType = (String)session.getAttribute("user_type");
			if(userType.equalsIgnoreCase("CR")){ 
				
				ApplicationDB db = new ApplicationDB();	
	   			Connection con = db.getConnection();
			
				Statement stmt = con.createStatement();
				//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
				String str = "SELECT * FROM users";
				//Run the query against the database.
				ResultSet result = stmt.executeQuery(str);
				
				out.print("<style>");
			    out.print("table { border-collapse: collapse; width: 30%; }");
			    out.print("th, td { border: 1px solid black; padding: 8px; text-align: left; }");
			    out.print("</style>");
	
			    out.print("<table>");
			    
			    // Create header row with column names
			    out.print("<tr>");
			    out.print("<th>Username:</th>");
			    out.print("<th>Password: </th>");
			    out.print("</tr>");
	
			    // Parse and display the results
			    while (result.next()) {
			    	String type = (String)result.getString("user_type");
			    	if(!type.equalsIgnoreCase("ADMIN")){
			    		out.print("<tr>");
				        out.print("<td>" + result.getString("username") + "</td>");
				        out.print("<td>" + result.getString("password") + "</td>");
				        out.print("</tr>");
			    		
			    	}
			        
			    }
	
			    out.print("</table>");	
					
				%>
				<br><br>
				<form action="CustomerRepHomePage.jsp" method = "post">
				<input type="submit" value="Home Page">
				</form>
				<%  	
			} else { %>
				
				<br><br>
				<form action="HomePage.jsp" method = "post">
				<input type="submit" value="Home Page">
				</form>
				<% 
				
			}
		
		%>
		
		 <form method="post" action="DeleteRedirect.jsp">
		 <table>
		 <tr>
		 <td>Username:</td><td><input type="text" name="username"></td>
		 </tr>
		
		 <tr>
		 <td>Password:</td><td><input type="password" name="password"></td>
		 </tr>
		
		
		</table>
		<br><br>
		<input type="submit" value="Delete Account">
		
		<br><br>

		</form>
		
		
		
		
	<br>

</body>
</html>
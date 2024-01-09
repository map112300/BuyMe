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
		<title>LoginAfter</title>
	</head>
	<body>

	<% 
		try {
			
    		//Get the database connection
   			ApplicationDB db = new ApplicationDB();	
   			Connection con = db.getConnection();
			
   			String username = request.getParameter("username");
			String password = request.getParameter("password");
			
   	    	// Query to check if the username and password match
			String query = "DELETE FROM users WHERE username = ? AND password = ?";
   	    
   	    	PreparedStatement ps = con.prepareStatement(query);	
			//prepare the statements
			ps.setString(1, username);
			ps.setString(2, password);
			
			
			String username_match = (String) session.getAttribute("username");
			String password_match = (String) session.getAttribute("password");
			String user_type = (String) session.getAttribute("user_type");
		
			
			//want to handle end user trying to delete any account - not allowed
			if (user_type.equalsIgnoreCase("END")) {
				// deletion of end user redirect to landing page
				// need to make sure user is trying to delete their account an no one elses
				if(username_match.equalsIgnoreCase(username) &&
						password_match.equalsIgnoreCase(password)) {
					ps.executeUpdate();
					response.sendRedirect("LandingPage.jsp");
				}
				
					out.print("End user can only delete their own account");
					
			
			}
			else {
				// Usert type is CR redirect to CR page successful delete
				// Execute the querys
				if(username != null && password != null){
					ps.executeUpdate();
					out.print("Successfully deleted user");
					response.sendRedirect("DeleteAccount.jsp");

				}
			}
			ps.close();
			con.close();
			
			
		} catch (Exception e) {
			out.print(e);
			// Handle any exceptions that may occur during the login process
		}
	%>
	</body>
</html>
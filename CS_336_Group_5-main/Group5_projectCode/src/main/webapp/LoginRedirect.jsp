<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="group5.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
    
    <%
    	if (session != null && session.getAttribute("username") !=  null) {
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
			String query = "SELECT * FROM users WHERE username = ? AND password = ?";
   	    
   	    	PreparedStatement ps = con.prepareStatement(query);	
			//prepare the statements
			ps.setString(1, username);
			ps.setString(2, password);
			
			// Execute the querys
			ResultSet rs = ps.executeQuery();
			
			if (rs.next()) {
				// Valid login, redirect to another JSP page (e.g., home.jsp)
				//extract the type from the query
				String userType = rs.getString("user_type");
				session.setAttribute("username", rs.getString("username"));
		
				if(userType.equalsIgnoreCase("END")) {
					// end user case
					session.setAttribute("user_type", "END");
					response.sendRedirect("HomePage.jsp");
				} else if(userType.equalsIgnoreCase("ADMIN")) {
					// admin case
					session.setAttribute("user_type", "ADMIN");
					response.sendRedirect("AdminHomePage.jsp");
				} else {
					// customer rep case
					session.setAttribute("user_type", "CR");
					response.sendRedirect("CustomerRepHomePage.jsp");
				}
				//session.setAttribute("usertype", rs.getString("usertype")//

			}
			else {
				// Invalid login, redirect back to the login page
				response.sendRedirect("LandingPage.jsp");
			}
			
			rs.close();
			ps.close();
			con.close();
			
		} catch (Exception e) {
			out.print(e);
			// Handle any exceptions that may occur during the login process
		}
	%>
	</body>
</html>
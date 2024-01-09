<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="group5.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
    
    <%
    	if (session == null || session.getAttribute("username") == null) {
    		response.sendRedirect("LandingPage.jsp");
    	}
    %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>RegisterAfter</title>
</head>
<body>

		<%
			try {
				
			

    		//Get the database connection
   			ApplicationDB db = new ApplicationDB();	
   			Connection con = db.getConnection();
			
   			String username = request.getParameter("username");
			String password = request.getParameter("password");
			String name = request.getParameter("name");
			String phonenumber = request.getParameter("phonenumber");
			
			
   	    	// Query to check if the username and password match
			String insert = "INSERT INTO users(user_type, username, password)"
				+ "VALUES (?, ?, ?)";
			PreparedStatement ps = con.prepareStatement(insert);
			ps.setString(2, username);
			ps.setString(3, password);
			
			String isAdmin = (String)session.getAttribute("user_type");
		
			if(isAdmin.equalsIgnoreCase("ADMIN")) {
				ps.setString(1, "CR");
			} else {
				ps.setString(1, "END");
			}
			
			
			
			if (username != "" && password != "" && name != "" && phonenumber != "") {
				// Valid login, redirect to another JSP page (e.g., home.jsp)
				// Execute the query
				ps.executeUpdate();
				response.sendRedirect("LandingPage.jsp");
				out.print("Please use your new information to log in");
				
				//session.setAttribute("usertype", rs.getString("usertype")//	
			}
			else {
				// Invalid login, redirect back to the login page
				out.print("Please fill in all required fields to register account");

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
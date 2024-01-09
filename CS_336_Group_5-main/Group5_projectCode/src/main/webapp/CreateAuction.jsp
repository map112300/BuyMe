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
		<title>Create an Auction</title>
	</head>
	<body>		
    <h1>Create a Auction!</h1>
    <form method="post" action="InsertAuction.jsp">
        <label for="price">Price:</label>
        <input type="number" id="price" name="price" step="0.01" required><br>
        <label for="hiddenPrice">Hidden Minimum Price:</label>
        <input type="number" id="hiddenprice" name="hiddenPrice" step="0.01" required><br>
        <label for="bidIncrement">Minimum Bid Increment:</label>
        <input type="number" id="bidIncrement" name="bidIncrement" step="0.01" required><br>
        <label for="closingDateTime">Closing Date and Time:</label>
        <input type="datetime-local" id="closingDateTime" name="closingDateTime" required><br>
      <br>
        <input type="submit" value="Create Auction">
        
        <input type="hidden" name="brand" value=<%=request.getParameter("brand")%>>
        <input type="hidden" name="gender" value=<%=request.getParameter("gender")%>>
        <input type="hidden" name="age" value=<%=request.getParameter("age")%>>
        <input type="hidden" name="type" value=<%=request.getParameter("type")%>>
        <input type="hidden" name="attr1" value=<%=request.getParameter("attr1")%>>
        <input type="hidden" name="attr2" value=<%=request.getParameter("attr2")%>>
        <input type="hidden" name="attr3" value=<%=request.getParameter("attr3")%>>
    </form>
    
	    <br>
		<form action="HomePage.jsp" method = "post">
			<input type="submit" value="Home Page">
			</form>	
		<body>
</body>
</html>
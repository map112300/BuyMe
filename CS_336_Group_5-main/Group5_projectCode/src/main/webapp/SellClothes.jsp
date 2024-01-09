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
		<title>Sell Clothes</title>
	</head>
	<body>		
    <!-- Header for selling a top -->
	  <h1>Sell Tops!</h1>
	  <form action="CreateAuction.jsp" method="post">
	    
	    
	  <label for="gender">Gender:</label>
		<select name="gender" id="gender">
		<option value="1">M</option>
  		<option value="2">F</option>
		</select>
	   <br>
	
	  <label for="age">Age:</label>
		<select name="age" id="age">
		<option value="1">Infants</option>
  		<option value="2">Kids</option>
		<option value="3">Teenagers</option>
		<option value="4">Young Adults</option>
		<option value="5">30-50</option>
		<option value="6">60+</option>
		
		</select>
	   <br>
	   
	   
	  <label for="brand">Brand:</label>
		<select name="brand" id="brand">
		<option value="1">Adidas</option>
		<option value="2">Calvin Klein</option>
		<option value="3">Nike</option>
  		<option value="4">Levis</option>
		<option value="5">Barbour</option>
		<option value="6">Birkenstock</option>
		<option value="7">Boden</option>
		 
		</select>
	   <br>
	   <br>
	   
	   
	   	<label for="neck_type">Neck Type:</label>
		<select name="attr1" id="neck_type">
  		<option value="1">High</option>
  		<option value="2">Boat</option>
		<option value="3">Collared</option>
		</select>
	   <br>
	   
	    <label for="top_size">Size:</label>
	    <select name="attr2" id="top_size">
  		<option value="1">XS</option>
  		<option value="2">S</option>
		<option value="3">M</option>
		<option value="4">L</option>
		<option value="5">XL</option>
		</select>
	   <br>
	    
	    <label for="sleeve_length">Sleeve Length:</label>
		<select name="attr3" id="sleeve_length">
		<option value="1">none</option>
  		<option value="2">short</option>
		<option value="3">long</option>
		<option value="4">3/4</option>
		</select>
	   <br>
	    	<br>    
		<input type="hidden" name="type" value="top">
	    <button type="submit">Place</button>
	  </form>
	  
	  <!-- Header for selling a bottom -->
	  <h1>Sell Bottoms!</h1>
	  <form action="CreateAuction.jsp" method="post">
	  
	  <label for="gender">Gender:</label>
		<select name="gender" id="gender">
		<option value="1">M</option>
  		<option value="2">F</option>
		</select>
	   <br>
	
	  <label for="age">Age:</label>
		<select name="age" id="age">
		<option value="1">Infants</option>
  		<option value="2">Kids</option>
		<option value="3">Teenagers</option>
		<option value="4">Young Adults</option>
		<option value="5">30-50</option>
		<option value="6">60+</option>
		
		</select>
	   <br>
	   
	   
	  <label for="brand">Brand:</label>
		<select name="brand" id="brand">
		<option value="1">Adidas</option>
		<option value="2">Calvin Klein</option>
		<option value="3">Nike</option>
  		<option value="4">Levis</option>
		<option value="5">Barbour</option>
		<option value="6">Birkenstock</option>
		<option value="7">Boden</option>
		 
		</select>
	   <br>
	   <br>
	  
	    <label for="pants_type">Type:</label>
		<select name="attr1" id="pants_type">
		<option value="1">Activewear</option>
  		<option value="2">Sweatpants</option>
		<option value="3">Jeans</option>
		
		</select>
	   <br>
	   
	    <label for="waist_length">Waist:</label>
		<select name="attr2" id="waist_length">
		<option value="1">XS</option>
  		<option value="2">S</option>
		<option value="3">M</option>
		<option value="4">L</option>
		<option value="5">XL</option>
		</select>
	   <br>
	   
	    <label for="rise_type">Rise:</label>
		<select name="attr3" id="rise_type">
		<option value="1">High</option>
  		<option value="2">Mid</option>
		<option value="3">Low</option>
	
		</select>
	   <br>
	    	    
		<input type="hidden" name="type" value="bottoms">
	    <button type="submit">Place</button>
	  </form>
	  
	  <!-- Header for selling footwear -->
	  <h1>Sell Footwear!</h1>
	  <form action="CreateAuction.jsp" method="post">
	  
	   <label for="gender">Gender:</label>
		<select name="gender" id="gender">
		<option value="1">M</option>
  		<option value="2">F</option>
		</select>
	   <br>
	
	  <label for="age">Age:</label>
		<select name="age" id="age">
		<option value="1">Infants</option>
  		<option value="2">Kids</option>
		<option value="3">Teenagers</option>
		<option value="4">Young Adults</option>
		<option value="5">30-50</option>
		<option value="6">60+</option>
		
		</select>
	   <br>
	   
	   
	  <label for="brand">Brand:</label>
		<select name="brand" id="brand">
		<option value="1">Adidas</option>
		<option value="2">Calvin Klein</option>
		<option value="3">Nike</option>
  		<option value="4">Levis</option>
		<option value="5">Barbour</option>
		<option value="6">Birkenstock</option>
		<option value="7">Boden</option>
		 
		</select>
	   <br>
	   <br>
	   
	   
	    <label for="type_of_footwear">Shoe Style:</label>
		<select name="attr1" id="type_of_footwear">
		<option value="1">Athletic shoes</option>
  		<option value="2">Boots</option>
		<option value="3">Sneakers</option>
		<option value="4">Flats</option>
		</select>
	   <br>
	
	
	    <label for="size">Size:</label>
		<select name="attr2" id="size">
		<option value="1">1</option>
  		<option value="2">2</option>
		<option value="3">3</option>
		<option value="4">4</option>
  		<option value="5">5</option>
		<option value="6">6</option>
		<option value="7">7</option>
		<option value="8">8</option>		
		<option value="9">9</option>		
		<option value="10">10</option>		
		<option value="11">11</option>
		
		</select>
	   <br>
	   
	    <label for="lace_color">Lace Color:</label>
		<select name="attr3" id="lace_color">
		<option value="1">Black</option>
  		<option value="2">Blue</option>
		<option value="3">Brown</option>
		<option value="4">Beige</option>
		<option value="5">Green</option>
		<option value="6">Red</option>

		</select>
	   <br>
	    	    
		<input type="hidden" name="type" value="footwear">
	    <button type="submit">Place</button>
	  </form>
	<br>
	<br>
    
	    <br><br>
		<form action="HomePage.jsp" method = "post">
			<input type="submit" value="Home Page">
			</form>	
			<br>
			
	    <form action="Logout.jsp" method="post">
	        <input type="submit" value="Logout">
	    </form>
		<body><br>
	
</body>
</html>
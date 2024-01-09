<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="group5.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>


<%
	if (session != null && session.getAttribute("username") !=  null) {
		session.removeAttribute("username");
		session.removeAttribute("user_type");
	}
	
	response.sendRedirect("LandingPage.jsp");
%>
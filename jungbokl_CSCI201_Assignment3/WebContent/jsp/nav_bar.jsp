<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="objects.*"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Set"%>
<%@ page import="java.util.HashSet"%>
<%@ page import="parsing.StringConstants"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<% 

	if ((session.getId() == null) || (session.getAttribute(StringConstants.DATA) == null)){
		request.getRequestDispatcher("index.jsp").forward(request, response);
		return;
	}
	
	HttpSession httpSession = request.getSession();
	String StyleSheet = (String)httpSession.getAttribute("designChoice");
	System.out.println("here: " + StyleSheet);
	String stylelink = "";
	if(StyleSheet.equals("option1.css")){
		stylelink = "option1.css";
	}
	else{
		stylelink = "option2.css";
	}
	System.out.println("Style link: " + stylelink);

	DataContainer data = (DataContainer) session.getAttribute(StringConstants.DATA);
	School school = data.getSchools().get(0);
	Department dept = school.getDepartments().get(0);
	Course course = dept.getCourses().get(0);
	
	String location = (String) request.getAttribute(StringConstants.LOCATION);
	String [] hrefs = {"http://cs.usc.edu", StringConstants.HOME_JSP, course.getSyllabus().getUrl(), 
			StringConstants.LECTURES_JSP, StringConstants.ASSIGNMENTS_JSP, StringConstants.EXAMS_JSP};
	String [] labels = {dept.getPrefix()+" Department", dept.getPrefix()+" "+course.getNumber()+" Home", 
			"Syllabus", "Lectures", "Assignments", "Previous Exams"};
	
	//String searchName = request.getParameter("searchName").toUpperCase();
	//System.out.println("Search Term is: " + searchName);
%>
<head>
	<title><%= school.getName() %>: <%=dept.getPrefix() %> <%= course.getNumber() %> <%= course.getTerm() %> <%= course.getYear() %></title>
	<link rel = "stylesheet" type="text/css" href=<%=stylelink%>>
<script>
	
	function search(){
		
		var xhttp = new XMLHttpRequest();
		var input = document.getElementById("input").value;
		
		xhttp.open("GET", "home.jsp?input="+input, true);
		xhttp.send();
		xhttp.onreadystatechange = function() {
			if(xhttp.readyState == 4 && xhttp.status == 200){
				document.body.innerHTML = xhttp.responseText;
			}
		}
		
	}
	
	function clearSearch(){
		var xhttp = new XMLHttpRequest();
		var input = null;
		xhttp.open("GET", "home.jsp?input="+input, true);
		xhttp.send();
		xhttp.onreadystatechange = function() {
			if(xhttp.readyState == 4 && xhttp.status == 200){
				document.body.innerHTML = xhttp.responseText;
			}
		}
	}
	
	function searchTopic(){
		var xhttp = new XMLHttpRequest();
		var tInput = document.getElementById("tInput").value;
		
		xhttp.open("GET", "lectures.jsp?tInput="+tInput, true);
		xhttp.send();
		
		xhttp.onreadystatechange = function(){
			if(xhttp.readyState ==4 && xhttp.status == 200){
				document.body.innerHTML = xhttp.responseText;
			}
		}	
	}
	
	function searchTopic2(){
		var xhttp = new XMLHttpRequest();
		var tInput = document.getElementById("tInput").value;
		
		xhttp.open("GET", "lecturesonly.jsp?tInput="+tInput, true);
		xhttp.send();
		
		xhttp.onreadystatechange = function(){
			if(xhttp.readyState ==4 && xhttp.status == 200){
				document.body.innerHTML = xhttp.responseText;
			}
		}	
	}
	
	function clearTopic(){
		var xhttp = new XMLHttpRequest();
		var tInput = null;
		
		xhttp.open("GET", "lectures.jsp?tInput="+tInput, true);
		xhttp.send();
		
		xhttp.onreadystatechange = function(){
			if(xhttp.readyState ==4 && xhttp.status == 200){
				document.body.innerHTML = xhttp.responseText;
			}
		}	
	}
	function clearTopic2(){
		var xhttp = new XMLHttpRequest();
		var tInput = null;
		
		xhttp.open("GET", "lecturesonly.jsp?tInput="+tInput, true);
		xhttp.send();
		
		xhttp.onreadystatechange = function(){
			if(xhttp.readyState ==4 && xhttp.status == 200){
				document.body.innerHTML = xhttp.responseText;
			}
		}	
	}
	
	function sortDisplay(){
		
		var xhttp = new XMLHttpRequest();
		
		if(document.getElementById("l").checked){					
			xhttp.open("GET", "lecturesonly.jsp?", true);
			xhttp.send();
		}
		if(document.getElementById("d").checked){
			xhttp.open("GET", "duedates.jsp?", true);
			xhttp.send();
		}
		if(document.getElementById("a").checked){
			xhttp.open("GET", "lectures.jsp?", true);
			xhttp.send();
		}
		xhttp.onreadystatechange = function(){
			if(this.readyState == 4 ){
				if(this.status == 200)
				document.body.innerHTML = this.responseText;
			}
		}
	}

	function DsortAssignment(){
		var xhttp = new XMLHttpRequest();
		var d_val = 0; 		
		
		if(document.getElementById("ddd").checked){
			if(document.getElementById("dascending").checked){
			 	d_val = 10;
			 	xhttp.open("Get", "assignments.jsp?d_val="+d_val, true);
				xhttp.send();
			 	
			}
			if(document.getElementById("ddescending").checked){
				d_val = 20;
				xhttp.open("Get", "assignments.jsp?d_val="+d_val, true);
				xhttp.send();
			}
		}
		
		
		if(document.getElementById("dt").checked){
			if(document.getElementById("dascending").checked){
			 	d_val = 11;
			 	xhttp.open("Get", "assignments.jsp?d_val="+d_val, true);
				xhttp.send();
			 	
			}
			if(document.getElementById("ddescending").checked){
				d_val = 21;
				xhttp.open("Get", "assignments.jsp?d_val="+d_val, true);
				xhttp.send();
			}
			
		}
		if(document.getElementById("dgp").checked){
			if(document.getElementById("dascending").checked){
			 	d_val = 12;
			 	xhttp.open("Get", "assignments.jsp?d_val="+d_val, true);
				xhttp.send();
			}
			if(document.getElementById("ddescending").checked){
				d_val = 22;
				xhttp.open("Get", "assignments.jsp?d_val="+d_val, true);
				xhttp.send();
			}
			
		}
		
		xhttp.onreadystatechange = function(){
			if(this.readyState == 4 ){
				if(this.status == 200)
				document.body.innerHTML = this.responseText;
			}
		}
	}
	
	
	function sortAssignment(){
		var xhttp = new XMLHttpRequest();
		var sort_val = 0; 		
		
		if(document.getElementById("dd").checked){
			if(document.getElementById("ascending").checked){
			 	sort_val = 10;
			 	xhttp.open("Get", "assignments.jsp?sort_val="+sort_val, true);
				xhttp.send();
			 	
			}
			if(document.getElementById("descending").checked){
				sort_val = 20;
				xhttp.open("Get", "assignments.jsp?sort_val="+sort_val, true);
				xhttp.send();
			}
		}
		
		if(document.getElementById("ad").checked){
			if(document.getElementById("ascending").checked){
			 	sort_val = 11;
			 	xhttp.open("Get", "assignments.jsp?sort_val="+sort_val, true);
				xhttp.send();
			 	
			}
			if(document.getElementById("descending").checked){
				sort_val = 21;
				xhttp.open("Get", "assignments.jsp?sort_val="+sort_val, true);
				xhttp.send();
			}
			
		}
		
		if(document.getElementById("t").checked){
			if(document.getElementById("ascending").checked){
			 	sort_val = 12;
			 	xhttp.open("Get", "assignments.jsp?sort_val="+sort_val, true);
				xhttp.send();
			 	
			}
			if(document.getElementById("descending").checked){
				sort_val = 22;
				xhttp.open("Get", "assignments.jsp?sort_val="+sort_val, true);
				xhttp.send();
			}
			
		}
		if(document.getElementById("gp").checked){
			if(document.getElementById("ascending").checked){
			 	sort_val = 13;
			 	xhttp.open("Get", "assignments.jsp?sort_val="+sort_val, true);
				xhttp.send();
			}
			if(document.getElementById("descending").checked){
				sort_val = 23;
				xhttp.open("Get", "assignments.jsp?sort_val="+sort_val, true);
				xhttp.send();
			}
			
		}
		
		xhttp.onreadystatechange = function(){
			if(this.readyState == 4 ){
				if(this.status == 200)
				document.body.innerHTML = this.responseText;
			}
		}
	}
	

</script>

</head>
<body text="#333333" bgcolor="#EEEEEE" link="#0000EE" vlink="#551A8B"
	alink="#336633">
	<table cellpadding="10" width="800">
		<tr>
			<!-- column for left side of page -->
			<td id="mainc" width="180" valign="top">
				<a href="http://www.usc.edu" target= "_top"><img src=<%= school.getImage() %> border="0" /></a><br />
				<br /> 
				<% 
				for (int i = 0; i<6; i++)
				{
	        		if (hrefs[i].equals(location))
	        		{
	        	%> 
        		<font size="+1"><%=labels[i]%></font><br />
				<br /> 
					<%
					} 
	        		else
	        		{ 
	        		%> 
	        	<font size="+1"><a href="<%= hrefs[i]%>"> <%= labels[i] %></a></font><br />
				<br /> 
				<%
					}
	        	} 
	        	%>
	        </td>
			<!-- center column to separate other two columns -->
			<td width="5"><br /></td>
			<!-- large column in center of page with dominant content -->
			<td align="baseline" width="615"><br />
				<p>
					<b><font size="+3"><%= dept.getPrefix() %> <%=course.getNumber() %></font></b><br />
					<b><i><font size="+1"><%= course.getTitle() %> - <%=course.getUnits() %> units</font></i></b><br /> 
					<b><i><font size="+1"><%= course.getTerm() %> <%= course.getYear() %></font></i></b><br />
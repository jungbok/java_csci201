<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<% request.setAttribute(StringConstants.LOCATION, StringConstants.LECTURES_JSP); %>
<%@include file="nav_bar.jsp"%>
<% 
	Schedule schedule = course.getSchedule(); 
	String searchTopic = "";
	if(request.getParameter("tInput") != null) {
		searchTopic = request.getParameter("tInput").toLowerCase();
	}
	else {
	//System.out.println("input null");
		}
%>
<!--  the start tags here that are commented out are included in the nav_bar.jsp
<html>
<body>
	<table>
		<tr>
			<td> -->
			<hr size="4">
				<input type = "text" name ="tInput" id="tInput">
				<button type = button id="searchtbutton" value="searchTopic" onClick="searchTopic()">Search Topic </button>
				<button type = button id="cleartbutton" value="cleartsearch" onClick="clearTopic()">Clear Search </button>
				<hr />	
				<p>
				<hr size="4"/>
				<div id="sortByButtons">
					<label><input type='radio' id="l" name='sortBy' value='1' onClick="sortDisplay()">Show Lectures</label>
					<label><input type='radio' id="d" name='sortBy' value='2' onClick="sortDisplay()">Show Due Dates</label>
					<label><input type='radio' id="a" name='sortBy' value='3' onClick="sortDisplay()" checked>Show All</label>
				</div>
				</p>
				<% 
        		for (int i = 0; i<schedule.getTextbooks().size(); i++)
        		{
      	  			Textbook text = schedule.getTextbooks().get(i);
        		%>
				<p>
				<div id="textbook">
				<hr size="4" />
				</p> <b>Chapter references are from <%= text.getAuthor() %> <u><%= text.getTitle() %>
				</u>, <%= text.getPublisher() %>, <%= text.getYear() %>. ISBN <%= text.getIsbn() %></b>
				<%
				} 
				%>
				</div>
				<p>
				<hr size="4" />
				</p> <b>Lectures</b>
				<table id = "lecturetable" border="2" cellpadding="5" width="790">
					<tr>
						<th align="center">Week #</tdh>
						<th align="center">Lab</th>
						<th align="center">Lecture #</th>
						<th align="center">Day</th>
						<th align="center" width="100">Date</th>
						<th align="center">Lecture Topic</th>
						<th align="center">Chapter</th>
						<th>Program</th>
					</tr>
					<%
            		for (Week week : schedule.getWeeks())
            		{
            		%>
					<tr>
						<td align="center" rowspan="<%= week.getRowSize() %>"><%= week.getWeek() %></td>
						<td align="center" rowspan="<%= week.getRowSize() %>">
						<%
              			for (Lab lab : week.getLabs())
              			{
              			%> 
              				<a href="<%= lab.getUrl() %>"><%= lab.getTitle() %></a>
							<hr /> 
						<%
						}
						for (int i = 0; i<week.getLectures().size(); i++){
							
							if (i != 0)
							{
						%>
					<tr>
							<%
							}
						
             				Lecture l1 = week.getLectures().get(i);   
            				%>
						<td align="center" rowspan="1"><%= l1.getNumber() %></td>
						<td align="center" rowspan="1"><%= l1.getDay() %></td>
						<td align="center" rowspan="1"><%= l1.getDate() %></td>
						<td align="center" rowspan="1">
							<% 
							for (Topic topic : l1.getTopics())
							{
								String temptopic = topic.getTitle().toLowerCase();
							
								if(!searchTopic.isEmpty() && temptopic.contains(searchTopic)){
			
	              			%> 
              				<a href="<%= topic.getUrl() %>"><span style="background-color:#00FFFF;"><%= topic.getTitle() %></span></a>
							<hr /> 
							<%
								}else{
									%>
									<a href="<%= topic.getUrl() %>"><%= topic.getTitle() %></a>
							<hr />
									<%	
									}
							} 
							%>
						</td>
						<td align="center" rowspan="1"><%= l1.getAllChapters() %></td>
						<td align="center" rowspan="1">
							<% 
							for (Program program : l1.getAllPrograms())
							{
	            	  			if (program.getFiles() != null){
	            	  				
	            	  				for (File file : program.getFiles()){
	              			%> 
              				<a href="<%= file.getUrl() %>"><%= file.getTitle() %></a><br />
								<%
									}
	            	  			} 
	            	  			%> 
            	  			<br /> 
	            	  		<%
	            	  		} 
	            	  		%>
						</td>
					</tr>
							<%
							List<GeneralAssignment> assigns = week.getMappedDueDates().get(l1.getNumber());
							if (assigns != null)
							{
								for (GeneralAssignment a : assigns)
								{
									String title = (a instanceof Assignment ? "ASSIGNMENT "+a.getNumber() : a.getTitle());
							%>
					<tr>
						<td align="center"></td>
						<td align="center"><%= l1.getDay() %></td>
						<td align="center"><%= a.getDueDate() %></td>
						<td align="center" colspan="3"><font size="+1" color="red"><b><%= title %> DUE</b></font></td>
					</tr>
					<%
								}
							}
						}
					}
					%>
				</table>
			</td>
		</tr>
	</table>
</body>
</html>

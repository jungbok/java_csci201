<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<% request.setAttribute(StringConstants.LOCATION, StringConstants.LECTURES_JSP); %>
<%@include file="nav_bar.jsp"%>

<% 	
	//System.out.println("dudates page loaded");
	//String search_result = "";
	//if(request.getParameter("queryTopic") != null) {
	//	search_result = request.getParameter("queryTopic");
	//	search_result = search_result.trim().toLowerCase();
	//	if(request.getParameter("queryTopic").length() == 0){
	//		//System.out.println("it got here");
	//		search_result = "-----";
	//	}
	//}
	//else {
		//System.out.println("how about here");
	//	search_result = "-----";
	//}
	
	//String button_value = "";
	//int button_val = 0;
	//if(request.getParameter("button_val") != null) {
		//button_value = request.getParameter("button_val");
		//button_val = Integer.parseInt(button_value);
	//}
	//else {
		//button_val = 0;
	//}
%>
<% 
	Schedule schedule = course.getSchedule(); 
%>
<!--  the start tags here that are commented out are included in the nav_bar.jsp
<html>
<body>
	<table id="lecturetable">
		<tr>
			<td> -->
				<p>
				<hr size="4"/>
				<input type="text" name="queryTopic" id="queryTopic" disabled>
				<button type="button" id="searchTopicsButton" value=searchTopics" onClick="searchTopics()">Search Topics</button>
				<button type="button" id="clearTopicsButton" value="clearTopics" onClick="clearTopics()">Clear Topics</button>
				</p>
				<p>
				<hr size="4"/>
				<div id="sortByButtons">
					<label><input type='radio' id="l" name='sortBy' value='1' onClick="sortDisplay()">Show Lectures</label>
					<label><input type='radio' id="d" name='sortBy' value='2' onClick="sortDisplay()" checked>Show Due Dates</label>
					<label><input type='radio' id="a" name='sortBy' value='3' onClick="sortDisplay()">Show All</label>
				</div>
				</p>
				<% 
        		for (int i = 0; i<schedule.getTextbooks().size(); i++)
        		{
      	  			Textbook text = schedule.getTextbooks().get(i);
        		%>
				<p>
				<hr size="4" />
				</p> <b>Chapter references are from <%= text.getAuthor() %> <u><%= text.getTitle() %>
				</u>, <%= text.getPublisher() %>, <%= text.getYear() %>. ISBN <%= text.getIsbn() %></b>
				<%
				} 
				%>
				<p>
				<hr size="4" />
				</p> <b>Lectures</b>
				<table border="2" cellpadding="5" width="790">
					<tr>
						<th align="center">Week #</th>
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
						<td align="center" colspan="3"><%= week.getWeek() %></td>
						<%
						for (int i = 0; i<week.getLectures().size(); i++){
							
							if (i != 0)
							{
						%>
					<tr>
							<%
							}
						
             				Lecture l1 = week.getLectures().get(i);
            				%>
							<%
							List<GeneralAssignment> assigns = week.getMappedDueDates().get(l1.getNumber());
							if (assigns != null)
							{
								int k = 0;
								for (GeneralAssignment a : assigns)
								{
									k++;
									String title = (a instanceof Assignment ? "ASSIGNMENT "+a.getNumber() : a.getTitle());
									if(l1.getDay().equals("Thursday")) {
										%>
										<td align="center" colspan="3"></td>
										<%
									}
									if(k > 1) {
										%>
										<td align="center" colspan="3"></td>
										<%
									}
									
							%>
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

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<% request.setAttribute(StringConstants.LOCATION, StringConstants.ASSIGNMENTS_JSP); %>
<%@include file="nav_bar.jsp"%>
<% 
	String tempOrder = "";
	if(request.getParameter("sort_val") != null) {
		tempOrder = request.getParameter("sort_val");
	}
	else {
	//System.out.println("input null");
	}
	int sortOrder = 0;
	if(tempOrder!=null && (!tempOrder.isEmpty())){
		sortOrder = Integer.parseInt(tempOrder);
	}
	
	String tempDOrder = "";
	if(request.getParameter("d_val") != null) {
		tempDOrder = request.getParameter("d_val");
	}
	else {
	//System.out.println("input null");
	}
	int DOrder = 0;
	if(tempDOrder!=null && (!tempDOrder.isEmpty())){
		DOrder = Integer.parseInt(tempDOrder);
	}
	
	Assignment Final = course.getFinalProject();
	List<Deliverable> df = Final.getDeliverables();
	
	List<Deliverable> dfsortDue = course.getDDSorted(df, DOrder);
	List<Deliverable> dfsortTitle = course.getDTSorted(df, DOrder);
	List<Deliverable> dfsortGrade = course.getDGSorted(df, DOrder);
	
	for(int k = 0; k < df.size(); k++){
		Deliverable d = df.get(k);
		if(d.getTitle() == null){
			dfsortTitle.add(d);	
		}
		if(d.getDueDate() == null){
			dfsortDue.add(d);
		}
		if(d.getGradePercentage() == null){
			dfsortGrade.add(d);
		}
	}
	

	//System.out.println("sortOrder: " + sortOrder);
	List<Assignment> ass = course.getAssignments();
	
	List<Assignment> asortDue = course.getDueSortedAs(ass,sortOrder);
	List<Assignment> asortAss = course.getAssignSortedAs(ass,sortOrder);
	List<Assignment> asortTitle = course.getTSortedAListAscending(ass,sortOrder);
	List<Assignment> asortGrade = course.getGradeSortedAs(ass,sortOrder);
	
	

	for(int j = 0; j < ass.size(); j++){
		Assignment a = ass.get(j);
		if(a.getTitle() == null){
			asortTitle.add(a);
		}
		if(a.getDueDate() == null){
			asortDue.add(a);
		}
		if(a.getAssignedDate() == null){
			asortAss.add(a);
		}
		if(a.getGradePercentage() == null)
			asortGrade.add(a);
	}

	//for(int i = 0; i < asortGrade.size(); i++){
	//	Assignment t = asortGrade.get(i);
	//	System.out.println(t.getGradePercentage());
	//}
%>
<!--  the start tags here that are commented out are included in the nav_bar.jsp
<html>
<body>
	<table>
		<tr>
			<td> -->
			<div id="DeliverablesortByButtons1">
					Final Project Deliverables -- Sort by
					<label><input type='radio' id="ddd" name='sortBy' value='1' onClick="DsortAssignment()">Due Date</label>
					<label><input type='radio' id="dt" name='sortBy' value='3' onClick="DsortAssignment()">Title</label>
					<label><input type='radio' id="dgp" name='sortBy' value='4' onClick="DsortAssignment()">Grade Percentage</label><br/>

					<label><input type='radio' id="dascending" name='sort' value='1' onClick="DsortAssignment()">Ascending Order</label>
					<label><input type='radio' id="ddescending" name='sort' value='2' onClick="DsortAssignment()">Descending Order</label>
				</div>
				
			<div id="sortByButtons">
					Assignments -- Sort by
					<label><input type='radio' id="dd" name='sortBy' value='1' onClick="sortAssignment()">Due Date</label>
					<label><input type='radio' id="ad" name='sortBy' value='2' onClick="sortAssignment()">Assigned Due</label>
					<label><input type='radio' id="t" name='sortBy' value='3' onClick="sortAssignment()">Title</label>
					<label><input type='radio' id="gp" name='sortBy' value='4' onClick="sortAssignment()">Grade Percentage</label></br>
					
					<label><input type='radio' id="ascending" name='sort' value='1' onClick="sortAssignment()">Ascending Order</label>
					<label><input type='radio' id="descending" name='sort' value='2' onClick="sortAssignment()">Descending Order</label>
				</div>
				<p>
				<hr size="4" />
				</p>
				<b>Assignments</b>
				<table id= "assignmentinfo" border="2" cellpadding="5" width="890">
					<tr>
						<th align="center">Homework #</th>
						<th align="center" width="100">Assigned</th>
						<th align="center" width="100">Due</th>
						<th>Assignment</th>
						<th>% Grade</th>
						<th>Grading Criteria</th>
						<th>Solution</th>
					</tr>
					<%
					List<Assignment> assTable = null;
					if(sortOrder == 10 || sortOrder == 20){
						assTable = asortDue;
					}
					else if(sortOrder == 11 || sortOrder == 21){
						assTable = asortAss;
					}
					else if(sortOrder == 12 || sortOrder == 22){
						assTable = asortTitle;
					}
					else if(sortOrder == 13 || sortOrder == 23){
						assTable = asortGrade;
					}
					else{
						assTable = ass;
					}
					
				    for (Assignment assignment : assTable)
				    {
				      	if (!assignment.equals(course.getFinalProject()))
				      	{ 
					%>
					<tr>
						<td align="center"><%= assignment.getNumber() %></td>
						<td align="center"><%= assignment.getAssignedDate() %></td>
						<td align="center"><%= assignment.getDueDate() %></td>
						<td align="center">
							<% 
							if (assignment.getTitle() != null)
				            { 
				            %> 
				            <a href="<%= assignment.getUrl() %>"><%= assignment.getTitle() %></a>
							<hr /> 
							<%  	
				            } 
				            if (assignment.getFiles() != null)
				            { 
				            	for (File file : assignment.getFiles())
				            	{ 
				            %> 
				            <a href="<%= file.getUrl() %>"><%= file.getTitle() %></a>
							<hr /> 
							<%
				               	} 
				           	 }
				           	 %>
						</td>
						<td align="center"><%= assignment.getGradePercentage() %></td>
						<td align="center">
							<% 
							if (assignment.getGradingCriteriaFiles() != null)
							{ 
							 	for (File file : assignment.getGradingCriteriaFiles())
							 	{ 
							%> 	  
							<a href="<%= file.getUrl() %>"><%= file.getTitle() %></a>
							<hr /> 
							<%
								} 
							}
							%>
						</td>
						<td align="center">
							<% 
							if (assignment.getSolutionFiles() != null)
				            { 
				            	for (File file : assignment.getSolutionFiles())
				            	{ 
				           	%> 
				           <a href="<%= file.getUrl() %>"><%= file.getTitle() %></a>
							<hr /> 
							<%
								} 
				            }
				            %>
						</td>
					</tr>
					<%
						} 
					}
				    Assignment finalProject = course.getFinalProject();
				       
			       	if (finalProject != null)
			       	{ 
			   	    %>
					<tr>
						<td align="center"><%= finalProject.getNumber() %></td>
						<td align="center"><%= finalProject.getAssignedDate() %></td>
						<td align="center" colspan="3">
							<table border="1" cellpadding="5">
								<tr>
									<td colspan="3" align="center"><a
										href="<%= finalProject.getUrl() %>"><%= finalProject.getTitle() %></a>
										<hr /> 
						<% 
						for (File file : finalProject.getFiles()) 
						{
						%> 
				        				<a href="<%= file.getUrl() %>"><%= file.getTitle() %></a>
				
						<% 
						} 
						%>
									</td>
								</tr>
						<% 
						List<Deliverable> dTable = null;
						if(DOrder == 10 || DOrder == 20){
							dTable = dfsortDue;
						}
						else if(DOrder == 11 || DOrder == 21){
							dTable = dfsortTitle;
						}
						else if(DOrder == 12 || DOrder == 22){
							dTable = dfsortGrade;
						}
						else{
							dTable = df;
						}
						
						for (Deliverable del : dTable)
				        { 
				        %>
								<tr>
									<td><%= del.getDueDate() %></td>
									<td><%= del.getTitle() %> 
							<% 
							if (del.getFiles() != null) 
				            {
				            %> 		<br /> 
				            	<% 
				            	for (File file : del.getFiles())
				                { 
				                %> 
				                	<a href="<%= file.getUrl() %>"><%= file.getTitle() %></a>
										<hr /> 
							<%
								} 
				            }
				            %>
				            		</td>
									<td><%= del.getGradePercentage() %></td>
								</tr>
						<%
						} 
						%>
							</table>
						</td>
					</tr>
					<%
					}
					%>
				</table>
			</td>
		</tr>
	</table>
</body>
</html>

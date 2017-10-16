<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<% request.setAttribute(StringConstants.LOCATION, StringConstants.HOME_JSP); %>
<%@include file="nav_bar.jsp"%>
<!--  
<%
//gets the name that the user put in the search box
String searchName= "";
if(request.getParameter("input") != null) {
	searchName = request.getParameter("input").toLowerCase();

}
else {
	//System.out.println("input null");
}


%>
-->
<!--  the start tags here that are commented out are included in the nav_bar.jsp
<body>
	<table>
		<tr>
			<td> -->
			<hr size="4">
			<input type = "text" name ="input" id="input">
			<button type="button" class="button1" id="searchbutton" value="search" onClick="search()">Search Staff </button>
			<button type="button" class="button1" id="clearbutton" value="clearsearch" onClick="clearSearch()">Clear Search </button>
			<hr />			
				<p>
				<hr size="4" />
				</p>
				<p></p>
				<table id="t1" border="1">
					<tr>
						<th align="center">Picture</th>
						<th align="center">Professor</th>
						<th align="center">Office</th>
						<th align="center">Phone</th>
						<th align="center">Email</th>
						<th align="center">Office Hours</th>
					</tr>
				<% 
				List<StaffMember> professors = course.getSortedStaff().get(StringConstants.INSTRUCTOR);
              	for (int i = 0; i<professors.size(); i++)
              	{ 
            		StaffMember prof = professors.get(i);
              	%>
					<tr>
					<%String pfName = prof.getName().getFirstName().toLowerCase();
					  String plName = prof.getName().getLastName().toLowerCase();
					  String pName = pfName + " " + plName;
					if(pfName.equals(searchName) || plName.equals(searchName) || pName.equals(searchName)){ %>
						<td><img id = "profimage" src="<%= prof.getImage() %>" /></td>
						<td bgcolor = "00FFFF"><font size="-1"><%= prof.getName().getFirstName() %> <%= prof.getName().getLastName() %></font></td>
						<td><font size="-1"><%= prof.getOffice() %></font></td>
						<td><font size="-1"><%= prof.getPhone() %></font></td>
						<td bgcolor = "00FFFF"><font size="-1"><%= prof.getEmail() %></font></td>
						<td><font size="-1"> 
						<%} else{ %>
						<td><img width="100" height="100" src="<%= prof.getImage() %>" /></td>
						<td><font size="-1"><%= prof.getName().getFirstName() %> <%= prof.getName().getLastName() %></font></td>
						<td><font size="-1"><%= prof.getOffice() %></font></td>
						<td><font size="-1"><%= prof.getPhone() %></font></td>
						<td><font size="-1"><%= prof.getEmail() %></font></td>
						<td><font size="-1"> 
						<%} %>
					<%
                	List<TimePeriod> oh = prof.getOH();
                	for (int j = 0; j<oh.size(); j++)
                	{
                		TimePeriod current = oh.get(j);
                
                	%> 
                		<%= current.getDay() %> <%= current.getTime().getStartTime() %>- <%= current.getTime().getEndTime() %>
								<hr /> 
					<%
                  	}
               		%>
						</font></td>
					</tr>
				<%
              	}
             	%>
				</table> <br />
				<p>
				<hr size="4" />
				</p> <b><font size="+1">Lecture Schedule</font></b> 
				<%
          		List<Meeting> lectures = course.getSortedMeetings().get(StringConstants.LECTURE);
          		%>
				<table id ="t2" border="2" cellpadding="5" width="590">
					<tr>
						<th align="center">Sect. No.</th>
						<th align="center">Day &amp; Time</th>
						<th align="center">Room</th>
						<th>Lecture Assistant</th>
					</tr>
				<% 
				for (int i = 0; i<lectures.size(); i++)
				{
	            	Meeting lecture = lectures.get(i);
            	%>
					<tr>
						<td align="center"><font size="-1"><%= lecture.getSection() %></font></td>
						<td align="center"><font size="-1"><%= lecture.getListedDays() %><br /><%= lecture.getListedTimes() %></font></td>
						<td align="center"><font size="-1"><%= lecture.getRoom() %></font></td>
					<%
              		Map<Integer, StaffMember> staffMap = course.getMappedStaff();
					
              		for (int p = 0; p<lecture.getAssistants().size(); p++)
              		{
            	  		Integer id = lecture.getAssistants().get(p).getID();
            	  		StaffMember staffMember = staffMap.get(id);
              		%>
              		<%
              		String sfName = staffMember.getName().getFirstName().toLowerCase();
					String slName = staffMember.getName().getLastName().toLowerCase();
					String sName = sfName + " " + slName;
					if(sfName.equals(searchName) || slName.equals(searchName) || sName.equals(searchName)){
              		 %>
						<td bgcolor = "00FFFF" align="center"><font size="-1"><img src="<%= staffMember.getImage() %>"><br /> 
							<a href="mailto:<%= staffMember.getEmail() %>"><%= staffMember.getName().getFirstName() %>
									<%= staffMember.getName().getLastName() %></a></font></td>				
					<%} else{ %>
						<td align="center"><font size="-1"><img src="<%= staffMember.getImage() %>"><br /> 
							<a href="mailto:<%= staffMember.getEmail() %>"><%= staffMember.getName().getFirstName() %>
									<%= staffMember.getName().getLastName() %></a></font></td>
					<% } %>
					<%
              		}
              		%>
					</tr>
				<%
            	}
            	%>
				</table>
				<p>
				<hr size="4" />
				</p> <b><font size="+1">Lab Schedule</font></b>
				<table id = "t3" border="2" cellpadding="5" width="590">
					<tr>
						<th align="center">Sect. No.</th>
						<th align="center">Day &amp; Time</th>
						<th align="center">Room</th>
						<th align="center">Lab Assistants</th>
					</tr>
				<%
            	List<Meeting> labs = course.getSortedMeetings().get(StringConstants.LAB);
				
            	for (int i = 0; i<labs.size(); i++)
            	{
	            	Meeting lab = labs.get(i);
           		%>
					<tr>
						<td align="center"><font size="-1"><%= lab.getSection() %></font></td>
						<td align="center"><font size="-1"><%= lab.getListedDays() %><br /><%= lab.getListedTimes() %></font></td>
						<td align="center"><font size="-1"><%= lab.getRoom() %></font></td>
						<td align="center">
							<table border="0">
								<tr>
					<%
	              	Map<Integer, StaffMember> staffMap = course.getMappedStaff();
									
	              	for (int p = 0; p<lab.getAssistants().size(); p++)
	              	{
	            	  	Integer id = lab.getAssistants().get(p).getID();
	            	  	StaffMember staffMember = staffMap.get(id);
	            	  	
	            	  	String sfName1 = staffMember.getName().getFirstName().toLowerCase();
						String slName1 = staffMember.getName().getLastName().toLowerCase();
						String sName1 = sfName1 + " " + slName1;
						if(sfName1.equals(searchName) || slName1.equals(searchName) || sName1.equals(searchName)){
	             	%>
									<td bgcolor = "00ffff" align="center"><font size="-1"><img src="<%= staffMember.getImage() %>"><br /> 
										<a href="mailto:<%= staffMember.getEmail() %>"><%= staffMember.getName().getFirstName() %>
												<%= staffMember.getName().getLastName() %></a></font></td>
					<%} else { %>
									<td align="center"><font size="-1"><img src="<%= staffMember.getImage() %>"><br /> 
										<a href="mailto:<%= staffMember.getEmail() %>"><%= staffMember.getName().getFirstName() %>
												<%= staffMember.getName().getLastName() %></a></font></td>
					<%} %>
					<%
	              	}
	              	%>
								</tr>
							</table>
						</td>
					</tr>
				<% 
				} 
				%>
				</table> <br />
				<hr size="4" /> <br /> <b><font size="+1">Office Hours</font></b>
				- All staff office hours are held in the SAL Open Lab. Prof.
				Miller's office hours are listed above.<br />
				<table id="t4" border="1">
					<tr>
						<th></th>
				<% 
				for (String time : Course.officeHourTimes)
				{ 
				%>
						<th><%= time %></th>
				<%
				} 
				%>
					</tr>
				<% 
				StaffMember [][] officeHours = course.getOfficeHours();
 			  	String [] days = Course.officeHourDays;
 			  	
              	for (int i= 0; i<6; i++)
              	{  
              	%>
					<tr>
						<th><%= days[i] %></th>
					<% 
					for (int j = 0; j< 5; j++)
					{ 
            	  		StaffMember current = officeHours[i][j];
            	  		
              		%>
              		<%if (current != null)
		            	  		{
		            	  			String sfName2 = current.getName().getFirstName().toLowerCase();
		    						String slName2 = current.getName().getLastName().toLowerCase();
		    						String sName2 = sfName2 + " " + slName2;
		    						if(sfName2.equals(searchName) || slName2.equals(searchName) || sName2.equals(searchName)){ %>
						<td bgcolor = "00ffff">
							<table border="0">
								<tr>			
									<td><img src="<%= current.getImage() %>" /></td>
								</tr>
								<tr>
									<td><font size="-1"><a href="mailto:<%= current.getEmail() %>"><%= current.getName().getFirstName() %>
												<%= current.getName().getLastName() %></a><br />&nbsp;</font></td>
								</tr>	
							</table>
						</td>
						
						<%} else{ %>
								<td>
							<table border="0">
								<tr>
									<td><img src="<%= current.getImage() %>" /></td>
								</tr>
								<tr>
									<td><font size="-1"><a href="mailto:<%= current.getEmail() %>"><%= current.getName().getFirstName() %>
												<%= current.getName().getLastName() %></a><br />&nbsp;</font></td>
								</tr>	
							</table>
							</td>
									<%} %>
						<% 
						} 
              			else
              			{
              			%>
						<td></td>
					<%
              			}
            	  	} 
            	  	%>
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
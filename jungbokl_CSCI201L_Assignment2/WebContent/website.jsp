<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="objects.*" import="java.util.*" import="java.io.*" import="parsing.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>HomePage</title>

	<%
		Startparsing sp =(Startparsing)session.getAttribute("Startparsing");
		List<School> ls = sp.getSchools();
		School s = ls.get(0);
		List<Department> ld = s.getDepartments();
		Department d = ld.get(0);
		List<Course> lc = d.getCourses();
		Course c = lc.get(0);
		Syllabus sbus = c.getSyllabus();
		String syllabus = sbus.getUrl();
		
		String SchoolImage = s.getImage();
		String prefix = d.getPrefix();
		String Home = prefix + " " + c.getNumber();
		String fulln = c.getTitle();
		String units = c.getUnits() + " units";
		String sy = c.getTerm() + " " + c.getYear();
		
		List<StaffMember> memberList = c.getStaffMembers();
		Map<String, List<StaffMember>> sortedStaff = c.getSortedStaff();
		
		//HttpSession lectureSession = request.getSession();
		//HttpSession assginSession = request.getSession();
		//HttpSession examSession = request.getSession();
		//lectureSession.setAttribute("Startparsing", sp);
	
		//map for staffId and staffmember object
		Map<Integer, StaffMember> staffId = c.getMappedStaff();
		
				
		RequestDispatcher dispatch = getServletContext().getRequestDispatcher("/lectures.jsp");
		
		
		%>
	<body text="#333333" bgcolor="#EEEEEE" link="#0000EE" vlink="#551A8B" alink="#336633">
    <table cellpadding="10" width="800">
      <tr>
        <!-- column for left side of page -->
        <td width="180" valign="top" align="right">
          <a href="http://www.usc.edu"><img src=<%=SchoolImage%> border="0"/></a><br /><br />
          <font size="+1"><a href="http://cs.usc.edu"><%= prefix%> Department</a></font><br /><br />
          <font size="+1"><%= Home%> Home</font><br /><br />
          <font size="+1"><a href=<%=syllabus%>>Syllabus</a></font><br /><br />
          <font size="+1"><a href="lectures.jsp">Lectures</a></font><br /><br />
          <font size="+1"><a href="assignments.jsp">Assignments</a></font><br /><br />
          <font size="+1"><a href="exams.jsp">Previous Exams</a></font><br /><br />
        </td>
        <!-- center column to separate other two columns -->
        <td width="5"><br /></td>
        <!-- large column in center of page with dominant content -->
        <td align="baseline" width="615">
          <br />
          <p>
            <b><font size="+3"><%=Home%></font></b><br />
            <b><i><font size="+1"><%=fulln %> - <%=units %> </font></i></b><br />
            <b><i><font size="+1"><%=sy%></font></i></b><br />
          <p><hr size="4" /></p>
          <p></p>
          <p><font size="-1">
            <table border="1">
              <tr>
                <th align="center">Picture</th>
                <th align="center">Professor</th>
                <th align="center">Office</th>
                <th align="center">Phone</th>
                <th align="center">Email</th>
                <th align="center">Office Hours</th>
              </tr>
              <tr>
              <% 
              	List<StaffMember> instructor = null;
              	for(Map.Entry<String, List<StaffMember>> entry: sortedStaff.entrySet()){
              		if(entry.getKey().equals("instructor")){
              			instructor = entry.getValue();
              		}
              	}
              
              	for(int k = 0; k < instructor.size(); k++){
              		
         			StaffMember temp = instructor.get(k);
              		String image = temp.getImage();
              		String name = temp.getName().getFname() + " " + temp.getName().getLname();
              		String email = temp.getEmail();
              		String office = temp.getOffice();
              		String phone = temp.getPhone();
              		List<OfficeHour> oh = temp.getOfficeHours();
              %>
                <td><img width="100" height="100" src=<%=image %> /></td>
                <td><font size="-1"><%= name %></font></td>
                <td><font size="-1"><%= office %></font></td>
                <td><font size="-1"><%= phone %></font></td>
               	<td><font size="-1"><%= email %></font></td>
               	<td>
                <% for(int o = 0; o < oh.size(); o++){ 
                		String t = oh.get(o).getTime().getStart() + " " + oh.get(o).getTime().getEnd();
                		String officeh = oh.get(o).getDay() + " " + t;
                %>
                 
                <font size="-2"> 
                	<%=officeh%><hr />
                <%} %>
                  Any day by appointment
                </font></td>
              </tr>
              <%} %>
            </table>
            <br />
            
            <p><hr size="4" /></p>
          <b><font size="+1">Lecture Schedule</font></b>
          <table border="2" cellpadding="5" width="590">
            <tr>
              <th align="center">Sect. No.</th><th align="center">Day &amp; Time</th><th align="center">Room</th><th>Lecture Assistant</th>
            </tr>
            <tr>
            <% Map<String, List<Meeting>> sortedMeetings = c.getSortedMeetings();
            
            List<Meeting> lecture = null;
          	for(Map.Entry<String, List<Meeting>> entry: sortedMeetings.entrySet()){
          		if(entry.getKey().equals("lecture")){
          			lecture = entry.getValue();
          		}
          	}
            
            for(int l = 0; l < lecture.size(); l++){
            	Meeting m = lecture.get(l);
            	String section = m.getSection();
            %>
              <td align="center"><font size="-1"><%=section%></font></td>
              <td align="center">
              <%List<MeetingPeriod> mp = m.getMeetingPeriod();
              for(int x = 0; x < mp.size(); x++){
              	MeetingPeriod mpv = mp.get(x);
            	  String ltime = mpv.getDay() + " " + mpv.getTime().getStart() + " - "
              					+ mpv.getTime().getEnd(); %>
              <font size="-1"><%=ltime%></br>
              <%	} %>
              </font></td>
              	<%
              	String room = m.getRoom();
              	%>
              <td align="center"><font size="-1"><%=room %></font></td>
                <% List<Assistant> as = m.getAssistant();
                   for(int y = 0; y < as.size(); y++){
                	  int tempId = as.get(y).getStaffMemberID();
                	  StaffMember assist = staffId.get(tempId);
                	  String staffim = assist.getImage();
                	  String staffEmail = "mailto:" + assist.getEmail();
                	  Name staffName = assist.getName();
                	  String staffn = staffName.getFname() + " " + staffName.getLname();
                %>
              <td align="center"><font size="-1"><img src=<%=staffim %>><br /><a href=<%=staffEmail %>><%=staffn %></a></font></td>
               <%} %>
               </tr>
             <% } %>
          </table>
          
          <!-- Lab Schedule -->
          <p><hr size="4" /></p>
          <b><font size="+1">Lab Schedule</font></b>
          <table border="2" cellpadding="5" width="590">
            <tr>
              <th align="center">Sect. No.</th><th align="center">Day &amp; Time</th><th align="center">Room</th><th align="center">Lab Assistants</th>
            </tr>
            <tr>
            <% 
            List<Meeting> lab = null;
          	for(Map.Entry<String, List<Meeting>> labEntry: sortedMeetings.entrySet()){
          		if(labEntry.getKey().equals("lab")){
          			lab = labEntry.getValue();
          		}
          	}
            
          	//System.out.print(lab.size());
            for(int z = 0; z < lab.size(); z++){
            	Meeting lm = lab.get(z);
            	String lsection = lm.getSection();
            %>
              <td align="center"><font size="-1"><%=lsection %></font></td>
              <td align="center">
              
              <%List<MeetingPeriod> labmp = lm.getMeetingPeriod();
              	for(int t = 0; t < labmp.size(); t++){
              		MeetingPeriod lmp = labmp.get(t);
            	  	String labDay =lmp.getDay();
            	  	String labTime= lmp.getTime().getStart() + " - " + lmp.getTime().getEnd(); %>
              <font size="-1"><%=labDay%></br><%=labTime%>
              <%} %>
              </font></td>
              	<%
              	String labRoom = lm.getRoom();
              	%>
              <td align="center"><font size="-1"><%=labRoom %></font></td>
              <td align="center">
                <table border="0">
                  <tr>
                  <% //get lab assistant iterate through the lab assistant to get their information
                  	  List<Assistant> labAs = lm.getAssistant();
                   	  for(int f = 0; f < labAs.size(); f++){
                	  	int tempId = labAs.get(f).getStaffMemberID();
                	  	StaffMember labAssist = staffId.get(tempId);
                	  	String labAssistImage = labAssist.getImage();
                	  	String labAssistEmail = "mailto:" + labAssist.getEmail();
                	  	Name labStaffName = labAssist.getName();
                	  	String labStaffn = labStaffName.getFname() + " " + labStaffName.getLname();
                %>
                    <td align="center"><font size="-1"><img src=<%=labAssistImage%>><br /><a href=<%=labAssistEmail%>><%=labStaffn%></a></font></td>
                    <%} %>
                  </tr>
                </table>
              </td>
            </tr>
            <%} %>
            </table>
            
            
            <!-- Office Hour -->
             <br /><hr size="4" /><br />
            <b><font size="+1">Office Hours</font></b><br />
            <table border="1">
              <tr>
                <th></th>
                <th>10:00a.m.-12:00p.m.</th>
                <th>12:00p.m.-2:00p.m.</th>
                <th>2:00p.m.-4:00p.m.</th>
                <th>4:00p.m.-6:00p.m.</th>
                <th>6:00p.m.-8:00p.m.</th>
              </tr>
              <%
             List<StaffMember> staffOfficeHours = new ArrayList<>();
             for(int j =0; j < memberList.size(); j++){
          		StaffMember storeStaff = memberList.get(j);
              		
           		if(!(storeStaff.getJobType().equals("instructor"))){
           			if(storeStaff.getOfficeHours() != null){
           				staffOfficeHours.add(storeStaff);
            		//System.out.println(staffOfficeHours.size());
           		}
           }              
              
          }
              %>
          
                <%
                
                //inside the Maps, store all the staffmembers sorted on the office hour days
                Map<Integer, StaffMember> monStaff = new HashMap<Integer, StaffMember>();
                Map<Integer, StaffMember> tuesStaff = new HashMap<Integer, StaffMember>();
                Map<Integer, StaffMember> wednesStaff = new HashMap<Integer, StaffMember>();
                Map<Integer, StaffMember> thursStaff = new HashMap<Integer, StaffMember>();
                Map<Integer, StaffMember> friStaff = new HashMap<Integer, StaffMember>();
                Map<Integer, StaffMember> satStaff = new HashMap<Integer, StaffMember>();
                
                if(staffOfficeHours != null){
                	
                	for(int si = 0; si < staffOfficeHours.size(); si++){
                		StaffMember tempStaff = staffOfficeHours.get(si);
                		List<OfficeHour> tempOh = tempStaff.getOfficeHours();
                		
                		for(int ofi = 0; ofi < tempOh.size(); ofi++){
                			
                			String officeDay = tempOh.get(ofi).getDay();
                			String officeTime = tempOh.get(ofi).getTime().getStart() + "-" + tempOh.get(ofi).getTime().getEnd();
                			
                			//monday
                			if(officeDay.equals("Monday")){
                				if(officeTime.equals("10:00a.m.-12:00p.m.")){
                					monStaff.put(0, tempStaff);
                				}
                				else if(officeTime.equals("12:00p.m.-2:00p.m.")){
                					monStaff.put(1, tempStaff);
                				}
                				else if(officeTime.equals("2:00p.m.-4:00p.m.")){
                					monStaff.put(2, tempStaff);
                				}
                				else if(officeTime.equals("4:00p.m.-6:00p.m.")){
                					monStaff.put(3, tempStaff);
                				}
                				else if(officeTime.equals("6:00p.m.-8:00p.m.")){
                					monStaff.put(4, tempStaff);
                				}
           
                			}
                			//tuesday
                		else if(officeDay.equals("Tuesday")){
                			if(officeTime.equals("10:00a.m.-12:00p.m.")){
            					tuesStaff.put(0, tempStaff);
            				}
            				else if(officeTime.equals("12:00p.m.-2:00p.m.")){
            					tuesStaff.put(1, tempStaff);
            				}
            				else if(officeTime.equals("2:00p.m.-4:00p.m.")){
            					tuesStaff.put(2, tempStaff);
            				}
            				else if(officeTime.equals("4:00p.m.-6:00p.m.")){
            					tuesStaff.put(3, tempStaff);
            				}
            				else if(officeTime.equals("6:00p.m.-8:00p.m.")){
            					tuesStaff.put(4, tempStaff);
            				}
            				
                		}
                		//wednesday
                		else if(officeDay.equals("Wednesday")){
                			if(officeTime.equals("10:00a.m.-12:00p.m.")){
            					wednesStaff.put(0, tempStaff);
            				}
            				else if(officeTime.equals("12:00p.m.-2:00p.m.")){
            					wednesStaff.put(1, tempStaff);
            				}
            				else if(officeTime.equals("2:00p.m.-4:00p.m.")){
            					wednesStaff.put(2, tempStaff);
            				}
            				else if(officeTime.equals("4:00p.m.-6:00p.m.")){
            					wednesStaff.put(3, tempStaff);
            				}
            				else if(officeTime.equals("6:00p.m.-8:00p.m.")){
            					wednesStaff.put(4, tempStaff);
            				}
            				
                		}
                			//thursday
                		else if(officeDay.equals("Thursday")){
                			if(officeTime.equals("10:00a.m.-12:00p.m.")){
            					thursStaff.put(0, tempStaff);
            				}
            				else if(officeTime.equals("12:00p.m.-2:00p.m.")){
            					thursStaff.put(1, tempStaff);
            				}
            				else if(officeTime.equals("2:00p.m.-4:00p.m.")){
            					thursStaff.put(2, tempStaff);
            				}
            				else if(officeTime.equals("4:00p.m.-6:00p.m.")){
            					thursStaff.put(3, tempStaff);
            				}
            				else if(officeTime.equals("6:00p.m.-8:00p.m.")){
            					thursStaff.put(4, tempStaff);
            				}
            				
                		}
                			//friday
                		else if(officeDay.equals("Friday")){
                			if(officeTime.equals("10:00a.m.-12:00p.m.")){
            					friStaff.put(0, tempStaff);
            				}
            				else if(officeTime.equals("12:00p.m.-2:00p.m.")){
            					friStaff.put(1, tempStaff);
            				}
            				else if(officeTime.equals("2:00p.m.-4:00p.m.")){
            					friStaff.put(2, tempStaff);
            				}
            				else if(officeTime.equals("4:00p.m.-6:00p.m.")){
            					friStaff.put(3, tempStaff);
            				}
            				else if(officeTime.equals("6:00p.m.-8:00p.m.")){
            					friStaff.put(4, tempStaff);
            				}
            				
                		}
                			//saturday
                		else if(officeDay.equals("Saturday")){
                			if(officeTime.equals("10:00a.m.-12:00p.m.")){
            					satStaff.put(0, tempStaff);
            				}
            				else if(officeTime.equals("12:00p.m.-2:00p.m.")){
            					satStaff.put(1, tempStaff);
            				}
            				else if(officeTime.equals("2:00p.m.-4:00p.m.")){
            					satStaff.put(2, tempStaff);
            				}
            				else if(officeTime.equals("4:00p.m.-6:00p.m.")){
            					satStaff.put(3, tempStaff);
            				}
            				else if(officeTime.equals("6:00p.m.-8:00p.m.")){
            					satStaff.put(4, tempStaff);
            				}
            			
                		}
                	}
                }
           }
                	%>
              <!-- Monday Office Hours -->
                <tr>
                <th>Monday</th>
                
                <%
                String tempIm; 
                String tempEm;
                String tempName;
          		   if(monStaff.containsKey(0)){
          			   StaffMember tempMem = monStaff.get(0);
          			   tempIm = tempMem.getImage();
          			   tempEm = "mailto:" + tempMem.getEmail();
          			   tempName = tempMem.getName().getFname() + " " + tempMem.getName().getLname();
          		   }
          		   else{
          		       tempIm = " ";
          		       tempEm = " ";
          		       tempName = " ";	   
          		   }
                	%>               
               	<td><table border="0"><tr><td><img src=<%=tempIm%> /></td></tr><tr><td><font size="-1"><a href=<%=tempEm %>><%=tempName%></a><br />&nbsp;</font></td></tr></table></td>
                 <%
                 if(monStaff.containsKey(1)){
          			   StaffMember tempMem = monStaff.get(1);
          			   tempIm = tempMem.getImage();
          			   tempEm = "mailto:" + tempMem.getEmail();
          			   tempName = tempMem.getName().getFname() + " " + tempMem.getName().getLname();
          		   }
          		   else{
          		       tempIm = " ";
          		       tempEm = " ";
          		       tempName = " ";	   
          		   }
                	%>               
               	<td><table border="0"><tr><td><img src=<%=tempIm%> /></td></tr><tr><td><font size="-1"><a href=<%=tempEm %>><%=tempName%></a><br />&nbsp;</font></td></tr></table></td>
                 <%
                 if(monStaff.containsKey(2)){
          			   StaffMember tempMem = monStaff.get(2);
          			   tempIm = tempMem.getImage();
          			   tempEm = "mailto:" + tempMem.getEmail();
          			   tempName = tempMem.getName().getFname() + " " + tempMem.getName().getLname();
          		   }
          		   else{
          		       tempIm = " ";
          		       tempEm = " ";
          		       tempName = " ";	   
          		   }
                	%>               
               	<td><table border="0"><tr><td><img src=<%=tempIm%> /></td></tr><tr><td><font size="-1"><a href=<%=tempEm %>><%=tempName%></a><br />&nbsp;</font></td></tr></table></td>
                 <%
                 if(monStaff.containsKey(3)){
          			   StaffMember tempMem = monStaff.get(3);
          			   tempIm = tempMem.getImage();
          			   tempEm = "mailto:" + tempMem.getEmail();
          			   tempName = tempMem.getName().getFname() + " " + tempMem.getName().getLname();
          		   }
          		   else{
          		       tempIm = " ";
          		       tempEm = " ";
          		       tempName = " ";	   
          		   }
                	%>               
               	<td><table border="0"><tr><td><img src=<%=tempIm%> /></td></tr><tr><td><font size="-1"><a href=<%=tempEm %>><%=tempName%></a><br />&nbsp;</font></td></tr></table></td>
                 <%
                 if(monStaff.containsKey(4)){
          			   StaffMember tempMem = monStaff.get(4);
          			   tempIm = tempMem.getImage();
          			   tempEm = "mailto:" + tempMem.getEmail();
          			   tempName = tempMem.getName().getFname() + " " + tempMem.getName().getLname();
          		   }
          		   else{
          		       tempIm = " ";
          		       tempEm = " ";
          		       tempName = " ";	   
          		   }
                	%>               
               	<td><table border="0"><tr><td><img src=<%=tempIm%> /></td></tr><tr><td><font size="-1"><a href=<%=tempEm %>><%=tempName%></a><br />&nbsp;</font></td></tr></table></td>
              </tr>
              
              <!-- Tuesday -->
              <tr>
                <th>Tuesday</th>
                <%
                  if(tuesStaff.containsKey(0)){
          			   StaffMember tempMem = tuesStaff.get(0);
          			   tempIm = tempMem.getImage();
          			   tempEm = "mailto:" + tempMem.getEmail();
          			   tempName = tempMem.getName().getFname() + " " + tempMem.getName().getLname();
          		   }
          		   else{
          		       tempIm = " ";
          		       tempEm = " ";
          		       tempName = " ";	   
          		   }
                	%>               
               	<td><table border="0"><tr><td><img src=<%=tempIm%> /></td></tr><tr><td><font size="-1"><a href=<%=tempEm %>><%=tempName%></a><br />&nbsp;</font></td></tr></table></td>
                 <%
                 if(tuesStaff.containsKey(1)){
          			   StaffMember tempMem = tuesStaff.get(1);
          			   tempIm = tempMem.getImage();
          			   tempEm = "mailto:" + tempMem.getEmail();
          			   tempName = tempMem.getName().getFname() + " " + tempMem.getName().getLname();
          		   }
          		   else{
          		       tempIm = " ";
          		       tempEm = " ";
          		       tempName = " ";	   
          		   }
                	%>               
               	<td><table border="0"><tr><td><img src=<%=tempIm%> /></td></tr><tr><td><font size="-1"><a href=<%=tempEm %>><%=tempName%></a><br />&nbsp;</font></td></tr></table></td>
                 <%
                 if(tuesStaff.containsKey(2)){
          			   StaffMember tempMem = tuesStaff.get(2);
          			   tempIm = tempMem.getImage();
          			   tempEm = "mailto:" + tempMem.getEmail();
          			   tempName = tempMem.getName().getFname() + " " + tempMem.getName().getLname();
          		   }
          		   else{
          		       tempIm = " ";
          		       tempEm = " ";
          		       tempName = " ";	   
          		   }
                	%>               
               	<td><table border="0"><tr><td><img src=<%=tempIm%> /></td></tr><tr><td><font size="-1"><a href=<%=tempEm %>><%=tempName%></a><br />&nbsp;</font></td></tr></table></td>
                 <%
                 if(tuesStaff.containsKey(3)){
          			   StaffMember tempMem = tuesStaff.get(3);
          			   tempIm = tempMem.getImage();
          			   tempEm = "mailto:" + tempMem.getEmail();
          			   tempName = tempMem.getName().getFname() + " " + tempMem.getName().getLname();
          		   }
          		   else{
          		       tempIm = " ";
          		       tempEm = " ";
          		       tempName = " ";	   
          		   }
                	%>               
               	<td><table border="0"><tr><td><img src=<%=tempIm%> /></td></tr><tr><td><font size="-1"><a href=<%=tempEm %>><%=tempName%></a><br />&nbsp;</font></td></tr></table></td>
                 <%
                 if(tuesStaff.containsKey(4)){
          			   StaffMember tempMem = tuesStaff.get(4);
          			   tempIm = tempMem.getImage();
          			   tempEm = "mailto:" + tempMem.getEmail();
          			   tempName = tempMem.getName().getFname() + " " + tempMem.getName().getLname();
          		   }
          		   else{
          		       tempIm = " ";
          		       tempEm = " ";
          		       tempName = " ";	   
          		   }
                	%>               
               	<td><table border="0"><tr><td><img src=<%=tempIm%> /></td></tr><tr><td><font size="-1"><a href=<%=tempEm %>><%=tempName%></a><br />&nbsp;</font></td></tr></table></td>
              </tr>
               <!-- Wednesday -->
              <tr>
                <th>Wednesday</th>
                <%
                  if(wednesStaff.containsKey(0)){
          			   StaffMember tempMem = wednesStaff.get(0);
          			   tempIm = tempMem.getImage();
          			   tempEm = "mailto:" + tempMem.getEmail();
          			   tempName = tempMem.getName().getFname() + " " + tempMem.getName().getLname();
          		   }
          		   else{
          		       tempIm = " ";
          		       tempEm = " ";
          		       tempName = " ";	   
          		   }
                	%>               
               	<td><table border="0"><tr><td><img src=<%=tempIm%> /></td></tr><tr><td><font size="-1"><a href=<%=tempEm %>><%=tempName%></a><br />&nbsp;</font></td></tr></table></td>
                 <%
                 if(wednesStaff.containsKey(1)){
          			   StaffMember tempMem = wednesStaff.get(1);
          			   tempIm = tempMem.getImage();
          			   tempEm = "mailto:" + tempMem.getEmail();
          			   tempName = tempMem.getName().getFname() + " " + tempMem.getName().getLname();
          		   }
          		   else{
          		       tempIm = " ";
          		       tempEm = " ";
          		       tempName = " ";	   
          		   }
                	%>               
               	<td><table border="0"><tr><td><img src=<%=tempIm%> /></td></tr><tr><td><font size="-1"><a href=<%=tempEm %>><%=tempName%></a><br />&nbsp;</font></td></tr></table></td>
                 <%
                 if(wednesStaff.containsKey(2)){
          			   StaffMember tempMem = wednesStaff.get(2);
          			   tempIm = tempMem.getImage();
          			   tempEm = "mailto:" + tempMem.getEmail();
          			   tempName = tempMem.getName().getFname() + " " + tempMem.getName().getLname();
          		   }
          		   else{
          		       tempIm = " ";
          		       tempEm = " ";
          		       tempName = " ";	   
          		   }
                	%>               
               	<td><table border="0"><tr><td><img src=<%=tempIm%> /></td></tr><tr><td><font size="-1"><a href=<%=tempEm %>><%=tempName%></a><br />&nbsp;</font></td></tr></table></td>
                 <%
                 if(wednesStaff.containsKey(3)){
          			   StaffMember tempMem = wednesStaff.get(3);
          			   tempIm = tempMem.getImage();
          			   tempEm = "mailto:" + tempMem.getEmail();
          			   tempName = tempMem.getName().getFname() + " " + tempMem.getName().getLname();
          		   }
          		   else{
          		       tempIm = " ";
          		       tempEm = " ";
          		       tempName = " ";	   
          		   }
                	%>               
               	<td><table border="0"><tr><td><img src=<%=tempIm%> /></td></tr><tr><td><font size="-1"><a href=<%=tempEm %>><%=tempName%></a><br />&nbsp;</font></td></tr></table></td>
                 <%
                 if(wednesStaff.containsKey(4)){
          			   StaffMember tempMem = wednesStaff.get(4);
          			   tempIm = tempMem.getImage();
          			   tempEm = "mailto:" + tempMem.getEmail();
          			   tempName = tempMem.getName().getFname() + " " + tempMem.getName().getLname();
          		   }
          		   else{
          		       tempIm = " ";
          		       tempEm = " ";
          		       tempName = " ";	   
          		   }
                	%>               
               	<td><table border="0"><tr><td><img src=<%=tempIm%> /></td></tr><tr><td><font size="-1"><a href=<%=tempEm %>><%=tempName%></a><br />&nbsp;</font></td></tr></table></td>
              </tr>
               
             <!-- Thursday Office Hour -->
              <tr>
                <th>Thursday</th>
                <%
                  if(thursStaff.containsKey(0)){
          			   StaffMember tempMem = thursStaff.get(0);
          			   tempIm = tempMem.getImage();
          			   tempEm = "mailto:" + tempMem.getEmail();
          			   tempName = tempMem.getName().getFname() + " " + tempMem.getName().getLname();
          		   }
          		   else{
          		       tempIm = " ";
          		       tempEm = " ";
          		       tempName = " ";	   
          		   }
                	%>               
               	<td><table border="0"><tr><td><img src=<%=tempIm%> /></td></tr><tr><td><font size="-1"><a href=<%=tempEm %>><%=tempName%></a><br />&nbsp;</font></td></tr></table></td>
                 <%
                 if(thursStaff.containsKey(1)){
          			   StaffMember tempMem = thursStaff.get(1);
          			   tempIm = tempMem.getImage();
          			   tempEm = "mailto:" + tempMem.getEmail();
          			   tempName = tempMem.getName().getFname() + " " + tempMem.getName().getLname();
          		   }
          		   else{
          		       tempIm = " ";
          		       tempEm = " ";
          		       tempName = " ";	   
          		   }
                	%>               
               	<td><table border="0"><tr><td><img src=<%=tempIm%> /></td></tr><tr><td><font size="-1"><a href=<%=tempEm %>><%=tempName%></a><br />&nbsp;</font></td></tr></table></td>
                 <%
                 if(thursStaff.containsKey(2)){
          			   StaffMember tempMem = thursStaff.get(2);
          			   tempIm = tempMem.getImage();
          			   tempEm = "mailto:" + tempMem.getEmail();
          			   tempName = tempMem.getName().getFname() + " " + tempMem.getName().getLname();
          		   }
          		   else{
          		       tempIm = " ";
          		       tempEm = " ";
          		       tempName = " ";	   
          		   }
                	%>               
               	<td><table border="0"><tr><td><img src=<%=tempIm%> /></td></tr><tr><td><font size="-1"><a href=<%=tempEm %>><%=tempName%></a><br />&nbsp;</font></td></tr></table></td>
                 <%
                 if(thursStaff.containsKey(3)){
          			   StaffMember tempMem = thursStaff.get(3);
          			   tempIm = tempMem.getImage();
          			   tempEm = "mailto:" + tempMem.getEmail();
          			   tempName = tempMem.getName().getFname() + " " + tempMem.getName().getLname();
          		   }
          		   else{
          		       tempIm = " ";
          		       tempEm = " ";
          		       tempName = " ";	   
          		   }
                	%>               
               	<td><table border="0"><tr><td><img src=<%=tempIm%> /></td></tr><tr><td><font size="-1"><a href=<%=tempEm %>><%=tempName%></a><br />&nbsp;</font></td></tr></table></td>
                 <%
                 if(thursStaff.containsKey(4)){
          			   StaffMember tempMem = thursStaff.get(4);
          			   tempIm = tempMem.getImage();
          			   tempEm = "mailto:" + tempMem.getEmail();
          			   tempName = tempMem.getName().getFname() + " " + tempMem.getName().getLname();
          		   }
          		   else{
          		       tempIm = " ";
          		       tempEm = " ";
          		       tempName = " ";	   
          		   }
                	%>               
               	<td><table border="0"><tr><td><img src=<%=tempIm%> /></td></tr><tr><td><font size="-1"><a href=<%=tempEm %>><%=tempName%></a><br />&nbsp;</font></td></tr></table></td>
              </tr>
             <!-- Friday Office Hours  -->
              <tr>
                <th>Friday</th>
                
                <%
                  if(friStaff.containsKey(0)){
          			   StaffMember tempMem = friStaff.get(0);
          			   tempIm = tempMem.getImage();
          			   tempEm = "mailto:" + tempMem.getEmail();
          			   tempName = tempMem.getName().getFname() + " " + tempMem.getName().getLname();
          		   }
          		   else{
          		       tempIm = " ";
          		       tempEm = " ";
          		       tempName = " ";	   
          		   }
                	%>               
               	<td><table border="0"><tr><td><img src=<%=tempIm%> /></td></tr><tr><td><font size="-1"><a href=<%=tempEm %>><%=tempName%></a><br />&nbsp;</font></td></tr></table></td>
                 <%
                 if(friStaff.containsKey(1)){
          			   StaffMember tempMem = friStaff.get(1);
          			   tempIm = tempMem.getImage();
          			   tempEm = "mailto:" + tempMem.getEmail();
          			   tempName = tempMem.getName().getFname() + " " + tempMem.getName().getLname();
          		   }
          		   else{
          		       tempIm = " ";
          		       tempEm = " ";
          		       tempName = " ";	   
          		   }
                	%>               
               	<td><table border="0"><tr><td><img src=<%=tempIm%> /></td></tr><tr><td><font size="-1"><a href=<%=tempEm %>><%=tempName%></a><br />&nbsp;</font></td></tr></table></td>
                 <%
                 if(friStaff.containsKey(2)){
          			   StaffMember tempMem = friStaff.get(2);
          			   tempIm = tempMem.getImage();
          			   tempEm = "mailto:" + tempMem.getEmail();
          			   tempName = tempMem.getName().getFname() + " " + tempMem.getName().getLname();
          		   }
          		   else{
          		       tempIm = " ";
          		       tempEm = " ";
          		       tempName = " ";	   
          		   }
                	%>               
               	<td><table border="0"><tr><td><img src=<%=tempIm%> /></td></tr><tr><td><font size="-1"><a href=<%=tempEm %>><%=tempName%></a><br />&nbsp;</font></td></tr></table></td>
                 <%
                 if(friStaff.containsKey(3)){
          			   StaffMember tempMem = friStaff.get(3);
          			   tempIm = tempMem.getImage();
          			   tempEm = "mailto:" + tempMem.getEmail();
          			   tempName = tempMem.getName().getFname() + " " + tempMem.getName().getLname();
          		   }
          		   else{
          		       tempIm = " ";
          		       tempEm = " ";
          		       tempName = " ";	   
          		   }
                	%>               
               	<td><table border="0"><tr><td><img src=<%=tempIm%> /></td></tr><tr><td><font size="-1"><a href=<%=tempEm %>><%=tempName%></a><br />&nbsp;</font></td></tr></table></td>
                 <%
                 if(friStaff.containsKey(4)){
          			   StaffMember tempMem = friStaff.get(4);
          			   tempIm = tempMem.getImage();
          			   tempEm = "mailto:" + tempMem.getEmail();
          			   tempName = tempMem.getName().getFname() + " " + tempMem.getName().getLname();
          		   }
          		   else{
          		       tempIm = " ";
          		       tempEm = " ";
          		       tempName = " ";	   
          		   }
                	%>               
               	<td><table border="0"><tr><td><img src=<%=tempIm%> /></td></tr><tr><td><font size="-1"><a href=<%=tempEm %>><%=tempName%></a><br />&nbsp;</font></td></tr></table></td>
              </tr>
              <!-- Saturaday Office Hours -->
              <tr>
                <th>Saturday</th>
              
                <%
                  if(satStaff.containsKey(0)){
          			   StaffMember tempMem = satStaff.get(0);
          			   tempIm = tempMem.getImage();
          			   tempEm = "mailto:" + tempMem.getEmail();
          			   tempName = tempMem.getName().getFname() + " " + tempMem.getName().getLname();
          		   }
          		   else{
          		       tempIm = " ";
          		       tempEm = " ";
          		       tempName = " ";	   
          		   }
                	%>               
               	<td><table border="0"><tr><td><img src=<%=tempIm%> /></td></tr><tr><td><font size="-1"><a href=<%=tempEm %>><%=tempName%></a><br />&nbsp;</font></td></tr></table></td>
                 <%
                 if(satStaff.containsKey(1)){
          			   StaffMember tempMem = satStaff.get(1);
          			   tempIm = tempMem.getImage();
          			   tempEm = "mailto:" + tempMem.getEmail();
          			   tempName = tempMem.getName().getFname() + " " + tempMem.getName().getLname();
          		   }
          		   else{
          		       tempIm = " ";
          		       tempEm = " ";
          		       tempName = " ";	   
          		   }
                	%>               
               	<td><table border="0"><tr><td><img src=<%=tempIm%> /></td></tr><tr><td><font size="-1"><a href=<%=tempEm %>><%=tempName%></a><br />&nbsp;</font></td></tr></table></td>
                 <%
                 if(satStaff.containsKey(2)){
          			   StaffMember tempMem = satStaff.get(2);
          			   tempIm = tempMem.getImage();
          			   tempEm = "mailto:" + tempMem.getEmail();
          			   tempName = tempMem.getName().getFname() + " " + tempMem.getName().getLname();
          		   }
          		   else{
          		       tempIm = " ";
          		       tempEm = " ";
          		       tempName = " ";	   
          		   }
                	%>               
               	<td><table border="0"><tr><td><img src=<%=tempIm%> /></td></tr><tr><td><font size="-1"><a href=<%=tempEm %>><%=tempName%></a><br />&nbsp;</font></td></tr></table></td>
                 <%
                 if(satStaff.containsKey(3)){
          			   StaffMember tempMem = satStaff.get(3);
          			   tempIm = tempMem.getImage();
          			   tempEm = "mailto:" + tempMem.getEmail();
          			   tempName = tempMem.getName().getFname() + " " + tempMem.getName().getLname();
          		   }
          		   else{
          		       tempIm = " ";
          		       tempEm = " ";
          		       tempName = " ";	   
          		   }
                	%>               
               	<td><table border="0"><tr><td><img src=<%=tempIm%> /></td></tr><tr><td><font size="-1"><a href=<%=tempEm %>><%=tempName%></a><br />&nbsp;</font></td></tr></table></td>
                 <%
                 if(satStaff.containsKey(4)){
          			   StaffMember tempMem = satStaff.get(4);
          			   tempIm = tempMem.getImage();
          			   tempEm = "mailto:" + tempMem.getEmail();
          			   tempName = tempMem.getName().getFname() + " " + tempMem.getName().getLname();
          		   }
          		   else{
          		       tempIm = " ";
          		       tempEm = " ";
          		       tempName = " ";	   
          		   }
                	%>               
               	<td><table border="0"><tr><td><img src=<%=tempIm%> /></td></tr><tr><td><font size="-1"><a href=<%=tempEm %>><%=tempName%></a><br />&nbsp;</font></td></tr></table></td>
              </tr>   
            </table>
             
       </td>
      </tr>
    </table>
</body>
</html>
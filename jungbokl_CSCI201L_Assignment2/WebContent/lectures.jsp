<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="objects.*" import="java.util.*" import="parsing.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<%	

	//Start parsing and brings the data	
	Startparsing sp2 = (Startparsing)session.getAttribute("Startparsing");
	List<School> ls = sp2.getSchools();
	School s = ls.get(0);
	List<Department> ld = s.getDepartments();
	Department d = ld.get(0);
	List<Course> lc = d.getCourses();
	Course c = lc.get(0);
	
	//data needed for the logo and the generals
	String SchoolImage = s.getImage();
	String prefix = d.getPrefix();
	String Home = prefix + " " + c.getNumber();
	String fulln = c.getTitle();
	String units = c.getUnits() + " units";
	String sy = c.getTerm() + " " + c.getYear();
	Syllabus sbus = c.getSyllabus();
	String syllabus = sbus.getUrl();
	
	Schedule schedule = c.getSchedule();
	List<Textbook> textbook = schedule.getTextbooks();
	Textbook oneText = textbook.get(0);
	String tTitle = oneText.getTitle();
	String tPublisher = oneText.getPublisher();
	String tYear= oneText.getYear();
	String tAuthor = oneText.getAuthor();
	String tIsbn = oneText.getIsbn();
	
	List<Week> weeks = schedule.getWeeks();
	List<Assignment> assignment = c.getAssignments();
	
	
	RequestDispatcher dispatch = getServletContext().getRequestDispatcher("/exams.jsp");
%>

  <title><%=prefix%> <%=sy%></title>

  </head>
  <body text="#333333" bgcolor="#EEEEEE" link="#0000EE" vlink="#551A8B" alink="#336633">
    <table cellpadding="10" width="800">
      <tr>
        <!-- column for left side of page -->
        <td width="180" valign="top" align="right">
          <a href="http://www.usc.edu"><img src=<%=SchoolImage%> border="0"/></a><br /><br />
          <font size="+1"><a href="http://cs.usc.edu"><%= prefix%> Department</a></font><br /><br />
          <font size="+1"><a href=website.jsp><%=Home %>Home</a></font><br /><br />
          <font size="+1"><a href=<%=syllabus%>>Syllabus</a></font><br /><br />
          <font size="+1">Lectures</font><br /><br />
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
          <p><hr size="4" /></p>
            <b>Chapter references are from <%=tAuthor %> <u><%=tTitle%></u>, <%=tPublisher%>, <%=tYear%>. ISBN <%=tIsbn %></b>
            
          
          
          <!-- lecture table starts here -->
           <p><hr size="4" /></p>
          <b>Lectures</b>
          <table border="2" cellpadding="5" width="590">
            <tr>
              <th align="center">Week #</th><th align="center">Lab</th><th align="center">Lecture #</th><th align="center">Day</th><th align="center" width="40">Date</th><th align="center">Lecture Topic</th><th align="center">Chapter</th><th>Program</th>
            </tr>
            <!-- Starting for loop for the table -->
            <% for(int i = 0; i < weeks.size(); i++){
             	List<Lab> labs = weeks.get(i).getLabs();
             	List<Lecture> lectures = weeks.get(i).getLectures();
             	%>
            <tr>
              <td align="center" rowspan="3"><%=i + 1%></td>
              <td align="center" rowspan="3"> 
              <!-- for loop for all the lab -->             
              <% if(labs != null){
              		for(int j = 0; j < labs.size(); j++){ 
              			Lab tempLab = labs.get(j);
              			String labTitle = tempLab.getTitle();
              			String labUrl = tempLab.getUrl();
              			List<File> labFiles = new ArrayList<>();
              			if(tempLab.getFiles()!=null){
              				labFiles = tempLab.getFiles();
              			}
              %>
              <%if(j == labs.size()-1){ %>
                <a href=<%=labUrl%>><%=labTitle%></a><br />
                 <!-- for loop for the Lab Files -->
                	<% if(labFiles != null){
                		for(int k = 0; k < labFiles.size(); k++){
                			File labf = labFiles.get(k);
                			String fileUrl = labf.getUrl();
                			String fileTitle = labf.getTitle();
                	%>
                		<a href=<%=fileUrl%>><%=fileTitle%></a><br />
                		<%}
                		%>
                <%}
              	}else{ %>
                <a href=<%=labUrl%>><%=labTitle%></a><br/>
                <% if(labFiles != null){
                		for(int l = 0; l < labFiles.size(); l++){
                			File labf = labFiles.get(l);
                			String fileUrl = labf.getUrl();
                			String fileTitle = labf.getTitle();
                	%>
                		<a href=<%=fileUrl%>><%=fileTitle%></a><br />
                		<%} %>
                		<hr />
             	<%	}
                	}
              	}
            	%>
             </td>
             <%
             }else if(labs == null){
             %>
             <td align="center">No Lab</td>
             <% } 
             
             
             	for(int m = 0; m < lectures.size(); m++ ){
             		Lecture tempLec = lectures.get(m);
             		String lectureNum = tempLec.getNumber();
             		String lectureDate = tempLec.getDate();
             		String lectureDay = tempLec.getDay();
             		List<Topic> lecTopic = tempLec.getTopics();
             		List<String> chapterAdd = new ArrayList<>();
          			//Map<Integer, List<Program>> programList = new HashMap<Integer,List<Program>>();
          			List<List<Program>> programList = new ArrayList<List<Program>>();
             		%>
          			<td align="center"><%=lectureNum%></td>
             	 	<td align="center"><%=lectureDay%></td>
              		<td align="center"><%=lectureDate%></td>
              		
              	<td align="center">
              		<!-- for loop for Topic -->
              		<% for(int n = 0; n < lecTopic.size(); n++){
              			Topic tempTopic = lecTopic.get(n);
              			String topicUrl = tempTopic.getUrl();
              			String topicTitle = tempTopic.getTitle();
              			String topicChapter = tempTopic.getChapter();
              			List<Program> topicPro = tempTopic.getPrograms();
              			//create a chapterList to store chapters
              			//create a list of programList
              			
              			if(n == lecTopic.size()-1){
              			%>
           				<a href=<%=topicUrl%>><%=topicTitle%></a>
           				
           				<% if(topicChapter!=null) 
           						chapterAdd.add(topicChapter);
           				
           					if(topicPro != null)
           				  		programList.add(topicPro);
           				  %>
                	 <%}else{ %>
                		<a href=<%=topicUrl%>><%=topicTitle%></a><hr />
                		<%
                		if(topicChapter!=null)
       	         			chapterAdd.add(topicChapter);
                		if(topicPro!=null)
                			programList.add(topicPro);
                	   }
              		}
                		%>
                		</td>
                	<td align="center">
                	<%for(int o =0; o< chapterAdd.size(); o++){
                	  String chap = chapterAdd.get(o);
                	  if(o == chapterAdd.size()-1){%>
                		  <%=chap %>
                		  <%
                	  }else{
                	 %>
                	 <%=chap %>, 
                	 <%
                		}
                	}
                	%>
                	</td>
                	
                	<td align="center">
                	<%
                	if(programList != null){
                		for(int r =0; r < programList.size(); r++){
                  			List<Program> pl = programList.get(r);
                  				for(int p = 0; p < pl.size(); p++){
                  					List<File> programFile = pl.get(p).getFiles();
                  					for(int q = 0; q < programFile.size(); q++){
                  						String programUrl = programFile.get(q).getUrl();
                  						String programTitle = programFile.get(q).getTitle();
                  						
                  						%>
										<a href=<%=programUrl%>><%=programTitle%></a><br />                						
                  						<%	
          
                  				}
                  			}
                		}
                  	} %>
                  	</td>
                 </tr>
                <%	
                for(int r = 0; r < assignment.size(); r++){
                	String asDueDate = assignment.get(r).getDueDate();
                	String asNumber = assignment.get(r).getNumber();
                	if(lectureDate.equals(asDueDate)){
                		
                	%>
                		<tr>
                		<td align="center"></td>
                		<td align="center"></td>
                        <td align="center"></td>
                        <td align="center"><%=lectureDay %></td>
                        <td align="center"><%=lectureDate%></td>
                        <td align="center" colspan="3"><font size="+1" color="red"><b>ASSIGNMENT <%=asNumber%> DUE</b></font></td>
                      </tr>

                <%	}
                }
                %>
                <tr> </tr>
                <%
              
              	  }
              	}
              	%>
            
           



</body>
</html>
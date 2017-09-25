<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="objects.*" import="java.util.*" import = "parsing.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<%
	Startparsing sp2 = (Startparsing)session.getAttribute("Startparsing");
	List<School> ls = sp2.getSchools();
	School s = ls.get(0);
	List<Department> ld = s.getDepartments();
	Department d = ld.get(0);
	List<Course> lc = d.getCourses();
	Course c = lc.get(0);
	
	String SchoolImage = s.getImage();
	String prefix = d.getPrefix();
	String Home = prefix + " " + c.getNumber();
	String fulln = c.getTitle();
	String units = c.getUnits() + " units";
	String sy = c.getTerm() + " " + c.getYear();
	Syllabus sbus = c.getSyllabus();
	String syllabus = sbus.getUrl();
	List<Exam> exams = c.getExams();
	%>
	
	<body text="#333333" bgcolor="#EEEEEE" link="#0000EE" vlink="#551A8B" alink="#336633">
    <table cellpadding="10" width="800">
      <tr>
        <!-- column for left side of page -->
        <td width="180" valign="top" align="right">
          <a href="http://www.usc.edu"><img src=<%=SchoolImage%> border="0"/></a><br /><br />
          <font size="+1"><a href="http://cs.usc.edu"><%= prefix%> Department</a></font><br /><br />
          <font size="+1"><a href="website.jsp"><%= Home%> Home</a></font><br /><br />
          <font size="+1"><a href=<%=syllabus%>>Syllabus</a></font><br /><br />
          <font size="+1"><a href="lectures.jsp">Lectures</a></font><br /><br />
          <font size="+1"><a href="assignments.jsp">Assignments</a></font><br /><br />
          <font size="+1">Previous Exams</font><br /><br />
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
          
          
          <table border="2" cellpadding="5" width="590">
            <tr>
              <th align="center">Semester</th><th align="center">Written Exam #1</th><th align="center">Programming Exam #1</th><th>Written Exam #2</th><th>Programming Exam #2</th>
            </tr>
            <% for(int i = 0; i < exams.size(); i++){
            		Exam ex = exams.get(i);
            		String esy = ex.getSemester() + " " + ex.getYear();
            		List<Test> eTests = ex.getTests();
            	%>
            <tr>
              <td align="center"><%=esy %></td>
              
              	<% for(int j = 0; j < eTests.size(); j++){ 
              		Test test = eTests.get(j);
					String tTitle = test.getTitle();
					List<File> tfiles = test.getFiles();
					File testFile1 = null;
					%>
					<td align="center">
					<%
					if(tTitle.equals("Written Exam #1")){
						for(int k = 0; k < tfiles.size(); k++){
							testFile1 = tfiles.get(k);
							String fTitle = testFile1.getTitle();
							String fUrl = testFile1.getUrl();
							if(k == tfiles.size()-1){
								%>
								 <a href=<%=fUrl%>><%=fTitle%></a>
								<%
							}else{
								%>
								<a href=<%=fUrl%>><%=fTitle%></a><hr />
								<%
							}
						}
					}
					
					if(tTitle.equals("Programming Exam #1")){
						for(int k = 0; k < tfiles.size(); k++){
							testFile1 = tfiles.get(k);
							String fTitle = testFile1.getTitle();
							String fUrl = testFile1.getUrl();
							if(k == tfiles.size()-1){
								%>
								 <a href=<%=fUrl%>><%=fTitle%></a>
								<%
							}else{
								%>
								<a href=<%=fUrl%>><%=fTitle%></a><hr />
								<%
							}
						}
					}
					
					if(tTitle.equals("Written Exam #2")){
						for(int k = 0; k < tfiles.size(); k++){
							testFile1 = tfiles.get(k);
							String fTitle = testFile1.getTitle();
							String fUrl = testFile1.getUrl();
							if(k == tfiles.size()-1){
								%>
								 <a href=<%=fUrl%>><%=fTitle%></a>
								<%
							}else{
								%>
								<a href=<%=fUrl%>><%=fTitle%></a><hr />
								<%
							}
						}
					}
					if(tTitle.equals("Programming Exam #2")){
						for(int k = 0; k < tfiles.size(); k++){
							testFile1 = tfiles.get(k);
							String fTitle = testFile1.getTitle();
							String fUrl = testFile1.getUrl();
							if(k == tfiles.size()-1){
								%>
								 <a href=<%=fUrl%>><%=fTitle%></a>
								<%
							}else{
								%>
								<a href=<%=fUrl%>><%=fTitle%></a><hr />
								<%
							}
						}
					}
            	  %>
            	  </td>
            	  <% }
            	  %> 
            </tr>
            <%} %>
          

</body>
</html>
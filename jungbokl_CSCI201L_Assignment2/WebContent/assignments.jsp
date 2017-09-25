<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="objects.*" import="java.util.*" import="parsing.*" %>
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
	
	
	List<Assignment> assignment = c.getAssignments();
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
          <font size="+1">Assignments</font><br /><br />
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
          
          
          
          <b>Assignments</b>
          <table border="2" cellpadding="5" width="590">
            <tr>
              <th align="center">Homework #</th><th align="center">Assigned</th><th align="center" width="40">Due</th><th>Assignment</th><th>% Grade</th><th>Grading Criteria</th><th>Solution</th>
            </tr>
            <%
            for(int i = 0 ; i < assignment.size(); i++){
            	Assignment ass= assignment.get(i);
            	String aNumber = ass.getNumber();
            	String assignedDate = ass.getAssignedDate();
            	String dueDate = ass.getDueDate();
            	String assTitle = ass.getTitle();
            	String assUrl = ass.getUrl();
            	
            	List<File> assFiles = ass.getFiles();
            	List<File> assGCFiles = ass.getGradingCriteriaFiles();
            	List<File> assSoFiles = ass.getSolutionFiles();
            	String assGP = ass.getGradePercentage();
            	List<Deliverable> assDeliver = ass.getDeliverables();
            	
            	
            	if(assDeliver == null){ %>
            
            <tr>
              <td align="center"><%=aNumber%></td>
              <td align="center"><%=assignedDate%></td>
              <td align="center"><%=dueDate%></td>
              <td align="center">
              <%if(assFiles != null){ 
              	if(assTitle!=null){%>
        	
                <a href=<%=assUrl%>><%=assTitle%></a><hr />
                
                <%
              	}
              	else{
              	%>
              	  </a>
              	  <%
              	}
                for(int j = 0; j < assFiles.size(); j++){
                	File aFiles = assFiles.get(j);
               		String aUrl = aFiles.getUrl();
               		String aTitle = aFiles.getTitle();
               		if(j == assFiles.size()-1){
                %>
                <a href=<%=aUrl%>><%=aTitle%></a>
                <%	}else{ %>
                <a href=<%=aUrl%>><%=aTitle%></a><hr />
                <%	}
               	}
              }else{ %>
              <%if(assTitle!= null){ %>
              	<a href=<%=assUrl%>><%=assTitle%></a>
              	<%}
              else{%>
              <a> </a>
                <%}
              }%>
              	
              </td>
              <td align="center"><%=assGP%></td>
              <td align="center">
              <%
              if(assGCFiles != null){
              for(int k = 0; k <assGCFiles.size(); k++){ 
              		File gcFile = assGCFiles.get(k);
              		String gcUrl = gcFile.getUrl();
              		String gcTitle = gcFile.getTitle();
              		%>
                <a href=<%=gcUrl%>><%=gcTitle%></a><br />
              <%}
              }%>
              </td>
              <td align="center">
              <%
              if(assSoFiles != null){
             	 for(int l = 0; l <assSoFiles.size(); l++){ 
            		File soFile = assSoFiles.get(l);
            		String soUrl = soFile.getUrl();
            		String soTitle = soFile.getTitle(); %>
              <a href=<%=soUrl%>><%=soTitle%></a><br />
              <%	}
             	 }
             %>
             
              </td>
            </tr>
            <%}else{
            	%>
            	<tr>
              <td align="center"><%=aNumber%></td>
              <td align="center"><%=assignedDate%></td>
              <td align="center" colspan="3">
                <table border="1" cellpadding="5">
                <tr>
                    <td colspan="3" align="center">
                    
                    <%if(assFiles != null){ 
              			if(assTitle!=null){%>
                		<a href=<%=assUrl%>><%=assTitle%></a><hr />
                
               			 <%}else{
              				%>
              	  			</a>
              	  		<%
              		}
                		for(int j = 0; j < assFiles.size(); j++){
                			File aFiles = assFiles.get(j);
               				String aUrl = aFiles.getUrl();
               				String aTitle = aFiles.getTitle();
               				if(j == assFiles.size()-1){
                		%>
                			<a href=<%=aUrl%>><%=aTitle%></a>
                		<%	}else{ %>
                			<a href=<%=aUrl%>><%=aTitle%></a><hr />
                		<%	}
               			}
              		}else{ %>
             	 		<%if(assTitle!= null){ %>
              			<a href=<%=assUrl%>><%=assTitle%></a>
              			<%}
              			else{%>
              			<a> </a>
                		<%}
              		}%>
                    
                    </td>
                  </tr>
                  
            	<%   
             		for(int m = 0; m < assDeliver.size(); m++){
            	    	Deliverable del = assDeliver.get(m);
            			String delDueDate = del.getDueDate();
            			String delTitle = del.getTitle();
            			String delPercentage =del.getGradePercentage();
            			List<File> delFiles = del.getFiles();
    
            	%>             		
                  <tr>
                    <td><%=delDueDate%></td>
                    <td>
                    <%if(delFiles != null){
                    	 %>
                    	 <%=delTitle%><hr /> 
                    <%for(int n = 0; n < delFiles.size(); n++){
                    		File dFile= delFiles.get(n);
                    		String dFileUrl = dFile.getUrl();
                    		String dFileTitle = dFile.getTitle();
                    		if(n == delFiles.size()-1){
                    		%>
                    		<a href=<%=dFileUrl%>><%=dFileTitle%></a>
                    		<%}else{ %>
          					<a href=<%=dFileUrl%>><%=dFileTitle%></a><hr />
          					<%}
                    	}%>
                    	</td>
                    <%}else{ %>	
                    <%=delTitle%></td>
                    <%} %>
                    	
                    	<td><%=delPercentage%></td>
                  </tr>
                  <%}
              }
          
            }
            %>
                 
    </table>
          


</body>
</html>
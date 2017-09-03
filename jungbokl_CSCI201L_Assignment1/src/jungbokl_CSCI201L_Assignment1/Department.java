package jungbokl_CSCI201L_Assignment1;

import java.util.List;

public class Department {
	
	private String longName;
	private String prefix;
	private List<Courses> courses;
	
	
	public Department(String longName, String prefix, List<Courses> courses) {
		setlName(longName);
		setPrefix(prefix);
		setCourses(courses);
	}
	
	public void setlName(String longName) {
		this.longName = longName;
	}

	public void setPrefix(String prefix) {
		this.prefix = prefix;
	}
	
	public void setCourses(List<Courses> courses) {
		this.courses = courses;
	}
	
	public String getlongName() {
		return longName;
	}
	
	public String getPrefix() {
		return prefix;
	}
	
	public List<Courses> getCourses(){
		return courses;
	}
}
	
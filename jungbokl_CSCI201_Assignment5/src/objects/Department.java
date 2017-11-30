package objects;

import java.util.ArrayList;
import java.util.List;

public class Department {
	private String longName;
	private String prefix;
	private List<Course> courses;

	public Department() {
		courses = new ArrayList<>();
	}

	public String getLongName() {
		return longName;
	}
	
	public void setLongName(String longName) {
		this.longName = longName;
	}

	public String getPrefix() {
		return prefix;
	}
	
	public void setPrefix(String prefix) {
		this.prefix = prefix;
	}

	public List<Course> getCourses() {
		return courses;
	}
	
	public void setCourses(List<Course> courses) {
		this.courses = courses;
	}
}

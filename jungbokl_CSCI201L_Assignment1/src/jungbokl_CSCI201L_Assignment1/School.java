package jungbokl_CSCI201L_Assignment1;

import java.util.List;

public class School {
	private String name;
	private List<Department> departments;
	
	public School(String name, List<Department> departments) {
		setName(name);
		setDepartments(departments);
	}
	
	public String getName() {
		return name;
	}
	
	public void setName(String name) {
		this.name = name;
	} 
	
	public void setDepartments(List<Department> departments) {
		this.departments = departments;
	}
	
	public List<Department> getDepartments(){
		return departments;
	}

}

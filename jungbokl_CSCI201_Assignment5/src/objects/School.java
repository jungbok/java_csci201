package objects;

import java.util.ArrayList;
import java.util.List;

public class School {
	private String name;
	private String image;
	private List<Department> departments;

	public School() {
		departments = new ArrayList<>();
	}
	
	public void setName(String n) {
		name = n;
	}
	
	public void setImage(String img) {
		image = img;
	}

	public String getImage() {
		return image;
	}
	
	public String getName() {
		return name;
	}
	
	public void setDepartments(List<Department> departments) {
		this.departments = departments;
	}

	public List<Department> getDepartments() {
		return departments;
	}
}

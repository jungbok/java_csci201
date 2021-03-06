package objects;

import java.util.List;

public class StaffMember {

	private String type;
	private int id;
	private Name name;
	private String email;
	private String image;
	private String phone;
	private String office;
	private List<OfficeHour> officeHours = null;

	public String getJobType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Name getName() {
		return name;
	}

	public void setName(Name name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getOffice() {
		return office;
	}

	public void setOffice(String office) {
		this.office = office;
	}

	public List<OfficeHour> getOfficeHours() {
		return officeHours;
	}

	public void setOfficeHours(List<OfficeHour> officeHours) {
		this.officeHours = officeHours;
	}


}

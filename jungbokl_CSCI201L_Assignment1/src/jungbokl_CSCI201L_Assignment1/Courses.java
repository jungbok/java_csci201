package jungbokl_CSCI201L_Assignment1;

import java.util.List;

public class Courses {
	private int number;
	private String term;
	private int year;
	private List<StaffMember> staffMembers;
	private List<Meeting> meetings;
	
	
	public Courses(int number, String term, int year, List<StaffMember> staffMembers, List<Meeting> meetings) {
		setNumber(number);
		setTerm(term);
		setYear(year);
		setStaffMember(staffMembers);
		setMeetings(meetings);
	}
	
	public void setNumber(int number) {
		this.number= number;
	}
	
	public void setTerm(String term) {
		this.term = term;
	
	}
	
	public void setYear(int year) {
		this.year = year;
	}
	
	public void setStaffMember(List<StaffMember> staffMembers) {
		this.staffMembers = staffMembers;
	}
	
	public int getNumber() {
		return number;
		
	}

	public String getTerm() {
		return term;
		
	}
	
	public int getYear() {
		return year;
	}
	
	public List<StaffMember> getStaffMember(){
		return staffMembers;
	}
	
	public List<Meeting> getMeetings() {
		return meetings;
	}

	public void setMeetings(List<Meeting> meetings) {
		this.meetings = meetings;
	}
	
}

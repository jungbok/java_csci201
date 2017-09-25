package objects;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

public class Course {
	
	private String number;
	private String title;
	private String units;
	private String term;
	private String year;
	private List<StaffMember> staffMembers = null;	
	private List<Meeting> meetings = null;
	private Syllabus syllabus;
	private Schedule schedule;
	private List<Assignment> assignments = null;
	private List<Exam> exams = null;
	
	//meetings sorted into a map, key is the meeting type, value is a list of all meetings of that type
	private Map<String, List<Meeting>> sortedMeetings;
	//staff sorted into a map, key is the staff type, value is a list of all staff members of that type
	private Map<String, List<StaffMember>> sortedStaff;
	//map from staff member ID to staff member object
	private Map<Integer, StaffMember> staffMap;


	public String getNumber() {
		return number;
	}

	public void setNumber(String number) {
		this.number = number;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getUnits() {
		return units;
	}

	public void setUnits(String units) {
		this.units = units;
	}

	public String getTerm() {
		return term;
	}

	public void setTerm(String term) {
		this.term = term;
	}

	public String getYear() {
		return year;
	}

	public void setYear(String year) {
		this.year = year;
	}

	public List<StaffMember> getStaffMembers() {
		return staffMembers;
	}

	public void setStaffMembers(List<StaffMember> staffMembers) {
		this.staffMembers = staffMembers;
	}

	public List<Meeting> getMeetings() {
		return meetings;
	}

	public void setMeetings(List<Meeting> meetings) {
		this.meetings = meetings;
	}

	public Syllabus getSyllabus() {
		return syllabus;
	}

	public void setSyllabus(Syllabus syllabus) {
		this.syllabus = syllabus;
	}

	public Schedule getSchedule() {
		return schedule;
	}

	public void setSchedule(Schedule schedule) {
		this.schedule = schedule;
	}

	public List<Assignment> getAssignments() {
		return assignments;
	}

	public void setAssignments(List<Assignment> assignments) {
		this.assignments = assignments;
	}

	public List<Exam> getExams() {
		return exams;
	}

	public void setExams(List<Exam> exams) {
		this.exams = exams;
	}

	
	public Map<String, List<Meeting>> getSortedMeetings(){
		if (sortedMeetings == null){
			//group the meetings by their type (by the method getMeetingType)
			sortedMeetings = meetings.stream().collect(Collectors.groupingBy(Meeting::getMeetingType));
		}
		return sortedMeetings;
	}
	
	public Map<String, List<StaffMember>> getSortedStaff(){
		if (sortedStaff == null){
			//group the staffMembers by their type (by the method getJobType)
			sortedStaff = staffMembers.stream().collect(Collectors.groupingBy(StaffMember::getJobType));
		}
		return sortedStaff;
	}
	
	public Map<Integer, StaffMember> getMappedStaff(){
		if (staffMap == null){
			staffMap = new HashMap<>();
			//create a map from the ID number to the StaffMember object
			staffMembers.stream().forEach(staff->{
				staffMap.put(staff.getId(), staff);
			});
		}
		return staffMap;
	}
}



package objects;

import java.util.List;
import java.util.Map;

public class Schedule {
	private List<Textbook> textbooks;
	private List<Week> weeks;

	public List<Textbook> getTextbooks() {
		return textbooks;
	}
	
	public void setTextbooks(List<Textbook> textbooks) {
		this.textbooks = textbooks;
	}

	public List<Week> getWeeks() {
		return weeks;
	}
	
	public void setWeeks(List<Week> weeks) {
		this.weeks = weeks;
	}
	
	/*
	 * Organize each week of the schedule
	 */
	public void organize(Map<String, List<GeneralAssignment>> mappedAssignments) {
		weeks.stream().forEach(week -> week.organize(mappedAssignments));
	}
}

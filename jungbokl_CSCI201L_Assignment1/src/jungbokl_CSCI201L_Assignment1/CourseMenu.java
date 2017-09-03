package jungbokl_CSCI201L_Assignment1;

import java.util.InputMismatchException;
import java.util.List;
import java.util.Scanner;

public class CourseMenu {
	
	//private List<Courses> c = null;
	private String pf;
	private int userInput = 0;
	
	public CourseMenu(List<Courses> c, String pf, boolean exit, Scanner in) {
		//this.c = c;
		this.pf = pf;
		
	}
	
	public boolean CoursesDisplay (List<Courses> c, boolean exit, Scanner in) {
		
		while(!exit) {
			if(c.size() != 0) {
		
				System.out.println(pf + " Courses");
		
				for(int i = 0; i < c.size(); i++) {
					Courses co = c.get(i);
					System.out.println("  " + (i +1) + ") " + pf + " " + co.getNumber() + " " + co.getTerm() + " " + co.getYear());
				}
		
				System.out.println("  " + (c.size() +1) + ") Go to Departments menu");
				System.out.println("  " + (c.size() +2) + ") Exit");
				
				System.out.print("What would you like to do? ");
				
				try {
					userInput = in.nextInt();
					
					if(userInput > 0 && userInput <= c.size()) {
						Courses cc = c.get(userInput -1);
						
						//System.out.println(cc.getNumber());
						List<StaffMember> check = cc.getStaffMember();
						System.out.println(check.size());
						CourseTermMenu tm = new CourseTermMenu(cc.getStaffMember(), cc.getMeetings(), pf, cc.getNumber(), cc.getTerm(), cc.getYear(), exit, in);
						tm.displayCourseTermMenu(cc.getStaffMember(), cc.getMeetings(), exit, in);
					}
					else if(userInput == c.size() +1) {
						break; 
					}
					
					else if(userInput == c.size() + 2) {
						exit = true;
						System.out.println("Thanks for using my program!");
						System.exit(1);
						break;
					}
					else {
						System.out.println("That is not a valid option");
					}
						
				}catch(InputMismatchException ime) {
					System.out.println("Please put your input as a number");
				}
			}
		}
		
		return true;
	}
}
		


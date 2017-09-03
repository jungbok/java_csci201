package jungbokl_CSCI201L_Assignment1;

import java.util.InputMismatchException;
import java.util.List;
import java.util.Scanner;

public class CourseTermMenu {
	
	private int userInput = 0;
	private String pf;
	private int cn;
	private String tm;
	private int yr;
	
	public CourseTermMenu(List<StaffMember> st, List<Meeting> me, String pf, int cn, String tm, int yr, boolean exit, Scanner in) {
		this.pf = pf;
		this.cn = cn;
		this.tm = tm;
		this.yr = yr;
		
	}
		
		
	public boolean displayCourseTermMenu(List<StaffMember> st, List<Meeting> me, boolean exit, Scanner in) {
		
		while(!exit) {
			
			System.out.println(pf + " " + cn + " " + " " + tm + " " + yr);
			
			System.out.println("   1) View course staff" );
			System.out.println("   2) View Meeting information");
			System.out.println("   3) Go to " + pf + " menu");
			System.out.println("   4) Exit");
			
			System.out.print("What would you like to do? ");
			
			try {
				userInput = in.nextInt();
				
				//view course staff
				if(userInput == 1) {
					
					//System.out.println("staff size: " + st.size());
					CourseStaffMenu csm = new CourseStaffMenu(pf,cn,tm,yr,st, exit, in);
					csm.displayCourseStaffMenu(exit,in);
					
					
				}
				
				//view meeting info
				else if(userInput == 2) {
					
					MeetingInfoMenu mim = new MeetingInfoMenu(pf, cn, tm, yr, me, exit, in);
					mim.displayMeetingInfoMenu(exit, in, st);
				}
				
				else if(userInput == 3) {
					break;
				}
				else if(userInput == 4) {
					exit = true;
					System.out.println("Thanks for using my program!");
					System.exit(1);
					break;
				}
				else{
					System.out.println("That is not a valid option");
				}
					
			}catch(InputMismatchException ime) {
				System.out.println("Please put your input as a number");
			}
		}
		return true;

	}
}

package jungbokl_CSCI201L_Assignment1;

import java.util.InputMismatchException;
import java.util.List;
import java.util.Scanner;

public class DepartmentMenu {
	
	//private List<Department> d = null;
	private int userInput = 0;
	
	public DepartmentMenu(List<Department> d, boolean exit, Scanner in) {
		//this.d = d;
		
	}
	
	public boolean DepartmentDisplay (List<Department> d, boolean exit, Scanner in) {

		while(!exit) {
			
			if(d.size() > 0) {
				System.out.println("Departments ");
		
				for(int i = 0; i < d.size(); i++) {
					Department b = d.get(i);
					System.out.println("  " + (i +1) + ") " + b.getlongName() + " (" + b.getPrefix() + ") ");
				}
		
				System.out.println("  " + (d.size() +1) + ") Go to Schools menu");
				System.out.println("  " + (d.size() +2) + ") Exit");
		
				System.out.print("What would you like to do? ");
				
				try {
					userInput = in.nextInt();
					
					if(userInput > 0 && userInput <= d.size()) {
						Department de = d.get(userInput -1);
						CourseMenu cm = new CourseMenu(de.getCourses(), de.getPrefix(), exit, in);
						cm.CoursesDisplay(de.getCourses(), exit, in);
					}
					
					else if(userInput == d.size()+1) {
						break;
					}
					else if(userInput == d.size() + 2) {
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

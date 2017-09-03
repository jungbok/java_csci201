package jungbokl_CSCI201L_Assignment1;

import java.util.InputMismatchException;
import java.util.List;
import java.util.Scanner;

public class SchoolMenu {
	
	private List<School> sc = null;
	private int userInput = 0;
	
	public SchoolMenu(List<School> sc, boolean exit, Scanner in) {
		this.sc = sc;
	}
	
	public boolean displaySchool(List<School> sc, boolean exit, Scanner in) {
		
		
		while(!exit) {
		if(sc.size() != 0) {
			
			System.out.println("Schools");
		
			for(int i = 0; i < sc.size(); i++) {
				School a = sc.get(i);
				System.out.println("  " + (i+1) + ") " + a.getName());	
			}
		
			System.out.println("  " + (sc.size() +1) + ") Go to Main menu");
			System.out.println("  " + (sc.size()+2) + ") Exit" );
		
			System.out.print("What would you like to do? ");
		
			try{
				userInput = in.nextInt();
		
				if(userInput > 0 && userInput <= sc.size()) {
					School s = sc.get(userInput -1);
					DepartmentMenu dm = new DepartmentMenu(s.getDepartments(), exit, in);
					dm.DepartmentDisplay(s.getDepartments(), exit, in);
			
				}
				else if(userInput == sc.size()+1) {
			
					break;
				}
		
				else if(userInput == sc.size()+2) {
					exit = true;
					System.out.println("Thanks for using my program!");
					
					System.exit(1);
					break;
				}
	
				else {
					System.out.println("That is not a valid option. ");
					//displaySchool(sc, exit, in);	
				}
			}catch(InputMismatchException ime) {
				System.out.println("Pleas put your input as a number");
			
			}
		
			}
		}
		
		return true;		
		
	}
	
	
}

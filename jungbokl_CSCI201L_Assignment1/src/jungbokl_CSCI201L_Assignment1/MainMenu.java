package jungbokl_CSCI201L_Assignment1;

import java.util.InputMismatchException;
import java.util.List;
import java.util.Scanner;

public class MainMenu {
	
	private int userInput;
	
	public MainMenu(boolean exit) {
		userInput = 0;
	}
	
	public boolean DisplayMain(boolean exit, List<School> s) {
		
		while(!exit) {
		
			System.out.println("1) Displays School");
			System.out.println("2) Exit ");
			System.out.print("What would you like to do? ");
			Scanner in = new Scanner(System.in);
		
			try {
				userInput = in.nextInt();
		
				if(userInput == 1) {
					SchoolMenu sm = new SchoolMenu(s, exit, in);
					sm.displaySchool(s, exit, in);
				}
		
				else if(userInput == 2) {
					exit = true;
					System.out.println("Thanks for using my program! ");
				}
				else {
					System.out.println("That is not a valid option. ");		
				}
				
			}catch(InputMismatchException ime) {
				System.out.println("Pleas put your input as a number");
			
			}
		}
		
		return true;
	}

}

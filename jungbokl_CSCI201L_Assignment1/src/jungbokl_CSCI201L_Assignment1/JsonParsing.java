package jungbokl_CSCI201L_Assignment1;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.Scanner;

import com.google.gson.Gson;
import com.google.gson.JsonIOException;
import com.google.gson.JsonSyntaxException;

public class JsonParsing {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		boolean exit = false;
		Scanner scan = new Scanner(System.in);
		while(!exit) {
		
			System.out.print("What is the name of the input file? ");
			String InFileName = scan.nextLine();
			//scan.close();
		
			Gson gson = new Gson();
		
			try {
				//FileReader file = new FileReader(InFileName);
					Parsing p = gson.fromJson(new FileReader(InFileName), Parsing.class);
				
					//List<School> schools = p.getSchools();
					//System.out.print(schools.get(0).getName());
				
					//boolean exit = false;
					boolean end = false;
				
				// TEST
//					List<School> schools = p.getSchools();
//				List<Department> deps = schools.get(0).getDepartments();
//				List<Courses> courses = deps.get(0).getCourses();
//				List<StaffMember> sm = courses.get(0).getStaffMember();
//				System.out.println("First StaffMember Name: " + sm.get(0).getName().getFname());
//				
			    MainMenu mm = new MainMenu(exit);
				end = mm.DisplayMain(exit, p.getSchools());
								
		}
		catch (JsonSyntaxException jse) {
			System.out.println("That file is not a well-formed JSON file.");
		}
		
		catch (IOException ioe) {
			System.out.println("That file cannot be found. ");
		}
		catch (JsonIOException jioe) {
			System.out.println("That file is invalid to read");
		}
		
//		catch (FileNotFoundException fnf) {	
//			System.out.println("That file could not be found.");
//		}
	}

	}

}

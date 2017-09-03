package jungbokl_CSCI201L_Assignment1;

import java.util.InputMismatchException;
import java.util.List;
import java.util.Scanner;

public class CourseStaffMenu {
	
	private String pf;
	private int cn;
	private String tm;
	private int yr;
	private int userInput = 0;
	private StaffMember sta;
	private List<StaffMember> st = null;
	
	public CourseStaffMenu(String pf, int cn, String tm, int yr, List<StaffMember> st, boolean exit, Scanner in) {
	
		this.pf = pf;
		this.cn = cn;
		this.tm = tm;
		this.yr = yr;
		this.st = st;
	}
	
	public boolean displayCourseStaffMenu(boolean exit, Scanner in) {
		
		while(!exit) {
			System.out.println(pf + " "+ cn + " " + tm + " " + yr);
			System.out.println("Staff Member");
			
			System.out.println("   1) View Instructors" );
			System.out.println("   2) View TAs");
			System.out.println("   3) View CPs");
			System.out.println("   4) View Graders");
			System.out.println("   5) Go to " + pf + " " + cn + " " + tm + " " + yr + " " + "menu");
			System.out.println("   6) Exit");
			
			//System.out.println(st.size());
			
			System.out.print("What would you like to do? ");
			
			
			
			try {
				userInput = in.nextInt();
				//Staff sta = null;
				
				//System.out.println(st.size());
				
				
				if(userInput == 1) {
					//System.out.println(st.size());
					//sta = st.get(0);
					//System.out.println(sta.getName().getFname());
					for(int n = 0; n < st.size(); n++) {
						if((st.get(n).getType()).equals("instructor")) {
							sta = st.get(n);
//						System.out.println("Name: " + sta.getName().getFname());
	
		

//					System.out.println("Name: " + sta.getName().getFname());
					
							System.out.println(pf + " "+ cn + " " + tm + " " + yr);
							System.out.println("Instructor");
							if(sta.getName() != null)
								System.out.println("Name: " + sta.getName().getFname() + " " + sta.getName().getLname());
							else
								System.out.println("Name: None");
							if(sta.getEmail() != null)
								System.out.println("Email: " + sta.getEmail());
							else
								System.out.println("Email: None");
							if(sta.getImage() != null) 
								System.out.println("Image: " + sta.getImage());
							else
								System.out.println("Image: None");
							if(sta.getPhone() != null)
								System.out.println("Phone: " + sta.getPhone());
							else
								System.out.println("Phone: None");
							if(sta.getOffice() != null)	
								System.out.println("Office: " + sta.getOffice());
							else
								System.out.println("Office: None");
						if(sta.getOfficeHours()!= null) {
								System.out.print("Office Hours: ");
						//list OH
						//get all the Office hour times
								for(int k = 0; k < sta.getOfficeHours().size(); k++) {
									OfficeHour ohs = sta.getOfficeHours().get(k);
									if(ohs.getDay() != null) {
										System.out.print(ohs.getDay() + " ");
										
										if(ohs.getTime() != null) {
											Time oht = ohs.getTime();
									
											System.out.print(oht.getStart() + " - " + oht.getEnd());
												if(k+1 < sta.getOfficeHours().size()) {
													System.out.print(", ");
												}
										}
									}
								}
								System.out.println(" ");
						}
						
						else {
							System.out.print("Office Hours: None");
						}
				
					}
				}
			}
					
					
				else if(userInput == 2) {
					for(int n = 0; n < st.size(); n++) {
						if((st.get(n).getType()).equals("ta")) {
							sta = st.get(n);
//						
					
							System.out.println(pf + " "+ cn + " " + tm + " " + yr);
							System.out.println("TA");
							if(sta.getName() != null)
								System.out.println("Name: " + sta.getName().getFname() + " " + sta.getName().getLname());
							else
								System.out.println("Name: None");
							if(sta.getEmail() != null)
								System.out.println("Email: " + sta.getEmail());
							else
								System.out.println("Email: None");
							if(sta.getImage() != null) 
								System.out.println("Image: " + sta.getImage());
							else
								System.out.println("Image: None");
							if(sta.getPhone() != null)
								System.out.println("Phone: " + sta.getPhone());
							else
								System.out.println("Phone: None");
							if(sta.getOffice() != null)	
								System.out.println("Office: " + sta.getOffice());
							else
								System.out.println("Office: None");
						if(sta.getOfficeHours()!= null) {
								System.out.print("Office Hours: ");
						//list OH
						//get all the Office hour times
								for(int k = 0; k < sta.getOfficeHours().size(); k++) {
									OfficeHour ohs = sta.getOfficeHours().get(k);
									if(ohs.getDay() != null) {
										System.out.print(ohs.getDay() + " ");
										
										if(ohs.getTime() != null) {
											Time oht = ohs.getTime();
									
											System.out.print(oht.getStart() + " - " + oht.getEnd());
												if(k+1 < sta.getOfficeHours().size()) {
													System.out.print(", ");
												}
										}
									}
								}
								System.out.println(" ");
						}
						
						else {
							System.out.print("Office Hours: None");
						}
				
					}
				}
			}
				else if(userInput == 3) {
					for(int n = 0; n < st.size(); n++) {
						if((st.get(n).getType()).equals("cp")) {
							sta = st.get(n);
//						System.out.println("Name: " + sta.getName().getFname());
	
		

//					System.out.println("Name: " + sta.getName().getFname());
					
							System.out.println(pf + " "+ cn + " " + tm + " " + yr);
							System.out.println("CP");
							if(sta.getName() != null)
								System.out.println("Name: " + sta.getName().getFname() + " " + sta.getName().getLname());
							else
								System.out.println("Name: None");
							if(sta.getEmail() != null)
								System.out.println("Email: " + sta.getEmail());
							else
								System.out.println("Email: None");
							if(sta.getImage() != null) 
								System.out.println("Image: " + sta.getImage());
							else
								System.out.println("Image: None");
							if(sta.getPhone() != null)
								System.out.println("Phone: " + sta.getPhone());
							else
								System.out.println("Phone: None");
							if(sta.getOffice() != null)	
								System.out.println("Office: " + sta.getOffice());
							else
								System.out.println("Office: None");
						if(sta.getOfficeHours()!= null) {
								System.out.print("Office Hours: ");
						//list OH
						//get all the Office hour times
								for(int k = 0; k < sta.getOfficeHours().size(); k++) {
									OfficeHour ohs = sta.getOfficeHours().get(k);
									if(ohs.getDay() != null) {
										System.out.print(ohs.getDay() + " ");
										
										if(ohs.getTime() != null) {
											Time oht = ohs.getTime();
									
											System.out.print(oht.getStart() + " - " + oht.getEnd());
												if(k+1 < sta.getOfficeHours().size()) {
													System.out.print(", ");
												}
										}
									}
								}
								System.out.println(" ");
						}
						
						else {
							System.out.print("Office Hours: None");
						}
				
					}
				}
			}					

				else if(userInput == 4 ) {
					for(int n = 0; n < st.size(); n++) {
						if((st.get(n).getType()).equals("grader")) {
							sta = st.get(n);
//						System.out.println("Name: " + sta.getName().getFname());
	
		

//					System.out.println("Name: " + sta.getName().getFname());
					
							System.out.println(pf + " "+ cn + " " + tm + " " + yr);
							System.out.println("grader");
							if(sta.getName() != null)
								System.out.println("Name: " + sta.getName().getFname() + " " + sta.getName().getLname());
							else
								System.out.println("Name: None");
							if(sta.getEmail() != null)
								System.out.println("Email: " + sta.getEmail());
							else
								System.out.println("Email: None");
							if(sta.getImage() != null) 
								System.out.println("Image: " + sta.getImage());
							else
								System.out.println("Image: None");
							if(sta.getPhone() != null)
								System.out.println("Phone: " + sta.getPhone());
							else
								System.out.println("Phone: None");
							if(sta.getOffice() != null)	
								System.out.println("Office: " + sta.getOffice());
							else
								System.out.println("Office: None");
						if(sta.getOfficeHours()!= null) {
								System.out.print("Office Hours: ");
						//list OH
						//get all the Office hour times
								for(int k = 0; k < sta.getOfficeHours().size(); k++) {
									OfficeHour ohs = sta.getOfficeHours().get(k);
									if(ohs.getDay() != null) {
										System.out.print(ohs.getDay() + " ");
										
										if(ohs.getTime() != null) {
											Time oht = ohs.getTime();
									
											System.out.print(oht.getStart() + " - " + oht.getEnd());
												if(k+1 < sta.getOfficeHours().size()) {
													System.out.print(", ");
												}
										}
									}
								}
								System.out.println(" ");
						}
						
						else {
							System.out.print("Office Hours: None");
						}
				
					}
				}
			}
			else if(userInput == 5) {
				break;
			}
				
			else if(userInput == 6) {
				exit = true;
				System.out.println("Thanks for using my program!");
				System.exit(1);
				break;
			}
			else {
				System.out.println("That is not a valid option");
			}
		}
				
		catch(InputMismatchException ime) {
			System.out.println("Please put your input as a number");
		}
		catch(NullPointerException npe) {
			npe.printStackTrace();
		}
	}
	return true;
	}

}

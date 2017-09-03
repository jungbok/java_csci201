package jungbokl_CSCI201L_Assignment1;

import java.util.InputMismatchException;
import java.util.List;
import java.util.Scanner;

public class MeetingInfoMenu {
	
	private String pf;
	private int cn;
	private String tm;
	private int yr;
	private int userInput = 0;
	private Meeting mti;
	private List<Meeting> mt = null;
	
	public MeetingInfoMenu(String pf, int cn, String tm, int yr, List<Meeting> mt, boolean exit, Scanner in) {
	
		this.pf = pf;
		this.cn = cn;
		this.tm = tm;
		this.yr = yr;
		this.mt = mt;
	}
	
	public boolean displayMeetingInfoMenu(boolean exit, Scanner in, List<StaffMember> ls) {
		
		while(!exit) {
			System.out.println(pf + " "+ cn + " " + tm + " " + yr);
			System.out.println("Meeting Information");
			
			System.out.println("   1) Lecture" );
			System.out.println("   2) Lab");
			System.out.println("   3) Quiz");
			System.out.println("   4) Go to " + pf + " " + cn + " " + tm + " " + yr + " " + "menu");
			System.out.println("   5) Exit");
			
			//System.out.println(st.size());
			
			System.out.print("What would you like to do? ");
			
			
			
			try {
				userInput = in.nextInt();
				
				
				if(userInput == 1) {
					
					for(int n = 0; n < mt.size(); n++) {
						if((mt.get(n).getType()).equals("lecture")) {
							mti = mt.get(n);
//						System.out.println("Name: " + sta.getName().getFname());
	
		

//					System.out.println("Name: " + sta.getName().getFname());
					
							System.out.println(pf + " "+ cn + " " + tm + " " + yr);
							System.out.println("Lecture Meeting information");
							if(mti.getSection() != null)
								System.out.println("Section: " + mti.getSection());
							else
								System.out.println("Section: None");
							if(mti.getRoom() != null)
								System.out.println("Room: " + mti.getRoom());
							else
								System.out.println("Room: None");
							
							if(mti.getMeetingPeriods()!= null) {
								System.out.print("Meetings: ");
						//list meeting periods
								for(int k = 0; k < mti.getMeetingPeriods().size(); k++) {
									MeetingPeriod mp = mti.getMeetingPeriods().get(k);
										if(mp.getDay() != null) {
											System.out.print(mp.getDay() + " ");
										
											if(mp.getTime() != null) {
												Time_ mpt = mp.getTime();
									
												System.out.print(mpt.getStart() + " - " + mpt.getEnd());
												if(k+1 < mti.getMeetingPeriods().size()) {
													System.out.print(", ");
												}
										}
									}
								}
								System.out.println(" ");
							}
							else{
								System.out.print("Meetings:  ");
							}
							System.out.print("Assitants: ");
							if(mti.getAssistants() != null) {
								
								for(int m = 0; m < mti.getAssistants().size(); m++) {
									Assistant as = mti.getAssistants().get(m);
									
									String stid = as.getStaffMemberID();
									
									for(int l = 0; l < ls.size(); l++) {
										StaffMember temp = ls.get(l);
										if(stid.equals(temp.getId())) {
											System.out.print(temp.getName().getFname() + " " + temp.getName().getLname());
											if(m+1 < mti.getAssistants().size())
												System.out.print(", ");
											}
									}
								}
							}
							else {		
								System.out.println("None");
							}
							System.out.println(" ");
						}
					}
				}
				else if(userInput == 2) {
					
					for(int n = 0; n < mt.size(); n++) {
						if((mt.get(n).getType()).equals("lab")) {
							mti = mt.get(n);
//						System.out.println("Name: " + sta.getName().getFname());
	
		

//					System.out.println("Name: " + sta.getName().getFname());
					
							System.out.println(pf + " "+ cn + " " + tm + " " + yr);
							System.out.println("Lab Meeting information");
							if(mti.getSection() != null)
								System.out.println("Section: " + mti.getSection());
							else
								System.out.println("Section: None");
							if(mti.getRoom() != null)
								System.out.println("Room: " + mti.getRoom());
							else
								System.out.println("Room: None");
							
							if(mti.getMeetingPeriods()!= null) {
								System.out.print("Meetings: ");
						//list meeting periods
								for(int k = 0; k < mti.getMeetingPeriods().size(); k++) {
									MeetingPeriod mp = mti.getMeetingPeriods().get(k);
										if(mp.getDay() != null) {
											System.out.print(mp.getDay() + " ");
										
											if(mp.getTime() != null) {
												Time_ mpt = mp.getTime();
									
												System.out.print(mpt.getStart() + " - " + mpt.getEnd());
												if(k+1 < mti.getMeetingPeriods().size()) {
													System.out.print(", ");
												}
										}
									}
								}
								System.out.println(" ");
							}
							else{
								System.out.print("Meetings:  ");
							}
							System.out.print("Assitants: ");
							if(mti.getAssistants() != null) {
								
								for(int m = 0; m < mti.getAssistants().size(); m++) {
									Assistant as = mti.getAssistants().get(m);
									
									String stid = as.getStaffMemberID();
									
									for(int l = 0; l < ls.size(); l++) {
										StaffMember temp = ls.get(l);
										if(stid.equals(temp.getId())) {
											System.out.print(temp.getName().getFname() + " " + temp.getName().getLname());
											if(m+1 < mti.getAssistants().size())
												System.out.print(", ");
											}
									}
								}
							}
							else {		
								System.out.println("None");
							}
							System.out.println(" ");
						}
					}
				}
				else if(userInput == 3) {
					
					for(int n = 0; n < mt.size(); n++) {
						if((mt.get(n).getType()).equals("quiz")) {
							mti = mt.get(n);
//						System.out.println("Name: " + sta.getName().getFname());
	
		

//					System.out.println("Name: " + sta.getName().getFname());
					
							System.out.println(pf + " "+ cn + " " + tm + " " + yr);
							System.out.println("Quiz Meeting information");
							if(mti.getSection() != null)
								System.out.println("Section: " + mti.getSection());
							else
								System.out.println("Section: None");
							if(mti.getRoom() != null)
								System.out.println("Room: " + mti.getRoom());
							else
								System.out.println("Room: None");
							
							if(mti.getMeetingPeriods()!= null) {
								System.out.print("Meetings: ");
						//list meeting periods
								for(int k = 0; k < mti.getMeetingPeriods().size(); k++) {
									MeetingPeriod mp = mti.getMeetingPeriods().get(k);
										if(mp.getDay() != null) {
											System.out.print(mp.getDay() + " ");
										
											if(mp.getTime() != null) {
												Time_ mpt = mp.getTime();
									
												System.out.print(mpt.getStart() + " - " + mpt.getEnd());
												if(k+1 < mti.getMeetingPeriods().size()) {
													System.out.print(", ");
												}
										}
									}
								}
								System.out.println(" ");
							}
							else{
								System.out.print("Meetings:  ");
							}
							System.out.print("Assitants: ");
							if(mti.getAssistants() != null) {
								
								for(int m = 0; m < mti.getAssistants().size(); m++) {
									Assistant as = mti.getAssistants().get(m);
									
									String stid = as.getStaffMemberID();
									
									for(int l = 0; l < ls.size(); l++) {
										StaffMember temp = ls.get(l);
										if(stid.equals(temp.getId())) {
											System.out.print(temp.getName().getFname() + " " + temp.getName().getLname());
											if(m+1 < mti.getAssistants().size())
												System.out.print(", ");
											}
									}
								}
							}
							else {		
								System.out.println("None");
							}
							System.out.println(" ");
						}
					}
				}
				//else if()
				else if(userInput == 4) {
					break;
				}
					
				else if(userInput == 5) {
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
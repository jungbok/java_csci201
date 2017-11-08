package jungbokl_CSCI201_Assignment4;

import java.io.BufferedReader;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.Socket;

public class ServerThread extends Thread {
	
	private BufferedReader br;
	private PrintWriter pw;
	private Server bs;
	private Socket s;
	private int betAmount = 0;
	
	//private DataInputStream FromClient;
	//private DataOutputStream ToClient;
	
	public ServerThread(Socket s, Server bs) {
		try {
			br = new BufferedReader(new InputStreamReader(s.getInputStream()));
			pw = new PrintWriter(s.getOutputStream());
			//br = new BufferedReader(new InputStreamReader(s.getInputStream()));
			//pw = new PrintWriter(s.getOutputStream());
			//ToClient = new DataOutputStream(s.getOutputStream());
			//FromClient = new DataInputStream(s.getInputStream());
			
			
			
			this.s = s;
			this.bs = bs;
			this.start();
		} catch (IOException ioe) {
			System.out.println("ioe in ServerThread constructor: " + ioe.getMessage());
		}
	}
	public void sendMessage(String message) {
		pw.println(message);
		pw.flush();
	}
	
	
	//first function needed to start the thread if we created the thread
	public void run() {
		try {
			while(true) {
				
				//receives an option that the player choose
				String option = br.readLine();
				
				//if a player decides to create a game
				if(option.equals("1")) {
					String playerN = br.readLine();
					int playerNum = Integer.parseInt(playerN);
					//check if the game name is unique
					boolean uniqueName = false;
					String gameName = "";
					

					while(!uniqueName) {
						//assume that the game name is unique
						uniqueName = true;
						gameName = br.readLine();
						String unique = "false";
						//check if the game name is unique	
						uniqueName = bs.validateGame(gameName);
						//System.out.println("Check1");
						//ToClient.writeBoolean(uniqueName);
						
						//System.out.println("Check2");
						if(uniqueName) {
							unique = "true";
						}
						//sends the result back to the client
						pw.println(unique);
						pw.flush();
					}
					//Unique game name has validated, game created
					//user picked his/her username
					String creatorName = br.readLine();
					bs.addCreatedGame(gameName, playerNum, creatorName, this);
					//bs.gameRoomTesting();
					
					//while(!gameFilled) {
						//System.out.println("Check1");
						//gameFilled = bs.checkGameFilled(gameName);
					if(playerNum == 3) {
						sendMessage("Waiting for " + (playerNum-1) + " other players to join...");
						}
					else if(playerNum == 2) {
						sendMessage("Waiting for 1 other player to join...");
					}
					else if(playerNum == 1) {
						bs.gameStart(gameName);
					}
					boolean gameEnd = false;
					while(!gameEnd) {
						String bet = null;
							try {
							//System.out.println("check3");
							while(true) {
								bet = br.readLine();
								System.out.println(bet);
								if(bet != null) {
									break;
								}
								
								while(true) {
								
								}
							}
							//System.out.println("check4");
							try {
								betAmount = Integer.parseInt(bet);
								bs.updateBet(betAmount, gameName, creatorName, this);

							}catch(NumberFormatException nfe) {
								System.out.println(nfe.getMessage());
							}
							
						}catch(IOException ioe) {
							System.out.println("Reading bet amount in Server Thread: " + ioe.getMessage());
						}
					//}
						gameEnd = bs.gameEnded(gameName);	
					}
					
				}
				
				if(option.equals("2")) {
					boolean findGame = false;
					boolean validName = false;
					String gameName = null;
					String userName = null;
					while(!findGame){
						gameName = br.readLine();
						if(gameName!= null && !gameName.isEmpty()) {
							findGame = bs.findGame(gameName);
							//return the state back to the client
								if(findGame) {
									pw.println("true");
									pw.flush();
								}
								else {
									pw.println("false");
									pw.flush();
								}

						}
					//bs.joinGame(gameName, userName, st)
					}
					
					while(!validName) {
						userName = br.readLine();
						
						if(userName != null && !userName.isEmpty()) {
							validName = bs.validUName(gameName, userName);
						
							if(validName) {
								pw.println("valid");
								pw.flush();
							}
							else {
								pw.println("invalid");
								pw.flush();
							}
						//pw.flush();
						}
					}
					
					if(findGame && validName) {
						//boolean gameStart = false;
						int PlayerNum = bs.getPlayerNum(gameName);
						int PlayerOrder = bs.getPlayerOrder(gameName);
						pw.println(PlayerNum);
						pw.flush();
						
						pw.println(PlayerOrder);
						pw.flush();
						bs.joinGame(gameName, userName, this);		
					}
					
					boolean gameEnd = false;
					while(!gameEnd) {
						String bet = null;
							try {
							//System.out.println("check3");
							while(true) {
								bet = br.readLine();
								System.out.println(bet);
								if(bet != null) {
									break;
								}
							}
							//System.out.println("check4");
							try {
								betAmount = Integer.parseInt(bet);
								bs.updateBet(betAmount, gameName, userName, this);
								//waiting
								while(true) {
								
								}
								
							}catch(NumberFormatException nfe) {
								System.out.println(nfe.getMessage());
							}
							
						}catch(IOException ioe) {
							System.out.println("Reading bet amount in Server Thread: " + ioe.getMessage());
						}
					//}
						gameEnd = bs.gameEnded(gameName);	
					}
				}
			}
			
			
		}catch(IOException ioe){
			System.out.println("ioe in ServerThread.run(): " + ioe.getMessage());
			
		}
	}

}


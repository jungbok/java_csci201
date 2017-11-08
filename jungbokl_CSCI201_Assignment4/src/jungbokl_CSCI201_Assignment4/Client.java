package jungbokl_CSCI201_Assignment4;

import java.io.BufferedReader;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.Socket;
import java.util.Scanner;

public class Client{
	//thread to do different things at the same time. Sending, getting message at the same time
	
	private BufferedReader br;
	private PrintWriter pw;
	//private boolean k = false;
	private String gameName;
	private int chips = 500;
	private int playerNumber;
	
	public Client(String hostname, int port) {
		//welcome message
		System.out.println("Welcome to Black Jack!");
		boolean ipaddress = false;
		boolean correctPort = false;
		Scanner sc = new Scanner(System.in);
			
		//check the user is prompted for the ip address
		while(!ipaddress || !correctPort) {
			ipaddress = false;
			System.out.println("Please enter the ipaddress");
			String ip = sc.nextLine();
			if(ip.equals(hostname)) {
					//change the boolean to true
				ipaddress = true;
				System.out.println("Please enter the port");
				String portN = sc.nextLine();
					try {
						int portNum = Integer.parseInt(portN);
							//check the user is prompted for the port number
						if(port == portNum){
							correctPort = true;
						}
						else {
							System.out.println("Unable to connect to server with provided fields");
						}
					}
					//catch when the user put wrong format for the port number
					catch(NumberFormatException ne) {
						System.out.println("Unable to connect to server with provided fields");
							
					}
				}	
			}
		//Give an option to the user
		try {
			Socket s = new Socket(hostname, port);
			//System.out.println("Connected to " + hostname + ":" + port);
			br = new BufferedReader(new InputStreamReader(s.getInputStream()));
			pw = new PrintWriter(s.getOutputStream());
			//DataInputStream FromServer = new DataInputStream(s.getInputStream());
			//DataOutputStream ToServer = new DataOutputStream(s.getOutputStream());
			//this.start();
			
			
			int uChoice = 0;
			//Scanner sc2 = new Scanner(System.in);
			boolean choice = false;
			while(!choice) {
				//prints out the options
				System.out.println("Please choose from the option below");
				System.out.println("1) Start Game");
				System.out.println("2) Join Game");
				String uc = sc.nextLine();
				try {
					//read user input and parse it to string - catch exception
					uChoice = Integer.parseInt(uc);
					
					if(uChoice!= 1 && uChoice !=2) {
						continue;
					}
					else {
						//ToServer.writeInt(uChoice);
						pw.println(uChoice);
						pw.flush();
						choice = true;
					}
				}
			
				//numberformat exception
				catch(NumberFormatException ne) {
					System.out.println("Choose an option with the Integer value");
				}
			}
		
			// starting the game
			if(uChoice == 1) {
				boolean correctRange = false;
				int playerNumber = 0;
				//check if the user provide the correct range of players in the game 
				while(!correctRange) {
					System.out.println("Please choose the number of players in the game (1 - 3)");
					String pn = sc.nextLine();
					try {
						playerNumber= Integer.parseInt(pn);
						if(playerNumber == 1 || playerNumber == 2 || playerNumber == 3) {
							correctRange = true;
							pw.println(playerNumber);
							pw.flush();
							continue;
						}
						else {
							correctRange = false;
							//continue;
						}
					}
					catch(NumberFormatException ne) {
						System.out.println("Choose a valid number of players in the game (1 - 3)");
					}
				}
				// correct range of players in the game
				// user needs to create a unique name for their game.
			
				boolean uniqueN = false;
				while(!uniqueN) {
					System.out.println("Please choose a name for your game");
					//sends the unique name to the server
					gameName = sc.nextLine();
					pw.println(gameName);
					pw.flush();
					//receives a validation from the server
					String uniqueName = br.readLine();
					
					//uniqueN = FromServer.readBoolean();
					//System.out.println(uniqueName);
					if(uniqueName.equals("true")) {
						uniqueN = true;
					}
					//if(uniqueN) {
					//	System.out.println("Can create a game");
					//}
					
					else if(!uniqueN) {
						System.out.println("Invalid Choice. This game name has already been chosen by another user");
					}
				
				}
				//created a game!
				//user will be able to receive message directly through the server now
				//k = true;
				
				//user enters the username
				String userName = null;
				while(userName==null || userName.isEmpty()) {
					System.out.println("Please choose a username");
					userName = sc.nextLine();
					if(userName == null || userName.isEmpty()) {
						System.out.println("Invalid username, plese choose again.");
					}
				}
				
				//sends the name
				pw.println(userName);
				pw.flush();
				
				//needs to wait until the other users join
				String message = br.readLine();
				System.out.println(message);
				
				waitingCreatedGame(userName, playerNumber);
				
		
			
			}
			else if(uChoice == 2) {
				boolean gameExists = false;
				//String gameName = "";
				while(!gameExists) {
					System.out.println("Please enter the name of the game you wish to join");
					gameName = sc.nextLine();
					pw.println(gameName);
					pw.flush();
					
					
					String gameE = br.readLine();
					if(gameE.equals("true")) {
				
						gameExists = true;
					}
					else {
						System.out.println("Invalid choice. There are no ongoing games with this name");
					}
				}
				
				boolean userExists = true;
				String UserName = "";
				while(userExists) {
					//sends the user name to the server
					System.out.println("Please choose a user name");
					UserName = sc.nextLine();
					pw.println(UserName);
					pw.flush();
					
					//server answers if the name is valid
					String userE = br.readLine();
					if(userE.equals("valid")) {
						userExists = false;
					}
					else {
						System.out.println("Invalid choice. This username is already been chosen by another player in this game");
					}
				}
				
				boolean gameWaiting = true;
				//k = true;
				//System.out.println("The game will start shortly. Waiting for other players to join");
				waitingJoinedGame(UserName);
				
			}
			
		
				
		}catch(IOException ioe) {
			System.out.println("ioe in ChatClient constructor: " + ioe.getMessage());
		}
		
		
		
	}
	
	
	
	public void waitingCreatedGame(String userName, int playerNum){
		int tempPlayerNum = playerNum;
		try {
			while(playerNum != 0) {
				String message = br.readLine();
				System.out.println(message);
				playerNum--;
			}
			beginGame(userName, gameName, tempPlayerNum, 1);
		}catch(IOException ioe) {
				System.out.println("ioe in Clinet.waitingCreatedGame: " + ioe.getMessage());
		}
	}
	
	public void waitingJoinedGame(String userName) {
		int playerNum = 0;
		int playerOrder = 0;
		try {
			String Num = br.readLine();
			String order = br.readLine();
			try {
				playerNum = Integer.parseInt(Num);
				//System.out.println("checking player number: " + playerNum);
				playerOrder = Integer.parseInt(order);
				//System.out.println("checking player order: " + playerOrder);
			}catch(NumberFormatException nfe){
				System.out.println("NumberFormat Exception");
			}
			
			int k = 2;
			while(k!=0) {
				String message = br.readLine();
				System.out.println(message);
				k--;
			}
			beginGame(userName, gameName, playerNum, playerOrder);
			
		}catch(IOException ioe) {
				System.out.println("ioe in Clinet.waitingJoinedGame: " + ioe.getMessage());
		}
		
	}
	
	public void beginGame(String UserName, String gameName, int playerNum, int order) {
		boolean gameEnd = false;
		//Scanner bet = new Scanner(System.in);
		int betAmount = 0;
		while(!gameEnd) {
			try {
				//get first two messages, shuffle notice
				//notice of turn
				for(int i = 0; i < 2; i++) {
					String message = br.readLine();
					System.out.println(message);
				}
				betAmount = waitGameMessages(gameName, UserName, playerNum, order);
				
				printStatus(playerNum);
				//individualStatus()
				
				while(true) {
					
				}
				
				
			}catch(IOException ioe) {
				System.out.println("BeginGame: " + ioe.getMessage());
				gameEnd = true;
			}
		}
	}
	public int waitGameMessages(String gameName, String UserName, int playerNum, int playerOrder) {
		int betAmount = 0;
		//System.out.println("Checking order: " + UserName + " " + playerOrder);
		
		if(playerNum == 1) {
			betAmount = sendBet(gameName, UserName);
			try {
				String message = br.readLine();
				System.out.println(message);
			}catch(IOException ioe) {
				System.out.println("1 player game, after 1 player bet");
			}
		}
		
		else if(playerNum == 2) {
			if(playerOrder == 1) {
				//System.out.println("check1");
				betAmount = sendBet(gameName, UserName);
				//System.out.println("check5");
				try {
					for(int i = 0; i < 3; i++) {
						String message = br.readLine();
						System.out.println(message);
					}
				}catch(IOException ioe) {
					System.out.println("2 player game, after first player bet");
				}
			}
			else {
				try {
					for(int i = 0; i < 2; i++) {
						String message = br.readLine();
						System.out.println(message);
					}
					betAmount = sendBet(gameName, UserName);
					String message = br.readLine();
					System.out.println(message);
				}catch(IOException ioe) {
						System.out.println("2 player game, after second player bet");
				}
			}
		}else {
			if(playerOrder == 1) {
				betAmount = sendBet(gameName, UserName);
				try {
					for(int i = 0; i < 5; i++) {
						String message = br.readLine();
						System.out.println(message);
					}
				}catch(IOException ioe) {
					System.out.println("3 player game, after first player bet");
				}
				
			}else if(playerOrder == 2) {
				try {
					for(int i = 0; i < 2; i++) {
						String message = br.readLine();
						System.out.println(message);
					}
					betAmount = sendBet(gameName, UserName);
					for(int j = 0; j < 3; j++) {					
						String message = br.readLine();
						System.out.println(message);
					}
				}catch(IOException ioe) {
						System.out.println("2 player game, after 2nd player bet");
				}
			}else {
				try {
					for(int i = 0; i < 4; i++) {
						String message = br.readLine();
						System.out.println(message);
					}
					betAmount = sendBet(gameName, UserName);
					String message = br.readLine();
					System.out.println(message);
				}catch(IOException ioe) {
						System.out.println("3 player game, after third player bet");
				}
				
				
			}
		}
		
		
		return betAmount;
	}
	
	public void printStatus(int playerNum) {
		try {
			int num = (playerNum*7) + 5;
			for(int i = 0; i < num; i++) {
				String message = br.readLine();
				System.out.println(message);
			}
			
		}catch(IOException ioe) {
			System.out.println("printStatus error");
		}
	}
	
	public int sendBet(String userName, String gameName) {
		//System.out.println("check2");
		int betAmount = 0;
		Scanner bet = new Scanner(System.in);
		boolean correctAmount = false;
		while(!correctAmount) {
			String bAmount = bet.nextLine();
			//System.out.println("check3 bet Amount: " + bAmount);
			try {
				betAmount = Integer.parseInt(bAmount);
				
				if(betAmount <= 0) {
					System.out.println("Invalid amout of bet");
					System.out.println("Please retype the amount of bet");
				}
				else if(betAmount > chips) {
					System.out.println("Invalid amout of bet");
					System.out.println("Please retype the amount of bet");
				}
				else {
					
					pw.println(bAmount);
					pw.flush();
					//System.out.println("check4");
					correctAmount = true;
				}	
				
			}catch(NumberFormatException nfe) {
				System.out.println("Invalid amount of bet");
				System.out.println("Please retype the amount of bet");
			}
					
		}
		return betAmount;
		
	}
	
	
	
	public static void main(String [] args) {
		
		Client bjc = new Client("localhost" , 6789);
		//client needs their ip address and port in its parameter
	}

}

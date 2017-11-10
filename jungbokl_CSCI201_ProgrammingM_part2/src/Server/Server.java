package Server;


import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.Scanner;
import java.util.Vector;


public class Server {
	
	private Vector<ServerThread> serverThreads;
	//private Map<String, List<String>> GameList;
	private Vector<War> games;
	private int portNum = -1;
	private ServerSocket ss;
	private int playerN;
	private Map<War, Integer> bets;

	
	public Server() {
		//try {
			//welcome message
			System.out.println("Welcome to the War Card Game Server!");
			boolean notFound = true;
			Scanner scan = new Scanner(System.in);
			
			//The user should be prompted for the server's port number
			while(notFound) {
				System.out.println("Please enter the port");
				String portN= scan.nextLine();
				//int portNum = 0;
				try{
					portNum = Integer.parseInt(portN);
				}
				catch(NumberFormatException ne){
					System.out.println("Invalid port number.");
					continue;
				}
				
				try {
	
						ss = new ServerSocket(portNum);
						notFound = false;
					//}
					if(portNum == -1) {
						System.out.println("Invalid port number");
					}
					
				}catch(IOException ioe) {
					System.out.println("Invalid port number");
				
				}catch(IllegalArgumentException iae) {
					System.out.println("Invalid port number");
				}
				
				
			}
			//start running the server	
			//ServerSocket ss = new ServerSocket(port);
			System.out.println("Successfully started the War Card Game Server on port " + portNum);
			serverThreads = new Vector<ServerThread>();
			games = new Vector<War>();
			playerN = 0;
			//playerN = new ArrayList();
			//bet = new HashMap<War, Integer>();
			
			try {
			//keeps on running
				while(true) {
					Socket s = ss.accept();
					System.out.println("Connection from " + s.getInetAddress());
					ServerThread st = new ServerThread(s, this);
					serverThreads.add(st);
				}
			
		}catch(IOException ioe) {
			System.out.println("ioe in Server constructor: "+ ioe.getMessage());
			//might thrown when port is already filled up
			//might be out of port range invalid
		}
	}
	
	//public void broadcast(String message, ServerThread st)
	
	public int findGame() {
		
		if(games.size() == 0) {
			playerN = 0;
		}
		
		return playerN;
	}
	
	public void createGame(ServerThread st) {
		//int gameName = games.size();
		War nGame = new War(st);
		games.add(nGame);
		playerN = 1;			
	}
	
	public void joinGame(ServerThread st) {
		int gameNum = games.size();
		
		War tempWar = games.get(gameNum -1);
		tempWar.addPlayer(st);
		playerN = 0;
		beginGame(tempWar, 100, 100);
	}
	
		
	public void beginGame(War tempWar, int p1Chips, int p2Chips) {
		Vector <ServerThread>  sts = tempWar.getServerThreads();
		Deck deck = new Deck();
		boolean endGame = false;
		
		ServerThread p1 = sts.get(0);
		ServerThread p2 = sts.get(1);
		
		p1.sendMessage("How much do you want to bet? ");
		int betAmount = p1.recieveBet();
		
		boolean resume = true;
		
		//while(resume) {
		p2.sendMessage("Player1 bet $" + betAmount + ". Accept? (Yes, NO) ");
			
		resume = p2.getAcceptance();
		
		if(resume) {
			deck.shuffle();
			Card c1 = deck.drawCard();
			Card c2 = deck.drawCard();
			
			if(c1.getValue() > c2.getValue()) {
				p1.sendMessage("Player 1 wins $" + betAmount);
				p2.sendMessage("player 2 loses $" + betAmount);
			
				broadcast(tempWar,"Thanks for playing the game");
				//endGame = true;
			}
			else if(c1.getValue() < c2.getValue()) {
				p1.sendMessage("Player 1 loses $" + betAmount);
				p2.sendMessage("player 2 wins $" + betAmount);
				broadcast(tempWar,"Thanks for playing the game");
			}
		
			else {
				broadcast(tempWar,"Draw! Ready to Continue? (Yes, No)" );
				//String ready = sc.nextLine();
			
			}
		}
		
		
	}


	public void broadcast(War b, String message) {
		//
		if(message != null) {
			//System.out.println(message);
			Vector<ServerThread> playerThreads = b.getServerThreads();
			
			for(int i = 0; i < playerThreads.size(); i++) {
			
				playerThreads.get(i).sendMessage(message);
			}
		}
	}
	


	public static void main(String [] args) {
		
		Server bs = new Server();
	}
	
	
}

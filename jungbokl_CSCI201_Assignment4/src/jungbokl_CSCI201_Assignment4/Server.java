package jungbokl_CSCI201_Assignment4;


import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.HashMap;
import java.util.Map;
import java.util.Scanner;
import java.util.Vector;


public class Server {
	
	private Vector<ServerThread> serverThreads;
	//private Map<String, List<String>> GameList;
	private Vector<BlackJack> games;
	private int portNum = -1;
	private ServerSocket ss;
	private Map<BlackJack, Vector<Integer>> bets;
	//static boolean betUpdated = false;
	//< > calls generic

	
	public Server() {
		//try {
			//welcome message
			System.out.println("Welcome to the Black Jack Server!");
			boolean notFound = true;
			Scanner scan = new Scanner(System.in);
			
			//The user should be prompted for the server's port number
			while(notFound) {
				System.out.println("Please enter the port");
				String portN= scan.nextLine();
				//int portNum = 0;
				try{
					portNum = Integer.parseInt(portN);
				//if the user's port number == port number, launch it
					//if(portNum == port) {
					//	notFound = false;
					//}
					//else {
					//	System.out.println("Invalid port number.");
					//}
				}
				catch(NumberFormatException ne){
					System.out.println("Invalid port number.");
					continue;
				}
				
				try {
					//if(portNum!=0) {
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
			System.out.println("Successfully started the Black Jack Server on port " + portNum);
			serverThreads = new Vector<ServerThread>();
			games = new Vector<BlackJack>();
			bets = new HashMap<BlackJack,Vector<Integer>>();
			
			//testing to see if the game can validate the unique name
			//BlackJack bj = new BlackJack("j", 3, "kk");
			//games.add(bj);
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
	
	//public void broadcast(String message, ServerThread st) {
	//	if(message != null) {
	//		System.out.println(message);
	//		for(ServerThread thread : serverThreads) {
	//			if(thread != st) {
	//				thread.sendMessage(message);
	//			}
	//		}
	//	}
		
	//}
	
	public boolean validateGame(String gameName) {
		boolean unique = true;
		
		if(gameName == null) {
			return false;
		}
		if(games!= null) {
			for(int i = 0; i < games.size(); i++) {		
				//if it is not, change boolean value to false
				if(games.get(i).getGameName().equals(gameName)) {
					//System.out.println(games.get(i).getGameName());
					unique = false;
				}
			}
		}
		return unique;
	}
	
	//function to create a game
	public void addCreatedGame(String gameName, int playerNum, String CreatorName, ServerThread st) {
		BlackJack bj = new BlackJack(gameName, playerNum, CreatorName, st, this);
		games.add(bj);
		Vector<Integer> vec = new Vector<Integer>();
		bets.put(bj,vec);
		//System.out.println("added");
	}
	

	
	public boolean checkGameFilled(String gameName) {
		boolean filled = false;
		//BlackJack game
		//find the right game
		BlackJack temp = null;
		for(int i = 0 ;  i < games.size(); i++) {
			if(gameName.equals(games.get(i).getGameName())) {
				temp = games.get(i);
			}
		}
		
		if(temp != null) {
			if(temp.getPlayerList().size() == temp.getPlayerNum()) {
				filled = true;
			}
		}
		
		//broadcast(temp,"Player is joining");
		
		return filled;
	}
	//tells how many clients need to join to start the game
	//public void WaitToJoin(String gameName) {
			
	//}
	//find the game is existing
	public boolean findGame(String gameName) {
		boolean found = false;
		//boolean canJoin = false;
		if(games != null) {
			BlackJack temp = null;
			for(int i = 0 ;  i < games.size(); i++) {
				if(gameName.equals(games.get(i).getGameName())) {
					temp = games.get(i);
					found = true;
				}
			}
		}
		
		return found;
	}
	
	//method to find if UserName is valid for that game
	public boolean validUName(String gameName, String userName) {
		boolean validName = true;
		BlackJack temp = null;
		if(games != null) {
			
			for(int i = 0 ;  i < games.size(); i++) {
				if(gameName.equals(games.get(i).getGameName())) {
					temp = games.get(i);
				}
			}
		}
		if(temp!=null) {
			Map<String, Integer> players = temp.getPlayerList();
			
			//iterate through the user name to see if it exists;
			for(Map.Entry<String, Integer> entry: players.entrySet()) {
					String uName = entry.getKey();
					if(uName.equals(userName)) {
						validName = false;
					}
			}	
			
		}
		return validName;
	}
	
	public void joinGame(String gameName, String userName, ServerThread st) {

		//boolean joined = false;
		boolean filled = true;
		boolean gameStart = false;
		BlackJack temp = null;
		for(int i = 0 ;  i < games.size(); i++) {
			if(gameName.equals(games.get(i).getGameName())) {
				temp = games.get(i);
			}
		}
		
		filled = checkGameFilled(gameName); 
		if(!filled) {
			gameStart = temp.addPlayer(userName, st);
	
		}
		
		if(gameStart) {
			runGame(temp);
		}
	}
	
	public void gameStart(String gameName) {
		
		BlackJack temp = null;
		for(int i = 0 ;  i < games.size(); i++) {
			if(gameName.equals(games.get(i).getGameName())) {
				temp = games.get(i);
			}
		}
		
		if(temp!=null) {
			runGame(temp);
		}
		
	}
	
	public int getPlayerNum(String gameName) {
		int playerNum = 0;
		BlackJack temp = null;
		for(int i = 0 ;  i < games.size(); i++) {
			if(gameName.equals(games.get(i).getGameName())) {
				temp = games.get(i);
			}
		}
		if(temp!=null) {
			playerNum = temp.getPlayerNum();
		}
		
		return playerNum;
	}
	
	public BlackJack getGame(String gameName){
		BlackJack temp = null;
		if(games != null) {
			
			for(int i = 0 ;  i < games.size(); i++) {
				if(gameName.equals(games.get(i).getGameName())) {
					temp = games.get(i);
				}
			}
		}
		return temp;			
	}
	
	public int getPlayerOrder(String gameName) {
		int playerOrder = 0;
		BlackJack temp = null;
		for(int i = 0 ;  i < games.size(); i++) {
			if(gameName.equals(games.get(i).getGameName())) {
				temp = games.get(i);
			}
		}
		if(temp!=null) {
			playerOrder = temp.getPlayerList().size();		
		}
		
		return (playerOrder+1);
		
	}
	
	

	
	public void runGame(BlackJack b) {
		boolean gameEnd = false;
		//repeats round until the game ends
		
		//while(!gameEnd){
			//boolean betDone = false;
			//initiate betamounts vector to keep tract of how much was bet
			
			//Vector<Integer> betAmounts = new Vector<Integer>();
			
			//shuffle
			broadcast(b,"Dealer is shuffling cards...");
			Deck deck = new Deck();
			deck.shuffle();
			Vector<Vector<Card>> playerCard = b.getCards();
			dealCards(deck, b, playerCard);
			
			//String creator = b.getCreatorName();
			Map<String, ServerThread> sts = b.getPlayerThreads();
			Vector<String> userList = b.getUserList();
			
			//for(int i = 0; i < userList.size(); i++) {
				String userName = userList.get(0);
				ServerThread st = sts.get(userName);
				RequestBet(b, userName, st, 0);
			//}

		//}
	}

	public void RequestBet(BlackJack b, String userName, ServerThread st, int order) {
		
		int chips = 0;
		Vector<Integer> chipRemaining = b.getChipRemaining();
		st.sendMessage(userName + ", it is your turn to make a bet. Your chip total is " 
								+ chipRemaining.get(order));
			String messageToOthers = "It is " + userName + "'s turn to make a bet";
			broadcastToOthers(b, messageToOthers, st);
	}
	
	public void updateBet(int bet, String gameName, String userName, ServerThread st) {
		BlackJack temp = null;
		for(int i = 0 ;  i < games.size(); i++) {
			if(gameName.equals(games.get(i).getGameName())) {
				temp = games.get(i);
			}
		}
		
		if(temp!=null) {
			Vector<Integer> betAmounts = bets.get(temp);
			betAmounts.add(bet);
			bets.put(temp,betAmounts);
			recieveBet(temp, userName, st, bet);
		}
		
	}
	
	public void recieveBet(BlackJack b, String userName, ServerThread st, int bet) {
		st.sendMessage("You bet " + bet + " chips");
		String messageToOthers = userName + " bet " + bet + " chips";
		broadcastToOthers(b, messageToOthers, st);
		
		//Find next user, if there is
		Map<String, ServerThread> sts = b.getPlayerThreads();
		Vector<String> userList = b.getUserList();
		String nextUser = null;
		int order = 0;
		
		for(int i = 0; i < userList.size(); i++) {
			if(userList.get(i).equals(userName)) {
				if(i < userList.size()-1) {
					nextUser = userList.get(i+1);
					order= i+1;
				}
			}
		}
		
		if(nextUser==null) {
			//dealing cards
			
			printStatus(b);
		}
		else {
			ServerThread nextSt = sts.get(nextUser);
			RequestBet(b, nextUser, nextSt, order);
		}
		
		
		
	}
	
	public void dealCards(Deck deck, BlackJack b, Vector<Vector<Card>> playerCards) {
		//first vector is for the dealer
		b.dealCards(deck, playerCards);
	}
	
	
	public void printStatus(BlackJack b) {
		Vector<Vector<Card>> playerCards = b.getCards();
		Vector<String> userList = b.getUserList();
		Vector<Integer> chipsRemaining = b.getChipRemaining();
		Vector<Integer> betAmount = bets.get(b);
		
		for(int i = 0; i < (userList.size() + 1); i++) {
			Vector<Card> temp = playerCards.get(i);
			if(i == 0) {
				broadcast(b, "-------------------------------------------------");
				broadcast(b, "Dealer");
				broadcast(b, "");
				String str = "Cards: | ? | " + temp.get(1).toString() + " |";
				broadcast(b, str);
				broadcast(b, "--------------------------------------------------");
			}
			else {
				
				Card c1 = temp.get(0); 
				Card c2 = temp.get(1);
				broadcast(b, "-------------------------------------------------");
				broadcast(b, "Player: " + userList.get(i));		
				broadcast(b, "");
				int status = c1.getValue() + c2.getValue();
				if(c1.getValue() == 1 || c2.getValue() == 1) {
					int status2 = status + 10;
					if(status2 <= 21) {
						String str = "Status: " + status + " or " + status2; 
						broadcast(b,str);
					}
					else {
						String str = "Status: " + status;
						broadcast(b, str);
					}
				}
				else {
					String str =  "Status: " + status;
					broadcast(b, str);
				}
				String str = "Cards: | " + temp.get(0).toString() + " | " + temp.get(1).toString() + " |";
				broadcast(b, str);
				int chipTotal = chipsRemaining.get(i-1);
				int bet = betAmount.get(i-1);
				str = "Chip Total: " + chipTotal + "  | Bet Amount: " + bet;
				broadcast(b, str);
				broadcast(b, "--------------------------------------------------");
				
			}
				
		}
		
		
		
		
	}
	
	
	
	public void broadcast(BlackJack b, String message) {
		//
		System.out.println(b.getGameName());
		if(message != null) {
			//System.out.println(message);
			Map<String, ServerThread> playerThreads = b.getPlayerThreads();
			
			for(Map.Entry<String, ServerThread> entry: playerThreads.entrySet()) {
					ServerThread thread = entry.getValue();
					thread.sendMessage(message);
			}
		}
	}
	
	public void broadcastToOthers(BlackJack b, String message, ServerThread st) {
		if(message != null) {
			//System.out.println(message);
			Map<String, ServerThread> playerThreads = b.getPlayerThreads();
			
			for(Map.Entry<String, ServerThread> entry: playerThreads.entrySet()) {
					ServerThread thread = entry.getValue();
					if(thread!=st) {
						thread.sendMessage(message);
					}
			}
		}
	}
	
	public void gameRoomTesting() {
		for(int i  = 0; i<games.size(); i++) {
			System.out.println("Game Name: " + games.get(i).getGameName());
			Map<String, Integer> players  = games.get(i).getPlayerList();
			System.out.print("Player names: ");
			for(int j = 0; j < players.size(); j++) {
				System.out.print(players.get(j) + " ");
			}
			System.out.println(" ");
		}
	}
	
	public boolean gameEnded(String gameName) {
		return false;
	}

	public static void main(String [] args) {
		
		Server bs = new Server();
	}
	
	
}

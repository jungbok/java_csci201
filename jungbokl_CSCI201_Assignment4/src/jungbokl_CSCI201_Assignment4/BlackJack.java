package jungbokl_CSCI201_Assignment4;

import java.io.BufferedReader;
import java.io.PrintWriter;
import java.net.Socket;
import java.util.HashMap;
import java.util.Map;
import java.util.Vector;


public class BlackJack extends Thread{
	
	private int playerNum;
	private String GameName;
	private String creatorName;
	//private ServerThread gameCreator;
	private BufferedReader br;
	private PrintWriter pw;
	private Vector<String> userList;
	private Map<String, Integer> playerChips;
	private ServerThread st;
	private Map<String, ServerThread> serverThreads;
	private Server bs;
	//private Deck deck;
	private Vector<Integer> chipRemaining;
	//private Vector<Integer> betAmounts;
	private Vector<Vector<Card>> dealtCards;
	//private boolean vectorUpdated = false;
	//private Client c;
	
	public BlackJack(String GameName, int playerNum, String CreatorName, ServerThread st, Server bs) {
		this.playerNum = playerNum;
		this.GameName = GameName;
		this.playerChips = new HashMap<String, Integer>();
		playerChips.put(CreatorName, 500);
		//players.put(CreatorName);
		this.serverThreads = new HashMap<String,ServerThread>();
		this.st = st;
		this.userList = new Vector<String>();
		userList.add(CreatorName);
		serverThreads.put(CreatorName, st);
		//this.run();
		this.bs = bs;
		//this.deck = new Deck();
		this.chipRemaining = new Vector<Integer>();
		//this.betAmounts = new Vector<Integer>();
		this.creatorName  = CreatorName;
		this.dealtCards = new Vector<Vector<Card>>();
		//initiate the vector of chips, all 500 chips at first
		for(int i = 0; i < playerNum; i++) {
			chipRemaining.add(500);
		}
		
	}
	public String getCreatorName() {
		return creatorName;
	}
	
	public String getGameName() {
		return GameName;
	}
	
	public int getPlayerNum() {
		return playerNum;
	}
	
	public Map<String, Integer> getPlayerList() {
		return playerChips;
	}
	
	public Map<String, ServerThread> getPlayerThreads(){
		return serverThreads;
	}
	
	public Vector<String> getUserList(){
		return userList;
	}
	
	public void dealCards(Deck d, Vector<Vector<Card>> dealtcard) {
		for(int i = 0; i <= playerNum; i++) {
			Vector<Card> playerCard = new Vector<Card>();
			for(int j = 0; j < 2; j++) {
				Card c = d.drawCard();
				playerCard.add(c);
			}
			dealtcard.add(playerCard);
		}
	}
	
	public Vector<Integer> getChipRemaining(){
		return chipRemaining;
	}
	
	public void setChipRemaining(Vector<Integer> remainingChips){
		this.chipRemaining = remainingChips;
	}
	
	public Vector<Vector<Card>> getCards(){
		return dealtCards;
	}
	
	public boolean addPlayer(String name, ServerThread st) {
		boolean filled = false;
		//add new player in the map
		playerChips.put(name, 500);
		serverThreads.put(name,st);
		userList.add(name);
		
		//System.out.println("Check2");
		
		st.sendMessage("The game will start shortly. Waiting for other players to join..");
		filled = gameStart(name);
		
		//if(!filled) {
		//}
		
		return filled;
	}
	
	public boolean gameStart(String name) {
		boolean filled = false;
		int remaining = 0;
		remaining = playerNum - playerChips.size();
		
		//System.out.println("check3");
		//System.out.println("remaining player to wait: " + remaining);
		
		
		//send a message that is joining
		st.sendMessage(name + " joined the game");
		
		if(remaining == 0) {
			filled = true;
			broadcast("Let the game commence. Good luck to all players!");
			//run();
		}
		else {
			st.sendMessage("Waiting for " + remaining + " other players to join..." );
		}
		
		return filled;
	}
	
	
	public void run() {
		
	}
	
	
	
	public void dealer() {
		
	}
	
	
	public void broadcast(String message) {
		if(message != null) {
			for(Map.Entry<String, ServerThread> entry: serverThreads.entrySet()) {
				ServerThread thread = entry.getValue();
				thread.sendMessage(message);
			}
		}
	}
	
	
	public void broadcastToOthers(ServerThread st, String message) {
		if(message != null) {
			for(Map.Entry<String, ServerThread> entry: serverThreads.entrySet()) {
				ServerThread thread = entry.getValue();
				if(thread!=st) {
					thread.sendMessage(message);
				}
			}
		}
	}
	
	
	
}


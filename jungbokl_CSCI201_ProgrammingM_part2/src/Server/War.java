package Server;

import java.util.Scanner;
import java.util.Vector;

public class War {
	//private Deck deck;
	//private Card c1;
	//private Card c2;
	private ServerThread st;
	private int p1Chips;
	private int p2Chips;
	private Vector<ServerThread> serverThreads;
	
	
	
	public War(ServerThread st) {
		//this.deck = new Deck();
		this.p1Chips = 100;
		this.p2Chips = 100;
		this.st = st;
		this.serverThreads = new Vector<ServerThread>();
		serverThreads.add(st);
		//playGame(deck, p1Chips, p2Chips);
	}
	
	public void addPlayer(ServerThread st) {
		serverThreads.add(st);
	}
	
	public Vector<ServerThread> getServerThreads(){
		return serverThreads;
	}
	
	public void playGame(Deck deck, int p1Chips, int p2Chips) {
		
	}
}

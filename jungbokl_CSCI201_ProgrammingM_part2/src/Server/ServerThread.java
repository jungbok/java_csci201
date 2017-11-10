package Server;

import java.io.BufferedReader;
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
			boolean gameEnd = false;
			while(!gameEnd) {
				//boolean gameEnd = false;
				int search = 0;
				search = bs.findGame();
				
				if(search == 1) {
					//boolean acceptBet;
					bs.joinGame(this);
					sendMessage("Joined the game");
					//boolean gameBegin = false;
					
					//String betAmount  = br.readLine();
				}
				else {
					bs.createGame(this);
					sendMessage("Created game: waiting the other player");		
				}
			}
	
	}
	public boolean getAcceptance() {
		boolean Accept = false;
		try {
			String accept = br.readLine();
			if(accept.equals("Yes")) {
				Accept = true;
			}
				
		}catch(IOException ioe){
			System.out.println("ioe in ServerThread.run(): " + ioe.getMessage());
			
		}
		
		return Accept;
	}
	
	public int recieveBet() {
		int betAmount = 0;
		try {
			String bet = br.readLine();
				try {
					betAmount = Integer.parseInt(bet);
				}
				catch(NumberFormatException nfe) {
					System.out.println(nfe.getMessage());
				}
				
		}catch(IOException ioe){
			System.out.println("ioe in ServerThread.run(): " + ioe.getMessage());
			
		}
		return betAmount;
	}

}


package jungbokl_CSCI201_ProgrammingM;

import java.util.Scanner;

public class War {
	//private Deck deck;
	//private Card c1;
	//private Card c2;
	//private int p1Chips;
	//private int p2Chips;
	
	public War() {
		//this.deck = new Deck();
		//this.p1Chips = 100;
		//this.p2Chips = 100;
		//playGame(deck, p1Chips, p2Chips);
	}
	
	public void playGame(Deck deck, int p1Chips, int p2Chips) {
		boolean endGame = false;
		Scanner sc = new Scanner(System.in);
		Card c1 = null;
		Card c2 = null;
		int p1Bet = 0;
		
		boolean correctBet = false;
		boolean accept = false;
		while(!accept){
			while(!correctBet) {
				try {
					System.out.print("Player 1 bets: ");
					String p1 = sc.nextLine();
					p1Bet = Integer.parseInt(p1);
			
					if(p1Bet <= 0 || p1Bet > 100) {
						System.out.println("Invalid amount to bet");
					}
					else {
						//System.out.println(p1Bet);
						correctBet = true;
					}
				}catch(NumberFormatException nfe) {
					System.out.println("invalid amount to bet");
				}
			
			}
		
			System.out.print("Player 2 accepts? (reply Yes or No) ");
			String p2Accept = sc.nextLine();
			
			if(p2Accept.equals("Yes")) {
				accept = true;
			}
		}
		//shuffle the deck
		deck.shuffle();
		
		while(!endGame) {
		
			c1 = deck.drawCard();
			c2 = deck.drawCard();
			boolean continueG = true;
			
			System.out.println("Player 1 Card: " + c1.toString());
			System.out.println("Player 2 Card: " + c2.toString());
		
			if(c1.getValue() > c2.getValue()) {
				System.out.println("Player 1 wins $" + p1Bet);
				System.out.println("player 2 loses $" + p1Bet);
			
				System.out.println("Thanks for playing the game");
				endGame = true;
			}
			else if(c1.getValue() < c2.getValue()) {
				System.out.println("Player 1 loses $" + p1Bet);
				System.out.println("player 2 wins $" + p1Bet);
				System.out.println("Thanks for playing the game");
				endGame = true;
			}
		
			else {
				System.out.println("Draw! Ready to Continue? (Yes, No)" );
				String ready = sc.nextLine();
				
				if(ready.equals("Yes")) {
					continue;
				}
				else {
					continueG = false;
					System.out.println("Thanks for playing the game");
				}
			}
		}
		
	}
}

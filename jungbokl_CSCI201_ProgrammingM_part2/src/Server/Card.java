package Server;

public class Card {
	
	// card class
	private int rank;
	private int suit;
	private int value;
	private static String[] ranks = {"ACE","TWO","THREE","FOUR","FIVE","SIX","SEVEN","EIGHT","NINE","TEN","JACK","QUEEN","KING"};
	private static String[] suits = {"CLUBS","DIAMONDS","HEARTS","SPADES"};

	
	Card(int suit, int values)
	{
	    this.rank=values;
	    this.suit=suit;
	}
	
	public String toString()
	{
	    return ranks[rank];
	}
	
	
	public int getRank()
	{
	    return rank;
	}
	
	public int getSuit()
	{
	    return suit;
	}
	
	public int getValue()
	{
	    if(rank==1)
	    {
	        value = 11;
	    }
	    else
	    {
	        value = rank;
	    }
	    return value;
	}
	
	public void setValue(int set)
	{
	    value = set;
	}

}

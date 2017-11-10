package Player;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.Socket;
import java.util.Scanner;

public class Player {
	public static void main(String [] args) {
		try {
			//System.out.println("Trying to connect to localhost: 6879");
			Socket s = new Socket("192.168.1.123", 6789);
			System.out.println("Connected!");
			
			//opposite order from chatserver
			
			PrintWriter pw = new PrintWriter(s.getOutputStream());
			BufferedReader br = new BufferedReader(new InputStreamReader(s.getInputStream()));
			
			Scanner scan = new Scanner(System.in);
			//boolean findGame = false;
			while(true) {
				
				String line  = scan.nextLine();
				pw.println(line);
				pw.flush();
				
				while(true) {
					String lineReceived = br.readLine();
					System.out.println(lineReceived);
				
				}
			}
			
			} catch (IOException ioe) {
			System.out.println("ioe: " + ioe.getMessage());
			}
		}
}
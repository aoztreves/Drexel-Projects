// prob2.java

import java.io.*;

public class prob2
{
	public static void main ( String[] args )
	{
		String n = args[0];
		int number = Integer.parseInt( n );
		if( number % 2 == 0 ){
			System.out.println( "Even" );
		}
		else {
			System.out.println( "Odd" );
		}	
	}
}

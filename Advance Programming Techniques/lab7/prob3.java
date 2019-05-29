// prob3.java

import java.io.*;

public class prob3
{
	public static void main( String[] args)
	{
		String n = args[0];
		int number = Integer.parseInt( n );
		if( (number % 4) == 0){
			if( (number % 100) != 0){
				System.out.println("Leap Year");
			}
			else{
				if( (number % 400) == 0){
					System.out.println("Leap Year");
				}
				else{
					System.out.println("Not a Leap Year");
				}
			}
		}
		else{
			System.out.println("Not a Leap Year");
      }
		
	}
}

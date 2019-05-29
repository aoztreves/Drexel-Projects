// prob1.java

import java.io.*;

public class prob1
{
	public static void main( String[] args )
	{
		int counter = 1;
		for( int i=0; i < 100; i++){
			if( (counter % 8) != 0)
			{
				System.out.print(  args[0] + " " );
			}
			else {
				System.out.println( args[0] );
			}
			counter++;
		}
		System.out.println( " ");
	}	
}

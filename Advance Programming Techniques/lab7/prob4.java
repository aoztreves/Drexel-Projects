// prob4.java

import java.io.*;
import java.util.Date;	
public class prob4
{
	public static void main( String[] args )
	{
		String n = args[0];
		int number = Integer.parseInt( n );
		Date date = new Date();
		switch( number ) {
			case 0:
				System.out.println( " number of milliseconds since January 1,1970 : " + date.getTime());
				break;
			case 1:
            System.out.println( " number of seconds since January 1,1970 : " + (date.getTime()/1000));
				break;
			case 2:
            System.out.println( " number of days since January 1,1970 : " + date.getTime()/86400000);
				break;
			case 3:
   			System.out.println( " Current date is : " + date);
				break;
		}
	}
}

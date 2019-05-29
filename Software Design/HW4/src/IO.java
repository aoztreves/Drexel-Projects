import java.io.Serializable;
import java.util.Scanner;


public class IO implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	public IO(){
		
	}
	public int isNumber(int number){ //Checking if the input number is valid
		int x;
		String input;
		Scanner scan = new Scanner(System.in);
		
		while(true){
			input= scan.nextLine();
			try{
				x = Integer.parseInt(input);
				if( ( x <= number )||( x > 0)){
					break;
				}
				else{
					System.out.println("Wrong input");
				}
			}catch(NumberFormatException ex){
				System.out.println("Wrong input");
			}
		}
		return x;
	}
	public String getQuestion(){ //Getting the question
		Scanner scan = new Scanner(System.in);
		String tempQ;

		while(true){
			tempQ=scan.nextLine();
			if(tempQ.isEmpty()){//Checking if the question entered is empty if yes then error.
				System.out.println("Wrong input");
			}
			else{
				break;
			}
		}	
		return tempQ;
	}
	public char isValid(int number){ //This is checking if the input char is valid
		int x;
		String i;
		Scanner scan = new Scanner(System.in);
		while(true){
			i = scan.nextLine();
			try{
				x = i.charAt(0);
				if((x>=65) && (x<= number)){ // Got the numbers from Stackoverflow, basicly this line
					break;
				}
				else{
					System.out.println("wrong input");
				}
			}catch(NumberFormatException ex){
				System.out.println("Wrong input");
			}
		}
		return (char) x;
	}
	
}

import java.io.IOException;
import java.io.Serializable;
import java.util.Scanner;
import java.util.Vector;

public class TrueFalse extends MultipleChoice implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	public TrueFalse(){
		
	}
	public TrueFalse(String question){//setting the choices by hand
		choices.add("True");
		choices.add("False");
		super.setQuestion(question);
	}
	public UserAnswer getAnswerforTF(){
		UserAnswer ua = new UserAnswer();
		System.out.println("True or False?(T/F)");
		while(true){ // Validating
			String q = io.getQuestion();
			if((q.charAt(0) == 'T') || ( q.charAt(0) =='F')||(q.charAt(0) == 't') || (q.charAt(0)=='f')){//Accepting all Char representing True or False
				ua.setuserAnswer(q);
				break;
			}
			else{
				System.out.println("Wrong input");
			}
		}
		return ua;
	}
	public void modify(){
		String newQ;
		while(true){
			System.out.println("Do you want to modify the promt");
			newQ=io.getQuestion();
			if((newQ.equals("Yes"))||(newQ.equals("yes"))){
				System.out.println("Your old prompt");
				System.out.println(prompt);
				System.out.println("Please enter what you want to change it to");
				prompt=io.getQuestion();
				break;
			}
			else if((newQ.equals("No"))||(newQ.equals("no"))){
				break;
			}
			else{
				System.out.println("Wrong input");
			}
		}
	}
	
	public void setuserAnswer(){ // Getting user answer
		UserAnswer ua = new UserAnswer();
		System.out.println("Enter your answer(A/B)");
		String answer = io.getQuestion();
		ua.setuserAnswer(answer);
		userAnswer.add(ua);
	}

}

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
	public void setuserAnswer(){ // Getting user answer
		UserAnswer ua = new UserAnswer();
		userAnswer.add(ua);
	}

}

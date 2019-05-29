
import java.io.Serializable;

import java.util.Vector;

public class Essay extends Question implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	Vector<UserAnswer> userAnswer; // Store the user asnswer
	int answerSize;
	public Essay(){ //basic contructor
		userAnswer = new Vector<UserAnswer>();
		answerSize =1;
	}
	public Essay(String question){ // Geting number of lines with this constructor to limit the user from exceeding the memory.
		System.out.println("Enter number of lines for user input");
		answerSize = io.isNumber(10);
		userAnswer = new Vector<UserAnswer>();
		super.setQuestion(question);
	}
	public void display(){ //Displaying just the question for essay bc there are no answers
		System.out.println(prompt);
	}
	public void setuserAnswer(){ //Getting user Answer/Response
		UserAnswer ua = new UserAnswer();
		System.out.println("Max line is 10");
		for(int i=0;i<answerSize;i++){
			ua.setuserAnswer(io.getQuestion());
		}
		userAnswer.add(ua);
	}
	public Vector<UserAnswer> getUserAnswer(){
		return userAnswer;
	}
	@Override
	public UserAnswer getCorrectAnswer() { //This is for ShortAnswer, it doesnt effect the essay class.
		UserAnswer ua = new UserAnswer();
		ua.setuserAnswer("");
		return ua;
	}
	
	

}

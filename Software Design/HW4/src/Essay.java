
import java.io.Serializable;

import java.util.Vector;

import com.sun.speech.freetts.Voice;
import com.sun.speech.freetts.VoiceManager;

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
	public void display(String voicer){ //Displaying just the question for essay bc there are no answers
		//System.out.println("Would you like to listen the question?(yes/no)");
		//String voicer = io.getQuestion();
		if((voicer == "yes") || (voicer == "Yes")){
			System.out.println(prompt);
			String voiceName = "kevin16";
			VoiceManager voiceManager = VoiceManager.getInstance();
	        Voice voice = voiceManager.getVoice(voiceName);

	        voice.allocate();
	        voice.speak(prompt);
	        voice.deallocate();
		}
		else{
			System.out.println(prompt);
		}
		
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
		while(true){
			System.out.println("Do you want to modify the number of lines");
			newQ=io.getQuestion();
			if((newQ.equals("Yes"))||(newQ.equals("yes"))){
				System.out.println("How many lines do you want this time");
				answerSize = io.isNumber(10);
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
	public void setuserAnswer(){ //Getting user Answer/Response
		UserAnswer ua = new UserAnswer();
		System.out.println("Max line is 10");
		System.out.println("Please enter number of lines you want to use");
		int answerSizeforTaker = io.isNumber(10);
		for(int i=0;i<answerSizeforTaker;i++){	
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

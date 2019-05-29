import java.io.IOException;
import java.io.Serializable;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Scanner;
import java.util.Set;
import java.util.Vector;

import com.sun.speech.freetts.Voice;
import com.sun.speech.freetts.VoiceManager;

public class MultipleChoice extends Question implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	Vector<String> choices; //saving choices
	Vector<UserAnswer> userAnswer;
	int numberofA;
	
	public MultipleChoice(){
		choices = new Vector<String>();
		userAnswer = new Vector<UserAnswer>();
		numberofA =1;
	}
	public MultipleChoice(String question){ //Constructur for handling multiple choice 
		choices = new Vector<String>();
		prompt = question;
		
		setChoices();
		System.out.println("How many choices user should enter?");
		int number = io.isNumber(choices.size());
		userAnswer = new Vector<UserAnswer>();
		numberofA= number;
		
	}
	public MultipleChoice(String question, int number){ //this is for ranking!
		choices = new Vector<String>();
		prompt = question;
		setChoices();
		userAnswer = new Vector<UserAnswer>();
		numberofA = number;
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
			System.out.println("Do you want to modify the choices");
			newQ=io.getQuestion();
			if((newQ.equals("Yes"))||(newQ.equals("yes"))){
				System.out.println("Which choice do uou want to change");
				for(int i=0;i<choices.size();i++){
					System.out.print(i + ") "+choices.get(i) + " ");
				}
				int s = io.isNumber(choices.size());
				System.out.println("Please select the choice number");
				newQ=io.getQuestion();
				choices.set(s-1, newQ);
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
	public void setChoices(){
		String x;
		char choiceOptions = 'A';
		while(true){
			System.out.println("Number of choices for this question?");
			x = io.getQuestion();
			try{
				int i = Integer.parseInt(x);
				break;
			}catch(NumberFormatException ex){
				System.out.println("Wrong input");
			}
		}
			int i = Integer.parseInt(x);
			//int counter = 1;
			for(int j = 0; j < i ; j++){
				System.out.println("Choice " + choiceOptions);
				choices.add(io.getQuestion());
				choiceOptions++;
			}
	}
	
	public String getChoices(int x){
		return choices.get(x);
	}
	public Vector<String> getChoices(){
		return choices;
	}
	public Vector<UserAnswer> getUserAnswer(){
		return userAnswer;
	}
	public void setuserAnswer(){ // getting the user answer
		UserAnswer ua = new UserAnswer();
		System.out.println("Enter "+numberofA+" choices");
		for(int i=0;i<numberofA;i++){
			String q = io.getQuestion();
			ua.setuserAnswer(q);			
		}
		userAnswer.add(ua);
	}
	public void display(String voicer){
		
		//System.out.println("Would you like to listen the question?(yes/no)");
		//String voicer = io.getQuestion();
		if((voicer == "yes") || (voicer == "Yes")){
			String voiceName = "kevin16";
			VoiceManager voiceManager = VoiceManager.getInstance();
			Voice voice = voiceManager.getVoice(voiceName);

			voice.allocate();
			voice.speak(prompt);
			char c = 65;
	        voice.speak("Choices are");
	        for(int i=0;i<choices.size();i++){
	        	voice.speak(c + ") " + choices.get(i));
	        	c++;
	        }
	        voice.deallocate();
		}
		else{
			char c = 65;
			System.out.println(prompt);
			for(int i=0;i<choices.size();i++){
				System.out.println(c + ") " + choices.get(i));
				c++;
			}
		}
        
        
	}
	@Override
	public UserAnswer getCorrectAnswer() {
		UserAnswer ua = new UserAnswer();
		for(int i=1; i <= numberofA;i++){
			System.out.println("Enter Correct choice " + i);
			char x = io.isValid(64+choices.size()); //Stackoverflow for the numbers
			int counter = x - 65;
			String answer = x + ") " + choices.get(counter);
			ua.setuserAnswer(answer);
		}
		return ua;
	}
	
}

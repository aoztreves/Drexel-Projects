import java.io.IOException;
import java.io.Serializable;
import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Scanner;
import java.util.Set;
import java.util.Vector;

import com.sun.speech.freetts.Voice;
import com.sun.speech.freetts.VoiceManager;

public class Matching extends Question implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	HashMap match;
	Vector<UserAnswer> userAnswer;
	
	public Matching(){
		match = new HashMap();
		userAnswer = new Vector<UserAnswer>();
	}
	public Matching(String question){
		match = new HashMap();
		userAnswer = new Vector<UserAnswer>();
		super.setQuestion(question);
		matching();
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
			voice.deallocate();
		}
		else{
			System.out.println(prompt);
			char x = 'A';
			Set<String> id = match.keySet();
			Object[] idArray = id.toArray();//Straight from stackoverflow
			System.out.println(prompt);
			System.out.printf("%-30.30s  %-30.30s%n", "ColumnA", "ColumnB");//Straight from stackoverflow
			for(int i=0;i<match.size();i++){
				String key = (String) idArray[i];//have to convert
				String cA = Character.toString(x) + ") ";
				String cB = Integer.toString(i+1) + ") ";
				System.out.printf("%-30.30s  %-30.30s%n", cA + idArray[i], cB + match.get(key));
				x++;
			}
		}
		
	}
	public void matching() throws NumberFormatException{
		String temp;
		
		System.out.println("How many choices would you like");
		temp = io.getQuestion();
		int nofChoices = Integer.parseInt(temp);
		Vector<String> choiceA = new Vector<String>();
		Vector<String> choiceB = new Vector<String>();
		
		char x='A';
		for(int i=0;i<= nofChoices-1;i++){
			System.out.println("Enter choice number " + (i+1) + " for column A");
			choiceA.add(io.getQuestion());
			x++;
		}
		for(int j=0;j<= nofChoices-1;j++){
			System.out.println("Enter choice number " + (j+1) + " for column B");
			choiceB.add(io.getQuestion());
			x++;
		}
		for(int k=0;k< nofChoices;k++){
			match.put(choiceA.get(k),choiceB.get(k));//Matching the choice here
		}		
	}
	public HashMap getMatch(){
		return match;
	}
	public Vector<UserAnswer> getUserAnswer(){
		return userAnswer;
	}
	public void setuserAnswer(){
		UserAnswer ua = new UserAnswer();
		char x = 'A';
		System.out.println("Match the the column A with the numbers from column B");
		for(int i=0;i< match.size();i++){
			System.out.println( i+1 + ") ");
			int answer = io.isNumber(match.size());
			String str = x + " " + Integer.toString(answer);
			ua.setuserAnswer(str);
			x++;
		}
		userAnswer.add(ua);
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
				match.clear();//so we can get new ones
				//
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
	public UserAnswer getCorrectAnswer(){
		UserAnswer ua = new UserAnswer();
		char x = 'A';
		Collection col = match.values();//Stackoverflow
		Object[] array = col.toArray();
		int starter = 0;
		
		while(starter != match.size()){
			System.out.println("Please enter all options");
			String q = io.getQuestion();
			int qtoI = Integer.parseInt(q);
			if((qtoI > 0) && (qtoI <= match.size())){
				String answer = qtoI + ") " + (String) array[qtoI -1];
				ua.setuserAnswer(answer);
				x++;
				starter++;
			}
			else{
				System.out.println("Wrong input");
			}
			
		}	
		return ua;
	}

	

}

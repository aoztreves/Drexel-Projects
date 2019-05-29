import java.io.Serializable;
import java.util.Vector;

public class Ranking extends MultipleChoice implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	public Ranking(){
		
	}
	public Ranking(String question){
		super(question,1); // MAtching with numbers
	}
	public Ranking(Vector<String> choices){
		
	}
	public UserAnswer getCorrectAnswer(){ //Testing purposes getting the correct answer
		UserAnswer ua = new UserAnswer();
		System.out.println("Enter answers in an order, one at a time"); //getting CA one line at a time
		int s = choices.size();
		for(int i=0;i<s ; i++){
			char x = io.isValid(s + 64);
			int dex =x -65;
			String answer= x+") "+ choices.get(dex);
			ua.setuserAnswer(answer);
		}
		return ua;
	}
	public void setUserAnswer(){ // For user answer
		UserAnswer ua = new UserAnswer();
		System.out.println("Enter answers in an order, one at a time");
		int s = choices.size();
		for(int i=0;i<s ; i++){
			char x = io.isValid(s+64);
			String q = Character.toString(x);
			ua.setuserAnswer(q);
		}
		userAnswer.add(ua);	
	}
	
}

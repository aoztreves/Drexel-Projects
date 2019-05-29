import java.util.Vector;
import java.io.Serializable;


public class UserAnswer implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	Vector<String> userAnswers;
	
	
	public UserAnswer(){
		userAnswers = new Vector<String>();
	}
	public void setuserAnswer(String r){
		userAnswers.add(r);
	}
	public Vector<String> getuserAnswers(){
		return userAnswers;
	}
	public boolean compare(Question q, UserAnswer ua){
		//TODO:For grading
		return true;
	}
	public void display(){//display user answer
		for(int i = 0 ; i < userAnswers.size();i++){
			System.out.println(userAnswers.get(i));
		}
	}
}

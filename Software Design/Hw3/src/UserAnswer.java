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
		Vector<String> correctAnswers = ua.getuserAnswers();
		boolean compareResult = false;
		if(q.getClass().equals(ShortAnswer.class)== true){
			compareResult = true;
		}
		else if(((q.getClass().equals(MultipleChoice.class) == true)||(q.getClass().equals(Ranking.class) == true))||(q.getClass().equals(TrueFalse.class) == true)){
			for(int i = 0;i <correctAnswers.size();i++){
				char x = correctAnswers.get(i).charAt(0);
				char y = userAnswers.get(i).charAt(0);
				if(x == y){
					compareResult = true;
					break;
				}
			}
		}
		return compareResult;
	}
	public void display(){//display user answer
		for(int i = 0 ; i < userAnswers.size();i++){
			System.out.println(userAnswers.get(i));
		}
	}
}

import java.io.Serializable;
import java.util.Vector;
public abstract class Question implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	String prompt;
	IO io = new IO();
	
	//This is an abstract class so most of its function i overwrote it
	
	public Question(){ 
	
	}
	public Question(String question){
		prompt = question;
	}
	public void setQuestion(String question) {
		prompt = question;
	}
	public String getQuestion(){
		return prompt;
	}
	public abstract void display();
	public abstract UserAnswer getCorrectAnswer();
	public abstract void setuserAnswer();
	public abstract Vector<UserAnswer> getUserAnswer();
	public abstract void modify();
	
}

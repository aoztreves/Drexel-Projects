import java.io.Serializable;


public class ShortAnswer extends Essay implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	public ShortAnswer(){
		
	}
	public ShortAnswer(String question){
		super.setQuestion(question); 
	}
	public UserAnswer getuserAnswer(){ //Validating that its a short answer and getting the answer
		UserAnswer ua = new UserAnswer();
		while(true){
			System.out.println("Enter your answer");
			String q = io.getQuestion();
			if(q.length()>20){
				System.out.println("This is not a short answer");
			}
			else{
				ua.setuserAnswer(q);
				break;
			}
		}
		return ua;
	}
	public void setuserAnswer(){ //setting the answer
		UserAnswer ua = new UserAnswer();
		userAnswer.add(ua);
	}

}

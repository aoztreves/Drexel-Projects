import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.Serializable;
import java.util.Collection;
import java.util.HashMap;
import java.util.InputMismatchException;
import java.util.Scanner;
import java.util.Vector;

public class Test extends Survey implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	Vector<UserAnswer> correctAnswer;//correct answer
	int testie; // This is for later when we need to keep track of people taken the test
	public Test(){
		correctAnswer = new Vector<UserAnswer>();
		testie=0;
	}
	public void setCorrectAnswer(UserAnswer ua){
		correctAnswer.add(ua);
	}
	public Vector<UserAnswer> getCorrectAnswer(){
		return correctAnswer;
	}
	public int getTestie(){
		return testie;
	}
	public Test load(String fileName) throws FileNotFoundException, IOException, ClassNotFoundException{
		fileName = System.getProperty("user.dir") + "/SFiles/TestFiles/" + fileName;
		ObjectInputStream objectInputStream = new ObjectInputStream(new FileInputStream(fileName));
		
		return (Test) objectInputStream.readObject();
		//load is different because needs to return test / Deserializing 
	}
	//Test class uses Surveys save becuase its a subclass of Survey
	public void setQA(){ //Same as Survey
		Scanner scan = new Scanner(System.in);
		int selection;
		UserAnswer ua;
		Vector<String> options;
		String question = "";
		System.out.println("How many questions do you want in the survey, max 6");
		int counter=0;
		nofQuestions = io.isNumber(6);
		while(counter < nofQuestions){
			counter++;
			System.out.println("Menu 3:");
			System.out.println("1) Add a new T/F question");
			System.out.println("2) Add a new multiple choice question");
			System.out.println("3) Add a new short answer question");
			System.out.println("4) Add a new essay question");
			System.out.println("5) Add a new ranking question");
			System.out.println("6) Add a new matching question");
			
			selection = io.isNumber(6);
			
			switch(selection){ // getting question and then the correct answer for that question
				case 1:
					System.out.println("Enter the prompt for your True/False question:");
					question = io.getQuestion();
					TrueFalse tf = new TrueFalse(question);
					QA.add(tf);
					
					ua = tf.getAnswerforTF();
					correctAnswer.add(ua);
					break;
				case 2:
					System.out.println("Enter the prompt for your MC question:");
					question = io.getQuestion();
					MultipleChoice mc = new MultipleChoice(question);
					QA.add(mc);
					ua = mc.getCorrectAnswer();
					correctAnswer.addElement(ua);
					break;
				case 3:
					System.out.println("Enter the prompt for your short answer question:");
					question = io.getQuestion();
					ShortAnswer sa = new ShortAnswer(question);
					QA.add(sa);
					
					ua= sa.getCorrectAnswer();
					correctAnswer.add(ua);
					break;
				case 4:
					System.out.println("Enter the prompt for your Essay question:");
					question = io.getQuestion();
					Essay essay = new Essay(question);
					QA.add(essay);
					
					ua = essay.getCorrectAnswer();
					correctAnswer.add(ua);
					break;
				case 5:
					System.out.println("Enter the prompt for your Ranking question:");
					question = io.getQuestion();
					Ranking rank = new Ranking(question);
					QA.add(rank);
					
					ua = rank.getCorrectAnswer();
					correctAnswer.add(ua);
					break;
				case 6:
					System.out.println("Enter the prompt for your Matching question:");
					question = io.getQuestion();
					//Matching match = new Matching(question);
					//QA.add(match);
					//ua = match.getCorrectAnswer();
					//correctAnswer.add(ua);
					break;
				default:
			}
		}
	
	}

}

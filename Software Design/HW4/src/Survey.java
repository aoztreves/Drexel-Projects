import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.Serializable;
import java.util.Scanner;
import java.util.Vector;

public class Survey implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	Vector<Question> QA; //Questions saved here
	IO io;
	int nofQuestions;
	
	public Survey(){
		QA = new Vector<Question>();
		io = new IO();
		nofQuestions=0;
	}
	public void take(){
		for(int i=0;i<QA.size();i++){
			System.out.print(i+1 + " )");
			QA.get(i).display("no");
			QA.get(i).setuserAnswer();
		}
	}
	public void modify(){
		for(int i=0;i<QA.size();i++){
			System.out.println(i+1 + " )" + QA.get(i).prompt);
		}
		System.out.println("Which question do you want to modify(yes/no)");
		int x = io.isNumber(6);
		QA.get(x-1).modify();
	}
	public void save(String fileName,String type) throws IOException{ //Serialization
		String path = System.getProperty("user.dir")+"/SFiles/"+ type + "/" + fileName;
		ObjectOutputStream objectOutputStream = new ObjectOutputStream(new FileOutputStream(path)); //Got this online from a lady in youtube.
		
		objectOutputStream.writeObject(this);

	}
	public Survey load(String fileName) throws FileNotFoundException, IOException, ClassNotFoundException{ //desiralizing
		fileName = System.getProperty("user.dir") + "/SFiles/SurveyFiles/" + fileName;
		ObjectInputStream objectInputStream = new ObjectInputStream(new FileInputStream(fileName));//Got this online from a lady in youtube.
		
		return (Survey) objectInputStream.readObject();
		//This class is survey specific because it returns a survey.
	}
	public Vector<Question> getQA(){
		return QA;
	}
	public void setQA(){ //Getting Questions
		Scanner scan = new Scanner(System.in);
		int selection;
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
			
			switch(selection){ //Setting questions and making use of classes that is requested from the menu3
				case 1:
					System.out.println("Enter the prompt for your True/False question:");
					question = io.getQuestion();
					TrueFalse tf = new TrueFalse(question);
					QA.add(tf);
					break;
				case 2:
					System.out.println("Enter the prompt for your MC question:");
					question = io.getQuestion();
					MultipleChoice mc = new MultipleChoice(question);
					QA.add(mc);
					break;
				case 3:
					System.out.println("Enter the prompt for your short answer question:");
					question = io.getQuestion();
					ShortAnswer sa = new ShortAnswer(question);
					QA.add(sa);
					break;
				case 4:
					System.out.println("Enter the prompt for your Essay question:");
					question = io.getQuestion();
					Essay essay = new Essay(question);
					QA.add(essay);
					break;
				case 5:
					System.out.println("Enter the prompt for your Ranking question:");
					question = io.getQuestion();
					Ranking rank = new Ranking(question);
					QA.add(rank);
					break;
				case 6:
					System.out.println("Enter the prompt for your Matching question:");
					question = io.getQuestion();
					Matching match = new Matching(question);
					QA.add(match);
					break;
				default:
			}
		}
		
		
		
		
		
	}

}

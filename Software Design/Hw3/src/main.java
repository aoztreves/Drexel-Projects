import java.io.File;
import java.io.IOException;
import java.util.Vector;

public class main {

	public static void main(String[] args) throws IOException, ClassNotFoundException {
		Vector<String> TestFiles = new Vector<String>();//Saving test files here
		Vector<String> SurveyFiles = new Vector<String>(); //Saving survey files here
		
		String path = System.getProperty("user.dir"); // getting user specific path
		File test = new File(path + "/SFiles/TestFiles");
		File[] listofTests = test.listFiles();
		
		for(int i=0; i < listofTests.length; i++ ){
			TestFiles.add(listofTests[i].getName()); // adding all test files created previously
		}
		File survey = new File(path + "/SFiles/SurveyFiles");
		File[] listofSurvey = survey.listFiles();
		
		for(int i=0; i < listofSurvey.length; i++ ){
			SurveyFiles.add(listofSurvey[i].getName());// adding all survey files created previously
		}
		
		//First menu
		System.out.println("Menu 1:");
		System.out.println("1) Survey");
		System.out.println("2) Test");
		
		int selection; 
		IO io = new IO();
		selection=io.isNumber(2); // validating
		
		if(selection == 1){ //Survey
			//while(selection != 5){
			Survey survey1 = new Survey();
			System.out.println("Survey Menu 2:");//Menu 2
			System.out.println("1) Create a new Survey");
			System.out.println("2) Display a Survey");
			System.out.println("3) Load a Survey");
			System.out.println("4) Save a Survey");
			System.out.println("5) Modify a Survey");
			System.out.println("6) Take a Survey");
			System.out.println("7) Tabulate a Survey");
			System.out.println("8) Quit"); 
			
			selection=io.isNumber(8);
			while(selection != 8){
				switch(selection){
				case 1: 
					survey1.setQA();//Create survey
					break;
				case 2:
					for(int i=0; i < survey1.QA.size(); i++){ //Display
						System.out.print(i+1 + ") ");
						survey1.QA.get(i).display();
					}
					break;
				case 3: // Load
					for(int i=0; i <SurveyFiles.size();i++){
						System.out.println(i+1 +") "+ SurveyFiles.get(i));
					}
					System.out.println("Choose Which Survey to load");
					int selectedSurvey = io.isNumber(SurveyFiles.size());
					survey1 = survey1.load(SurveyFiles.get(selectedSurvey-1));
					break;
				case 4: // Save 
					System.out.println("What would you like to name this survey?");
					String surveyName = io.getQuestion();
					survey1.save(surveyName,"SurveyFiles");
					SurveyFiles.add(surveyName);
					break;
				case 5:
					System.out.println("Which Survey do you want to modify");
					for(int i=0;i<SurveyFiles.size();i++){
						System.out.println(i+1 + " )"+ SurveyFiles.get(i));
					}
					int x =io.isNumber(SurveyFiles.size());
					
					survey1= survey1.load(SurveyFiles.get(x-1));
					survey1.modify();
					survey1.save(SurveyFiles.get(x-1), "SurveyFiles");
					break;
				case 6:
					System.out.println("Which Survey do you want to take");
					for(int i=0;i<SurveyFiles.size();i++){
						System.out.println(i+1 + " )"+ SurveyFiles.get(i));
					}
					int y =io.isNumber(SurveyFiles.size());
					survey1= survey1.load(SurveyFiles.get(y-1));
					survey1.take();
					int counter=1;
					String pathforSurvey = System.getProperty("user.dir")+"/SFiles/"+ "Survey" + "/" + SurveyFiles.get(y-1);
					File f = new File(pathforSurvey);
					String count = "1";
					while(true){
						if(f.exists()){
							counter++;
						}
						else{
							count = Integer.toString(counter);
							break;
						}
					}
					survey1.save(SurveyFiles.get(y-1)+count, "TakenSurveyFiles");
					break;
								
				default:
				} 
				//Couldnt come up with a loop so 
				System.out.println("Survey Menu 2:");//Menu 2
				System.out.println("1) Create a new Survey");
				System.out.println("2) Display a Survey");
				System.out.println("3) Load a Survey");
				System.out.println("4) Save a Survey");
				System.out.println("5) Modify a Survey");
				System.out.println("6) Take a Survey");
				System.out.println("7) Tabulate a Survey");
				System.out.println("8) Quit");
				selection  = io.isNumber(8);
			}
		}
		else if(selection == 2){ //Test
			Test test1 = new Test();
			System.out.println("Test Menu 2:");
			System.out.println("1) Create a new Test");
			System.out.println("2) Display a Test");
			System.out.println("3) Load a Test");
			System.out.println("4) Save a Test");
			System.out.println("5) Modify a Test");
			System.out.println("6) Take a Test");
			System.out.println("7) Tabulate a Test");
			System.out.println("8) Grade a Test");		
			System.out.println("9) Quit"); 
			
			selection=io.isNumber(9);
			while(selection != 9){
				switch(selection){
				case 1: //Create
					test1.setQA();
					break;
				case 2://Display
					for(int i=0; i < test1.QA.size(); i++){
						System.out.print(i+1 + ") ");
						test1.QA.get(i).display(); //Display question
						
						//System.out.println("hey hey");
						
						Vector<String> choices =test1.getCorrectAnswer().get(i).getuserAnswers();
						if(choices.get(0) != ""){
							System.out.print("Correct Answer -> "); // Display correct answer
						}
						
						for(int a = 0; a <choices.size();a++){
							System.out.print(choices.get(a) + " ");
						}
						System.out.println("");//Looks cooler with this
					}
					break;
				case 3://load
					for(int i=0; i <TestFiles.size();i++){//getting all files in the folder
						System.out.println(i+1 +") "+ TestFiles.get(i));
					}
					System.out.println("Choose Which Test to load"); // Selecting one 
					int selectedTest = io.isNumber(TestFiles.size());
					test1 = test1.load(TestFiles.get(selectedTest-1));
					break;
				case 4://save
					System.out.println("What would you like to name this Test?"); 
					String testName = io.getQuestion();
					test1.save(testName, "TestFiles");
					TestFiles.add(testName);
				case 5:
					System.out.println("Which Test do you want to modify");
					for(int i=0;i<TestFiles.size();i++){
						System.out.println(i+1 + " )"+ TestFiles.get(i));
					}
					int x =io.isNumber(TestFiles.size());
					
					test1= test1.load(TestFiles.get(x-1));
					test1.modify();
					test1.save(TestFiles.get(x-1), "TestFiles");
					break;
					
				case 6:
					System.out.println("Which Test do you want to take");
					for(int i=0;i<TestFiles.size();i++){
						System.out.println(i+1 + " )"+ TestFiles.get(i));
					}
					int y =io.isNumber(TestFiles.size());
					
					test1= test1.load(TestFiles.get(y-1));
					test1.take();
					int counter=1;
					String pathforTest = System.getProperty("user.dir")+"/SFiles/"+ "Test" + "/" + TestFiles.get(y-1);
					File f = new File(pathforTest);
					String count = "1";
					while(true){
						if(f.exists()){
							counter++;
						}
						else{
							count = Integer.toString(counter);
							break;
						}
					}
					
					test1.save(TestFiles.get(y-1)+count, "TakenTestFiles");
					System.out.println("Would you like to grade this test");
					String gt = io.getQuestion();
					if((gt.equals("yes")) ||(gt.equals("Yes"))){
						int yourGrade = test1.grade(test1.getTestie());
						System.out.println("Your grade for your test is " + yourGrade + " / " + test1.nofQuestions*10);
						break;
					}
					break;
				case 7:
					//TODO:Tabulate
					break;
				case 8:
					if(test1.getTestie() == 0){
						System.out.println("First you need to take a test");
						break;
					}
					else{
						System.out.println("Which testie would you like to grade, please choose from testie1 to testie" + test1.getTestie());
						int yourGrade = test1.grade(io.isNumber(test1.getTestie()));
						System.out.println("Your grade for your test is " + yourGrade + " / " + test1.nofQuestions*10);
						break;
					}
				default:
				}
				System.out.println("Test Menu 2:");
				System.out.println("1) Create a new Test");
				System.out.println("2) Display a Test");
				System.out.println("3) Load a Test");
				System.out.println("4) Save a Test");
				System.out.println("5) Modify a Test");
				System.out.println("6) Take a Test");
				System.out.println("7) Tabulate a Test");
				System.out.println("8) Grade a Test");		
				System.out.println("9) Quit"); 
				
				selection=io.isNumber(9);
			}
					
			
		}

		
	}

}

/*
	
	Calculator.java
	Aslan Oztreves
	21/11/2016

	Purpose:This programs purpose is to calculate equations from a file and print the
	results

	platform info :javac 1.6.0, on Linux version 2.6.18.6 (gcc version 3.4.6
						(Gentoo3.4.6-r1, ssp-3.4.5-1.0, pie-8.7.9))

*/



import java.util.*;
import java.io.*;
import java.io.File;
import java.io.FileReader;
import java.io.BufferedReader;
import java.util.Stack;
import java.util.Arrays;
import java.lang.Object;
public class Calculator  
{
	public static void main( String[] args )
	{
		//Initiating VAriables
		String fileName = "input.infix";
		int result =0;
		BufferedReader br = null;
		String equation = "";
		String strLine = "";
		List<Token> list = new ArrayList<Token>(100);
		ArrayList<Integer> numbers = new ArrayList<Integer>();
		
		try 
		{
			//reading through file line by line
			br = new BufferedReader( new FileReader(fileName));
			while( (strLine = br.readLine()) != null)
			{	
				if(strLine.indexOf("(") >= 0)//(strLine.contains("(") ==true || strLine.contains(" ( ") ==	true)
				{//if line contains paranthesis then this code will execute
					numbers.clear();
					paranthesis(strLine,list,numbers,result,equation);
					System.out.print(strLine);
					System.out.print(" = ");
					System.out.println(numbers.get(0));
					//System.out.println(equation);
				}
				else
				{//else this code will be executed depending on the paranthesis situation
					numbers.clear();
					//operatorss.clear();
					infix2postfix(strLine,list,numbers,result);		
					System.out.print(strLine);
					System.out.print(" = ");
					System.out.println(numbers.get(0));
					//System.out.println("hry");
				}	
			}
		}
	  //throwing exceptions in case i cant read a file	
		catch (FileNotFoundException e) 
		{
			System.err.println("Unable to find the	file: fileName");
			}
			catch (IOException e) 
			{
				System.err.println("Unable to read the file:fileName");
			}
		}
	//if there is paranthesis inside the code, this will get inside of the
	//paranthesisi and calculate it then puts the answer back where the
	//initial paranthesis was.
	static public int paranthesis(String strLine,List<Token>
			         list,ArrayList<Integer> numbers,int result,String equation)
	{
		while(strLine.indexOf("(") >= 0)//strLine.contains("(") == true || strLine.contains(" ( ") == true)
		{
			//TODO:call function for inception paratnthesis
			
			String insidep =strLine.substring(strLine.indexOf("(") + 1);
			insidep =strLine.substring(1,strLine.indexOf(")"));
			insidep=insidep.substring(1);
				
			if(strLine.indexOf("(") >= -1)
			{
				infix2postfix(insidep,list,numbers,result);
			}
			//paranthesis(strLine,list,numbers,result,equation);
			int inparan = numbers.get(0);
			
			//seperating string into pieces
			String bparan = strLine.substring(0,strLine.indexOf('('));	
			String aparan = strLine.substring(strLine.lastIndexOf(')')+1);
			equation = (bparan + inparan + aparan);
			
			//System.out.println(equation);
			numbers.clear();
			strLine = equation;
			//System.out.println(strLine);
			
			//Incase there is another paranthesis inside the paranthesis
			//portion of the equation
			if(strLine.indexOf("(") >= -1)//strLine.contains("(") != true || strLine.contains(" ( ") != true)
			{
				infix2postfix(equation,list,numbers,result);	
			}	
		}
		return 0;
	}
	//Main calculations happen here, this is where i push the the operators
	//and operands to their list of tokens so that i can use the methods of
	//other class later on.
	static public int infix2postfix(String strLine,List<Token>
			list,ArrayList<Integer> numbers,int result)
	{
		//System.out.println(strLine);
		int[] listofnumbers = new int[100];
		String[] listofoperators = new String[100];

		String[] parts = strLine.split(" ");
		String equation = "";
		for(int n = 0; n < parts.length; n++)
		{		
			/*if(parts[n].equals("(")== true)
			{
				paranthesis(strLine,list,numbers,result,equation);
			}*/
			if(parts[n].equals("+")== true)
			{	
				Operator o = new Operator(opType.ADD);
				list.add(o);
			}
			else if(parts[n].equals("-")==true)
			{
				Operator o = new Operator(opType.SUB);
				list.add(o);
			}
			else if(parts[n].equals("*")==true)
			{
				Operator o = new Operator(opType.MULT);
				list.add(o);	
			}
			else if(parts[n].equals("/") ==true)
			{
				Operator o = new Operator(opType.DIV);
				list.add(o);
			}
			else if(parts[n].equals("%") ==true)
			{
				Operator o = new Operator(opType.MOD);
				list.add(o);
			}
			else
			{
				int number = Integer.parseInt(parts[n]);
				Operand a = new Operand(number);
				list.add(a);
			}			
		}
		Token t = new Operator(opType.SUB);
		Token u = new Operand(24);
		//ArrayList<Integer> numbers = new ArrayList<Integer>();
		ArrayList<String> operatorss = new ArrayList<String>();

		while( ! list.isEmpty())
		{
			t =list.remove(0);
			
			//This while loop helps me get 2 different arraylist which fills it
			//up the operands with 2 numbers and operator one with one
			if ( ! t.isOperator())
			{
				int operand = Integer.parseInt(String.valueOf(((Operand)t).getVal()));	
				numbers.add(operand);
				//System.out.println(numbers);
			}
			else
			{
				Operator op = (Operator)t;
				if(op.getVal() == opType.ADD)
				{
					operatorss.add(op.getVal().getName());
				}
				else if(op.getVal() == opType.SUB)
				{
					operatorss.add(op.getVal().getName());	
				}
				else if(op.getVal() == opType.MULT)
				{
					operatorss.add(op.getVal().getName());
				}
				else if(op.getVal() == opType.DIV)
				{
					operatorss.add(op.getVal().getName());
				}
				else if(op.getVal() == opType.MOD)
				{
					operatorss.add(op.getVal().getName());
				}
			}
			int size1 = numbers.size();
			int size2 = operatorss.size();
			
			//when enough entities calculate the result
			if((size1 == 2) && (size2 ==1)){
				evalPostfix(numbers,operatorss,result);
			}
		}				
		return 0;
	}
	//this function evaluates the equation and gives a result back
	static public int evalPostfix(ArrayList<Integer> numbers, ArrayList<String> operatorss, int result)
	{
		int number1 = numbers.get(0);
		int number2 = numbers.get(1);
		if(operatorss.get(0) == "Add")
		{
			result = (number1 + number2);	
		}
		else if(operatorss.get(0) == "Sub")
		{
			result = (number1 - number2);;
		}
		else if(operatorss.get(0) == "Mult")
		{
			result = (number1 * number2);
		}
		else if(operatorss.get(0) == "Div")
		{
			result = (number1 / number2);
		}
		else if(operatorss.get(0) == "Mod")
		{
			result = (number1 % number2);
		}
		//System.out.println(result);
		numbers.clear();
		operatorss.clear();
		numbers.add(result);
	//	System.out.println(numbers);
		return 0;
	}
}


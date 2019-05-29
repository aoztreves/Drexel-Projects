/*
	
	Aslan Oztreves
	Lists: array implementation of operations:
	FIRST, END, RETRIEVE, LOCATE, NEXT, PREVIOUS, INSERT, DELETE, MAKENULL
	PROGRAMMING ASSIGNMENT 1
	02/17/2017

*/
#ifndef arraylist_hpp
#define arraylist_hpp
#include <stdio.h>

class List
{
	private:
		int array[1000000];
		int eofL;
	public:
		List();
		int FIRST();
		int END();
    	int RETRIEVE(int);
    	int LOCATE(int);
    	int NEXT(int);
    	int PREVIOUS(int);
    	void INSERT(int,int);
    	void DELETE(int);
    	void MAKENULL();
		
};
#endif 

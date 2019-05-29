/*
	
	Aslan Oztreves
	Stacks: array implementation of operations:
	TOP, POP, PUSH, EMPTY, MAKENULL,
	PROGRAMMING ASSIGNMENT 1
	02/17/2017

*/
#ifndef arraystack_h
#define arraystack_h

class Stack
{
private:
	int array[100000];
	int tpos;
public:
	Stack();
	int TOP();
	int POP();
	void PUSH(int);
	bool EMPTY();
	void MAKENULL();
};

#endif

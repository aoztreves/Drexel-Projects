/*
	
	Aslan Oztreves
	Stacks: pointer implementation of operations:
	TOP, POP, PUSH, EMPTY, MAKENULL,
	PROGRAMMING ASSIGNMENT 1
	02/17/2017

*/
#ifndef pointerstack_h
#define pointerstack_h
#include "node.h"
#include <stdio.h>
class pStack{
private:
	nnode hnode;
public:
	pStack();
	int TOP();
	int POP();
	void PUSH(int);
	bool EMPTY();
	void MAKENULL();
};
#endif

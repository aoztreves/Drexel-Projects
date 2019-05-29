/*
	
	Aslan Oztreves
	Stacks: array implementation of operations:
	TOP, POP, PUSH, EMPTY, MAKENULL,
	PROGRAMMING ASSIGNMENT 1
	02/17/2017

*/
#include "arraystack.h"
#include <iostream>
using namespace std;

Stack::Stack(){
	tpos = -1;//Initialize top position
}
int Stack::TOP(){
	return array[tpos];// return first element in the stack
}
int Stack::POP(){
	if(tpos == -1){
		cout<<"Stack is empty"<<endl;
		return 0;
	}
	return array[tpos--];//delete the top element
}
void Stack::PUSH(int x){
    array[tpos+1] = x;//making the new input equal to the top of the stack
    tpos++;
}
bool Stack::EMPTY(){
	if(tpos == -1){//stack is empty
		return true;
	}
	else {
		return false;
	}
}
void Stack::MAKENULL(){
	while(tpos!= -1){
		POP();
	}
}

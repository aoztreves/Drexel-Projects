/*
	
	Aslan Oztreves
	Stacks: pointer implementation of operations:
	TOP, POP, PUSH, EMPTY, MAKENULL,
	PROGRAMMING ASSIGNMENT 1
	02/17/2017

*/

#include "pointerstack.h"
#include <iostream>
#include <cstdlib>
using namespace std;

pStack::pStack(){
	hnode = new node();//Create a header node
	hnode->next=NULL;//initialize to null
}
int pStack::TOP(){
    nnode tempnnode = hnode;
	while(hnode->next!=NULL){//looping through stack until top
		hnode = hnode->next;
	}
    int beforetemp = hnode->element;
    hnode=tempnnode;
	return beforetemp;//return the element
   
}
int pStack::POP(){
    nnode tempnnode = hnode;
	
	while(hnode->next->next!=NULL){//check if the stack is gonna be empty
		hnode = hnode->next;
	}
    int pop = hnode->next->element;//finding the popping element
	hnode->next = NULL;//will delete the element, no need to downsize stack.
    hnode=tempnnode;
	return pop;
}
void pStack::PUSH(int x){
    nnode tempnnode = hnode;
	nnode newnode = new node();//creating new one
	newnode->element=x;//equall to the element we are pushing
	newnode->next=NULL;
	while(!EMPTY()){//when its not empty
		hnode= hnode->next;
	}
	hnode->next=newnode;
    hnode=tempnnode;

}
bool pStack::EMPTY(){
	if(hnode->next == NULL){//no element in stack
		return true;
	}
	else{
		return false;
	}
}
void pStack::MAKENULL(){
	while(!EMPTY()){
		POP();//will pop until stack is empty
	}
}

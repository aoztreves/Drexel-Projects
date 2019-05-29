/*
	
	Aslan Oztreves
	Lists: pointer implementation of operations:
	FIRST, END, RETRIEVE, LOCATE, NEXT, PREVIOUS, INSERT, DELETE, MAKENULL
	PROGRAMMING ASSIGNMENT 1
	02/17/2017

*/

#include <stdio.h>
#include <iostream>
#include "pointerlist.h"
using namespace std;

Pointer::Pointer(){
	hnode = new node();
	hnode->next=NULL;
	hnode->element=0;
}
int Pointer::FIRST(){
	if((hnode->next) != NULL){ return 1; }
	else{ return 0;}
}
int Pointer::END(){
	nnode tempnnode = hnode;
	int eofl=0;
	while((hnode!=NULL)){
		hnode=hnode->next;//it will iterate
		eofl++;
	}
	hnode=tempnnode;
	return eofl;
}
int Pointer::RETRIEVE(int pos1){
    nnode tempnnode = hnode;
    int i=0;
    while(i < pos1){
        hnode=hnode->next;
        i++;
    }
    int result = (hnode->element);
    hnode=tempnnode;
    return result;

}
int Pointer::LOCATE(int x){
	int location=1;
	nnode tempnnode = hnode;
    hnode=hnode->next;
	while((hnode!=NULL)&&(x!=hnode->element)){//looping
		hnode=hnode->next;
		location++;//location of the element
	}
	if(hnode!=NULL){//doesnt go all the way
		hnode=tempnnode;
        return location;
    }
	hnode=tempnnode;
	return END();//final location
}
int Pointer::NEXT(int pos2){
	if(pos2 > 0 && pos2 < END()) { return (pos2 + 1); }//return position + 1 for the next pos
	else{ return -1; }//mistake
}
int Pointer::PREVIOUS(int pos3){
	if(pos3 > 0 && pos3 < END()) { return (pos3 - 1); }//return position - 1 for the previous pos
	else{return -1;}//mistake
}
void Pointer::INSERT(int pos4,int x){
	nnode newnode = new node();//temporary node
	nnode tempnnode = hnode;
	if( pos4 > END() || pos4 < FIRST()){//Should be inside boundries 
		cout<<"WRONG"<<endl;
	}
	else{
		int i=0;
		while(i < pos4-1){
			hnode=hnode->next;//go to the position
			i++;
		}
        newnode->element=x;
		newnode->next = hnode->next;//moving
		hnode->next=newnode;
		hnode=tempnnode;
	}
}
void Pointer::DELETE(int pos5){
	nnode tempnnode = hnode;
	if( pos5 > END() || pos5 < FIRST()){//Should be inside boundries 
		cout<<"WRONG"<<endl;
	}
	else{
		int i=0;
		while(i != pos5){
			hnode=hnode->next;//go to the position
			i++;
		}
		nnode newnode= new node();//for deleting
		newnode=hnode->next;
		hnode->next=hnode->next->next;//moving the next to 2 nexts
		delete newnode;//deleting the pos5 
	}
	hnode=tempnnode;
}
void Pointer::MAKENULL(){
	/*int temppos=1;
	while(FIRST() != END()){
		DELETE(temppos);
		temppos++;
	}
    hnode=NULL; will delete more
    *///Creates memory leak because there are previously deleted position
    hnode->next=NULL;
}












/*
	
	Aslan Oztreves
	Lists: array implementation of operations:
	FIRST, END, RETRIEVE, LOCATE, NEXT, PREVIOUS, INSERT, DELETE, MAKENULL
	PROGRAMMING ASSIGNMENT 1
	02/17/2017

*/
#include <iostream>
#include <cstdlib>
#include "arraylist.h"
using namespace std;

List::List(){
	eofL = 0;//Initizalize end of list
}
int List::FIRST(){
	if(array[0] != 0){ return 0; }
	else{ return 0; }
}
int List::END(){
	return eofL;
}
int List::RETRIEVE(int pos1){
	/*Retrieve the item at position 
	pos of a list into dataItem, if 
	1 <= pos <= ListLength()
	*/
	if((pos1 < FIRST()) || (pos1 > END())){
		return -1;//mistake 
	}
	return array[pos1];//return position in that array
	
}
int List::LOCATE(int pos2){
	for(int i=0; i < END();i++){
		if(array[i] == pos2){//when we first encounter the position
			return i;//return position
		}
	}
	return END();//return end
}
int List::NEXT(int pos3){
	if(pos3 >= 0 && pos3 < END()) { return (pos3 + 1); }//return position + 1 for the next pos
	else{ return -1; }//mistake
}
int List::PREVIOUS(int pos4){
	if(pos4 > 0 && pos4 <= END()) { return (pos4 - 1); }//return position - 1 for the previous pos
	else{return -1;}
}
void List::INSERT(int pos5,int x){
	if( pos5 > END() || pos5 < FIRST()){//Should be inside boundries 
		cout<<"WRONG"<<endl;
	}
	else{
		for(int i = eofL; i > pos5; i--){
			array[i]=array[i-1];//pushing everything by one to get space for insert
		}
		array[pos5] = x;//INSERT
		eofL++;
	}
}
void List::DELETE(int pos6){

	
	for(int i = pos6; i < eofL ; i++){//For loopingh after the position
		array[i] = array[i+1];//moving every element one less. like a[3] is not equal to a[4]
	}
	eofL--;//decrementing the size so we dont have empty location.

}
void List::MAKENULL(){
	int i = END();//From the end of the list
	while(i != FIRST()){//till the first
		DELETE(i);//using my implementation of delete
		i--;//one less
	}
}

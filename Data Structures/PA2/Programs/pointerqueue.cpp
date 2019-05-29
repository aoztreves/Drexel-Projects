/*
	
	Aslan Oztreves
	Queues: one implementation, pointer 
    Operations: FRONT, ENQUEUE, DEQUEUE, EMPTY, MAKENULL,
	PROGRAMMING ASSIGNMENT 2
	03/03/2017

*/

#include <cstdlib>
#include <iostream>
#include "pointerqueue.h"
using namespace std;

PointerQueue::PointerQueue(){
	hnode = new node();
	hnode->next=NULL;
	hnode->element=0;
}
int PointerQueue::FRONT(){
	nnode tempnode = hnode;
	while(hnode->next != NULL){
		hnode = hnode->next;
	}
	int result = hnode->element;
	hnode = tempnode;
	return result;
}
void PointerQueue::ENQUEUE(int x){
	nnode tempnode = hnode;
	nnode newnode = new node();
	newnode->element = x;
	newnode->next=NULL;
	while(!EMPTY()){
		hnode = hnode->next;
	}
	hnode->next=newnode;
	hnode=tempnode;
}
int PointerQueue::DEQUEUE(){
	nnode tempnode = hnode;
	while(hnode->next->next != NULL){
		hnode = hnode->next;
	}
	int result = hnode->next->element;
	hnode->next=NULL;
	hnode=tempnode;
	return result;
}
bool PointerQueue::EMPTY(){
	if(hnode->next == NULL){
		return true;
	}
	else{
		return false;
	}
}
void PointerQueue::MAKENULL(){
	while(!EMPTY()){
		DEQUEUE();
	}
}
void PointerQueue::pointerqueueTest(){
    cout << "This is the test for pointerqueue"<<endl;
    
    PointerQueue pq;
    for(int i=0;i<5;i++){
        pq.ENQUEUE(i*2);
    }
    cout << "I plugged in couple values inside my queue after my enqueue function"<<endl;
    cout << "First one on the queue is: (should be 8) = " << pq.FRONT() << endl;
    pq.DEQUEUE();
    cout << "After dequeue the next first value is: (should be 6) = " << pq.FRONT() << endl;
    cout << "Checking if the queue is empty : (shouldnt be so 0) = " << pq.EMPTY() << endl;
    pq.MAKENULL();
    cout << "After making it to null the empty function is : (should be 1) = " << pq.EMPTY() << endl;
    cout << "END OF TEST"<<endl;
    
}

/*
	
	Aslan Oztreves
	Queues: one implementation, pointer 
    Operations: FRONT, ENQUEUE, DEQUEUE, EMPTY, MAKENULL,
	PROGRAMMING ASSIGNMENT 2
	03/03/2017

*/

#ifndef pointerQueue_h
#define pointerQueue_h
#include "node.h"

class PointerQueue
{
private:
    nnode hnode;
public:

    PointerQueue();
    int FRONT();
    void ENQUEUE(int);
    int DEQUEUE();
    bool EMPTY();
    void MAKENULL();
    void pointerqueueTest();
};



#endif

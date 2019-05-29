/*
	
	Aslan Oztreves
	Lists: pointer implementation of operations:
	FIRST, END, RETRIEVE, LOCATE, NEXT, PREVIOUS, INSERT, DELETE, MAKENULL
	PROGRAMMING ASSIGNMENT 1
	02/17/2017

*/

#ifndef pointerList_h
#define pointerList_h
#include "node.h"

class Pointer
{
private:
    nnode hnode;
public:

    Pointer();
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

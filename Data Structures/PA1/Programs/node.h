/*
	
	Aslan Oztreves
	Creating node file
	PROGRAMMING ASSIGNMENT 1
	02/17/2017

*/

#ifndef node_h
#define node_h

typedef struct node *nnode;
struct node
{
    int element;
    nnode next;
};
#endif /* node_h */

/*
	
	Aslan Oztreves
	Creating node file
	PROGRAMMING ASSIGNMENT 2
	03/03/2017

*/

#ifndef node_h
#define node_h

typedef struct node *nnode;
struct node
{
    int element;
    nnode next;
    nnode hnode;
};
#endif /* node_h */

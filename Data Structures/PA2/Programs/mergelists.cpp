/*
	
	Aslan Oztreves
	Lists: array implementation of operations:
	FIRST, END, RETRIEVE, LOCATE, NEXT, PREVIOUS, INSERT, DELETE, MAKENULL
	PROGRAMMING ASSIGNMENT 1
	02/17/2017
 
 */
#include <iostream>
#include <cstdlib>
#include "mergelists.h"
//#include "arraylist.h"
#include "pointerlist.h"
using namespace std;

sortedList::sortedList(){
}
void sortedList::nSortedList(){
    
    Pointer al = Pointer();
    al.MAKENULL();
    Pointer al2 = Pointer();
    al2.MAKENULL();
    Pointer al3 = Pointer();
    al3.MAKENULL();
    Pointer al4 = Pointer();
    al4.MAKENULL();
    Pointer al5 = Pointer();
    al5.MAKENULL();

    al.INSERT(1, 2);
    al.INSERT(2, 3);
    al.INSERT(3, 4);
    al.INSERT(4, 5);
    al.INSERT(5, 6);
    
    al2.INSERT(1, 12);
    al2.INSERT(2, 13);
    al2.INSERT(3, 14);
    al2.INSERT(4, 15);
    al2.INSERT(5, 17);
    
    al3.INSERT(1, 16);
    al3.INSERT(2, 18);
    al3.INSERT(3, 19);
    al3.INSERT(4, 20);
    al3.INSERT(5, 22);
    
    al4.INSERT(1, 21);
    al4.INSERT(2, 23);
    al4.INSERT(3, 24);
    al4.INSERT(4, 25);
    al4.INSERT(5, 26);
    
    for(int j=1;j<6;j++){
        cout << al.RETRIEVE(j) << " ";
    }
    cout << endl;
    for(int i=1;i<6;i++){
        cout << al2.RETRIEVE(i) << " ";
    }
    cout << endl;
    for(int u=1;u<6;u++){
        cout << al3.RETRIEVE(u) << " ";
    }
    cout << endl;
    for(int k=1;k<6;k++){
        cout << al4.RETRIEVE(k) << " ";
    }
    cout << endl;
    int FULLSIZE = al.END()+al2.END()+al3.END()+al4.END()-4;
    int counter = 0;
    //cout << FULLSIZE << endl;
    int min =0;
    
    while(counter != FULLSIZE){
        if(al.RETRIEVE(1) <= al2.RETRIEVE(1) && al.RETRIEVE(1) <=al3.RETRIEVE(1) && al.RETRIEVE(1) <= al4.RETRIEVE(1)){
            min = al.RETRIEVE(1);
            al5.INSERT(counter+1,min);
            al.DELETE(1);
            counter = counter +1;
        }
        else if (al2.RETRIEVE(1) <= al.RETRIEVE(1) && al2.RETRIEVE(1) <= al3.RETRIEVE(1) && al2.RETRIEVE(1) <= al4.RETRIEVE(1)){
            min = al2.RETRIEVE(1);
            al5.INSERT(counter+1,min);
            al2.DELETE(1);
            counter = counter +1;        }
        else if (al2.RETRIEVE(1) <= al.RETRIEVE(1) && al3.RETRIEVE(1) <= al2.RETRIEVE(1) && al3.RETRIEVE(1) <= al4.RETRIEVE(1)){
            min = al3.RETRIEVE(1);
            al5.INSERT(counter+1,min);
            al3.DELETE(1);
            counter = counter +1;        }
        else if (al4.RETRIEVE(1) <= al.RETRIEVE(1) && al4.RETRIEVE(1) <= al2.RETRIEVE(1) && al4.RETRIEVE(1) <= al3.RETRIEVE(1)){
            min = al4.RETRIEVE(1);
            al5.INSERT(counter+1,min);
            al4.DELETE(1);
            counter = counter +1;
        }
    }
    for(int k=1;k<FULLSIZE+1;k++){
        cout << al5.RETRIEVE(k) << " ";
    }
    cout << endl;
    
    al.MAKENULL();
    al2.MAKENULL();
    al3.MAKENULL();
    al4.MAKENULL();
    al5.MAKENULL();

    
}

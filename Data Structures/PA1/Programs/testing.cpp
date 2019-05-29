/*
	
	Aslan Oztreves
	Timing 
	PROGRAMMING ASSIGNMENT 1
	02/17/2017

*/

#include <iostream>
#include <cstdlib>
#include <iomanip>
#include <ctime>
#include "timing.h"
#include "arraylist.h"
#include "arraystack.h"
#include "pointerlist.h"
#include "pointerstack.h"
#include "testing.h"
#include <assert.h>
using namespace std;

testing::testing(){

}
void testing::testingForArrayList(){
	List arrayList = List();
    cout<<endl<<"TEST FOR ARRAYLISTS: "<<endl;
	for(int i=0;i<10;i++){
		arrayList.INSERT(i,(100*(i+1)));//Insert test
	}
	cout<<"List includes : "<<endl;
	for(int j=0;j<10;j++){
		cout<<arrayList.RETRIEVE(j)<< " ";//retrieve works
	}
    cout<<endl;
    cout<<"first item should be in 0 = "<<arrayList.FIRST() << endl;
   
    cout<<"first item should be in 10 = "<<arrayList.END() << endl;
    
    cout<<"locate 200 should be in index 1 = "<<arrayList.LOCATE(200)<<endl;
   
    cout<<"next of 5 should be 6 = " << arrayList.NEXT(5)<<endl;
    
    cout<<"previous of 5 should be 4 = " << arrayList.PREVIOUS(5)<<endl;
    
    cout<<"delete 500"<<endl;
    arrayList.DELETE(4);
    cout<<"List now includes : "<<endl;
    for(int k=0;k<arrayList.END();k++){
        cout<<arrayList.RETRIEVE(k)<< " ";
    }
    cout<<endl<<"make the list null";
    arrayList.MAKENULL();
    for(int u=0;u<arrayList.END();u++){
        cout<<arrayList.RETRIEVE(u)<< " ";
    }
    cout<<endl;
}
void testing::testingForArrayStack(){
    Stack arrayStack = Stack();
    cout<<endl<<"TEST FOR ARRAYSTACKS: "<<endl;
    for(int i=0;i<10;i++){
        arrayStack.PUSH((100*(i+1)));//push to stack for test
    }
    cout<<"Top item of the stack shoudl 1000 = "<<arrayStack.TOP()<<endl;
    cout<<"Pop the top item so we should pop 1000 = "<<arrayStack.POP()<<endl;
    cout<<"Now the top item should be 900 = "<<arrayStack.TOP()<<endl;
    cout<<"We are gonna check for emptyness, should be false(0) = "<<arrayStack.EMPTY()<<endl;
    cout<<"Now we make the stack makenull ";
    arrayStack.MAKENULL();
    cout<<endl<<"We are gonna check for emptyness, should be true(1) = "<<arrayStack.EMPTY()<<endl;
    
    
    
}
void testing::testingForPointerList(){
    cout<<endl<<"TEST FOR POINTERLISTS: "<<endl;
    Pointer PointerList = Pointer();
    for(int i=1;i<11;i++){
        PointerList.INSERT(i,(100*(i)));//Insert test
    }
    cout<<"List includes : "<<endl;
    for(int j=1;j<11;j++){
        cout<<PointerList.RETRIEVE(j)<< " ";//retrieve works
    }
    cout<<endl;
    cout<<"first item should be in 1 = "<<PointerList.FIRST() << endl;
    
    cout<<"last item should be in 10 = "<<PointerList.END()-1 << endl;
    
    cout<<"locate 200 should be in index 2 = "<<PointerList.LOCATE(200)<<endl;
    
    cout<<"next of 5 should be 6 = " << PointerList.NEXT(5)<<endl;
    
    cout<<"previous of 5 should be 4 = " << PointerList.PREVIOUS(5)<<endl;
    
    cout<<"delete 500"<<endl;
    PointerList.DELETE(4);
    cout<<"List now includes : "<<endl;
    for(int k=0;k<PointerList.END();k++){
        cout<<PointerList.RETRIEVE(k)<< " ";
    }
    cout<<endl<<"make the list null ";
    PointerList.MAKENULL();
    for(int u=0;u<PointerList.END();u++){
        cout<<PointerList.RETRIEVE(u)<< " ";
    }
    cout<<endl;
}
void testing::testingForPointerStack(){
    cout<<endl<<"TEST FOR POINTERSTACK: "<<endl;
    pStack pointerStack = pStack();
    for(int i=0;i<10;i++){
        pointerStack.PUSH((100*(i+1)));//push to stack for test
    }
    cout<<"Top item of the stack shoudl 1000 = "<<pointerStack.TOP()<<endl;
    cout<<"Pop the top item so we should pop 1000 = "<<pointerStack.POP()<<endl;
    cout<<"Now the top item should be 900 = "<<pointerStack.TOP()<<endl;
    cout<<"We are gonna check for emptyness, should be false(0) = "<<pointerStack.EMPTY()<<endl;
    cout<<"Now we make the stack makenull ";
    pointerStack.MAKENULL();
    cout<<endl<<"We are gonna check for emptyness, should be true(1) = "<<pointerStack.EMPTY()<<endl;
    
}








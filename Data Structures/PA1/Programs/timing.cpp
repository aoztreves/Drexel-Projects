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
#include <list>
#include <stack>
using namespace std;

timing::timing(){

}
void timing::timingForArrayList(){
	List arrayList = List();
    //Iterated insertion in front
    cout<< "Timing results for arraylist iteration insertion in front"<<endl;
    cout<<"|  ArraySize  | " << "Result(ms)  |"<<endl;
    clock_t start, stop;
    int arraySize = 0;
    for(int i=1; i < 11;i++){
        arraySize = 1000*i;//finding size of the array
        start = clock();
       for(int k = 1; k<arraySize+1;k++){
            arrayList.INSERT(0,100);//inserting
        }
        stop=clock();
        double timeTaken = (1000* ((double)stop-start)/CLOCKS_PER_SEC);//calculating clock
        cout<<"|  "<<arraySize<<"       | " << fixed << setprecision(4) << timeTaken <<  " milliseconds  |" << endl;
        arrayList.MAKENULL();
    }
    //Iteraded insertion in back
    cout<< "Timing results for arraylist iteration insertion in back"<<endl;
    cout<<"|  Size        | " << "Result(ms)  |"<<endl;
    arraySize=0;
    for(int i=1; i < 11;i++){
        arraySize = 1000*i;//finding size of the array
        start = clock();
        for(int k = 1; k<arraySize+1;k++){
            arrayList.INSERT(arrayList.END(),100);//Insertion at the back
        }
        stop=clock();
        double timeTaken = (1000* ((double)stop-start)/CLOCKS_PER_SEC);
        cout<<"|  "<<arraySize<<"       | " << fixed << setprecision(4) << timeTaken <<  " milliseconds  |" << endl;
        arrayList.MAKENULL();
    }
    //Traversal for locate and retrieve
    cout<< "Timing results for arraylist traversal"<<endl;
    cout<<"|  Size        | " << "Result(ms)  |"<<endl;
    arraySize=0;
    for(int i=1; i < 11;i++){
        arraySize = 1000*i;//finding size of the array
        
        for(int k = 1; k<arraySize+1;k++){
            arrayList.INSERT(0,100*k);//traversal
        }
        start = clock();
        for(int l=1;l<arraySize;l++){
            arrayList.RETRIEVE(100*l);
            arrayList.LOCATE(100*l);
        }
        stop=clock();
        double timeTaken = (1000* ((double)stop-start)/CLOCKS_PER_SEC);
        cout<<"|  "<<arraySize<<"       | " << fixed << setprecision(4) << timeTaken <<  " milliseconds  |" << endl;
        arrayList.MAKENULL();
    }
    //Iteraded deletion in front
    cout<< "Timing results for arraylist iteration deletion in front"<<endl;
    cout<<"|  Size        | " << "Result(ms)  |"<<endl;
    arraySize=0;
    for(int i=1; i < 11;i++){
        arraySize = 1000*i;//finding size of the array
        start = clock();
        for(int o=1; o<arraySize+1;o++){
            arrayList.INSERT(0, 100);
        }
        for(int k = 1; k<arraySize+1;k++){
            arrayList.DELETE(arrayList.FIRST());//Insertion at the back
        }
        stop=clock();
        double timeTaken = (1000* ((double)stop-start)/CLOCKS_PER_SEC);
        cout<<"|  "<<arraySize<<"       | " << fixed << setprecision(4) << timeTaken <<  " milliseconds  |" << endl;
        arrayList.MAKENULL();
    }
    //Iteraded deletion in front
    cout<< "Timing results for arraylist iteration deletion in back"<<endl;
    cout<<"|  Size        | " << "Result(ms)  |"<<endl;
    arraySize=0;
    for(int i=1; i < 11;i++){
        arraySize = 1000*i;//finding size of the array
        start = clock();
        for(int p=1; p<arraySize+1;p++){
            arrayList.INSERT(0, 100);
        }
        for(int k = 1; k<arraySize+1;k++){
            arrayList.DELETE(arrayList.END());//Insertion at the back
        }
        stop=clock();
        double timeTaken = (1000* ((double)stop-start)/CLOCKS_PER_SEC);
        cout<<"|  "<<arraySize<<"       | " << fixed << setprecision(4) << timeTaken <<  " milliseconds  |" << endl;
        arrayList.MAKENULL();
    }
}
void timing::timingForArrayStack(){
    Stack arrayStack = Stack();
    //Iterated insertion in front
    cout<< "Timing results for arraystack iteration insertion"<<endl;
    cout<<"|  Size        | " << "Result(ms)  |"<<endl;
    clock_t start, stop;
    int arraySize = 0;
    for(int i=1; i < 11;i++){
        arraySize = 1000*i;//finding size of the array
        start = clock();
        for(int k = 1; k<arraySize+1;k++){
            arrayStack.PUSH(100);
        }
        stop=clock();
        double timeTaken = (1000* ((double)stop-start)/CLOCKS_PER_SEC);
        cout<<"|  "<<arraySize<<"       | " << fixed << setprecision(4) << timeTaken <<  " milliseconds  |" << endl;
        arrayStack.MAKENULL();
    }
    //Iterated insertion in front
    cout<< "Timing results for arraystack iteration deletion"<<endl;
    cout<<"|  Size        | " << "Result(ms)  |"<<endl;
    for(int i=1; i < 11;i++){
        arraySize = 1000*i;//finding size of the array
        start = clock();
        for(int k = 1; k<arraySize+1;k++){
            arrayStack.PUSH(100);
        }
        for(int j =1; j<arraySize+1;j++){
            arrayStack.POP();
        }
        stop=clock();
        double timeTaken = (1000* ((double)stop-start)/CLOCKS_PER_SEC);
        cout<<"|  "<<arraySize<<"       | " << fixed << setprecision(4) << timeTaken <<  " milliseconds  |" << endl;
        arrayStack.MAKENULL();
    }
}
void timing::timingForPointerList(){
    Pointer pointerList = Pointer();
    //Iterated insertion in front
    cout<< "Timing results for pointerlist iteration insertion in front"<<endl;
    cout<<"|  Size        | " << "Result(ms)  |"<<endl;
    clock_t start, stop;
    int arraySize = 0;
    for(int i=1; i < 11;i++){
        arraySize = 1000*i;//finding size of the array
        start = clock();
        for(int k = 1; k<arraySize+1;k++){
            pointerList.INSERT(1,100);
        }
        stop=clock();
        double timeTaken = (1000* ((double)stop-start)/CLOCKS_PER_SEC);
        cout<<"|  "<<arraySize<<"       | " << fixed << setprecision(4) << timeTaken <<  " milliseconds  |" << endl;
        pointerList.MAKENULL();
    }
    //Iteraded insertion in back
    cout<< "Timing results for pointerlist iteration insertion in back"<<endl;
    cout<<"|  Size        | " << "Result(ms)  |"<<endl;
    arraySize=0;
    for(int i=1; i < 11;i++){
        arraySize = 1000*i;//finding size of the array
        start = clock();
        for(int k = 1; k<arraySize+1;k++){
            pointerList.INSERT(pointerList.END(),100);//Insertion at the back
        }
        stop=clock();
        double timeTaken = (1000* ((double)stop-start)/CLOCKS_PER_SEC);
        cout<<"|  "<<arraySize<<"       | " << fixed << setprecision(4) << timeTaken <<  " milliseconds  |" << endl;
        pointerList.MAKENULL();
    }
    //Traversal for locate and retrieve
    cout<< "Timing results for pointerlist traversal"<<endl;
    cout<<"|  Size        | " << "Result(ms)  |"<<endl;
    arraySize=0;
    for(int i=1; i < 11;i++){
        arraySize = 1000*i;//finding size of the array
        
        for(int k = 1; k<arraySize+1;k++){
            pointerList.INSERT(1,100*k);//traversal
        }
        start = clock();
        for(int l=1;l<arraySize+1;l++){
            pointerList.RETRIEVE(100);
            pointerList.LOCATE(100);
        }
        stop=clock();
        double timeTaken = (1000* ((double)stop-start)/CLOCKS_PER_SEC);
        cout<<"|  "<<arraySize<<"       | " << fixed << setprecision(4) << timeTaken <<  " milliseconds  |" << endl;
        pointerList.MAKENULL();
    }
    
    cout<< "Timing results for pointerlist iteration deletion in front"<<endl;
    cout<<"|  Size        | " << "Result(ms)  |"<<endl;
    arraySize=0;
    for(int i=1; i < 11;i++){
        arraySize = 1000*i;//finding size of the array
        start = clock();
        for(int u = 1; u<arraySize+1;u++){
            pointerList.INSERT(1,100);
        }
        for(int k = 1; k<arraySize-1;k++){
            pointerList.DELETE(1);//Insertion at the back
        }
        stop=clock();
        double timeTaken = (1000* ((double)stop-start)/CLOCKS_PER_SEC);
        cout<<"|  "<<arraySize<<"       | " << fixed << setprecision(4) << timeTaken <<  " milliseconds  |" << endl;
        pointerList.MAKENULL();
    }
    //Iteraded deletion in front
    cout<< "Timing results for pointerlist iteration deletion in back"<<endl;
    cout<<"|  Size        | " << "Result(ms)  |"<<endl;
    arraySize=0;
    for(int i=1; i < 11;i++){
        arraySize = 1000*i;//finding size of the array
        start = clock();
        for(int u = 1; u<arraySize+1;u++){
            pointerList.INSERT(1,100);
        }
        for(int k = 1; k<arraySize;k++){
            pointerList.DELETE(pointerList.END()-2);//Insertion at the back
        }
        stop=clock();
        double timeTaken = (1000* ((double)stop-start)/CLOCKS_PER_SEC);
        cout<<"|  "<<arraySize<<"       | " << fixed << setprecision(4) << timeTaken <<  " milliseconds  |" << endl;
        pointerList.MAKENULL();
    }
}
void timing::timingForPointerStack(){
    pStack pointerStack =pStack();
    //Iterated insertion
    cout<< "Timing results for pointerstack iteration insertion"<<endl;
    cout<<"|  Size        | " << "Result(ms)  |"<<endl;
    clock_t start, stop;
    int arraySize = 0;
    for(int i=1; i < 11;i++){
        arraySize = 1000*i;//finding size of the array
        start = clock();
        for(int k = 1; k<arraySize+1;k++){
            pointerStack.PUSH(100);
        }
        stop=clock();
        double timeTaken = (1000* ((double)stop-start)/CLOCKS_PER_SEC);
        cout<<"|  "<<arraySize<<"       | " << fixed << setprecision(4) << timeTaken <<  " milliseconds  |" << endl;
        pointerStack.MAKENULL();
    }
    //Iterated deletion
    cout<< "Timing results for pointerstack iteration deletion"<<endl;
    cout<<"|  Size        | " << "Result(ms)  |"<<endl;
    for(int i=1; i < 11;i++){
        arraySize = 1000*i;//finding size of the array
        start = clock();
        for(int k = 1; k<arraySize+1;k++){
            pointerStack.PUSH(100);
        }
        for(int j =1; j<arraySize+1;j++){
            pointerStack.POP();
        }
        stop=clock();
        double timeTaken = (1000* ((double)stop-start)/CLOCKS_PER_SEC);
        cout<<"|  "<<arraySize<<"       | " << fixed << setprecision(4) << timeTaken <<  " milliseconds  |" << endl;
        pointerStack.MAKENULL();
    }
}
void timing::timingForLibaryStack(){
    stack<int> libraryStack;
    //Iterated insertion
    cout<< "Timing results for librarystack iteration insertion"<<endl;
    cout<<"|  Size        | " << "Result(ms)  |"<<endl;
    clock_t start, stop;
    int arraySize = 0;
    for(int i=1; i < 11;i++){
        arraySize = 1000*i;//finding size of the array
        start = clock();
        for(int k = 1; k<arraySize+1;k++){
            libraryStack.push(100);
        }
        stop=clock();
        double timeTaken = (1000* ((double)stop-start)/CLOCKS_PER_SEC);
        cout<<"|  "<<arraySize<<"       | " << fixed << setprecision(4) << timeTaken <<  " milliseconds  |" << endl;
    }
    stack<int> libraryStack2;
    //Iterated deletion
    cout<< "Timing results for librarystack iteration deletion"<<endl;
    cout<<"|  Size        | " << "Result(ms)  |"<<endl;
    for(int i=1; i < 11;i++){
        arraySize = 1000*i;//finding size of the array
        start = clock();
        for(int k = 1; k<arraySize+1;k++){
            libraryStack2.push(100);
        }
        for(int j =1; j<arraySize+1;j++){
            libraryStack2.pop();
        }
        stop=clock();
        double timeTaken = (1000* ((double)stop-start)/CLOCKS_PER_SEC);
        cout<<"|  "<<arraySize<<"       | " << fixed << setprecision(4) << timeTaken <<  " milliseconds  |" << endl;
        
    }
}
void timing::timingForLibaryList(){
    list<int> arrayList1;
    //Iterated insertion in front
    cout<< "Timing results for librarylist iteration insertion in front"<<endl;
    cout<<"|  ArraySize  | " << "Result(ms)  |"<<endl;
    clock_t start, stop;
    int arraySize = 0;
    for(int i=1; i < 11;i++){
        arraySize = 1000*i;//finding size of the array
        start = clock();
        for(int k = 1; k<arraySize+1;k++){
            arrayList1.push_front(100);//inserting
        }
        stop=clock();
        double timeTaken = (1000* ((double)stop-start)/CLOCKS_PER_SEC);//calculating clock
        cout<<"|  "<<arraySize<<"       | " << fixed << setprecision(4) << timeTaken <<  " milliseconds  |" << endl;

    }
    list<int> arrayList2;
    //Iteraded insertion in back
    cout<< "Timing results for librarylist iteration insertion in back"<<endl;
    cout<<"|  Size        | " << "Result(ms)  |"<<endl;
    arraySize=0;
    for(int i=1; i < 11;i++){
        arraySize = 1000*i;//finding size of the array
        start = clock();
        for(int k = 1; k<arraySize+1;k++){
            arrayList2.push_back(100);//Insertion at the back
        }
        stop=clock();
        double timeTaken = (1000* ((double)stop-start)/CLOCKS_PER_SEC);
        cout<<"|  "<<arraySize<<"       | " << fixed << setprecision(4) << timeTaken <<  " milliseconds  |" << endl;
        
    }
    list<int> arrayList3;
    //Traversal for locate and retrieve
    cout<< "Timing results for librarylist traversal"<<endl;
    cout<<"|  Size        | " << "Result(ms)  |"<<endl;
    arraySize=0;
    for(int i=1; i < 11;i++){
        arraySize = 1000*i;//finding size of the array
        
        for(int k = 1; k<arraySize+1;k++){
            arrayList3.push_front(100*k);//traversal
        }
        start = clock();
        for(int l=1;l<arraySize;l++){
           //arrayList3.;
           // arrayList3.LOCATE(100*l);
        }
        stop=clock();
        double timeTaken = (1000* ((double)stop-start)/CLOCKS_PER_SEC);
        cout<<"|  "<<arraySize<<"       | " << fixed << setprecision(4) << timeTaken <<  " milliseconds  |" << endl;
        
    }
    //Iteraded deletion in front
    list<int> arrayList4;
    cout<< "Timing results for librarylist iteration deletion in front"<<endl;
    cout<<"|  Size        | " << "Result(ms)  |"<<endl;
    arraySize=0;
    for(int i=1; i < 11;i++){
        arraySize = 1000*i;//finding size of the array
        start = clock();
        for(int o=1; o<arraySize+1;o++){
            arrayList4.push_front(100);
        }
        for(int k = 1; k<arraySize+1;k++){
            arrayList4.pop_front();//Insertion at the back
        }
        stop=clock();
        double timeTaken = (1000* ((double)stop-start)/CLOCKS_PER_SEC);
        cout<<"|  "<<arraySize<<"       | " << fixed << setprecision(4) << timeTaken <<  " milliseconds  |" << endl;
        
    }
    //Iteraded deletion in front
    list<int> arrayList5;
    cout<< "Timing results for librarylist iteration deletion in back"<<endl;
    cout<<"|  Size        | " << "Result(ms)  |"<<endl;
    arraySize=0;
    for(int i=1; i < 11;i++){
        arraySize = 1000*i;//finding size of the array
        start = clock();
        for(int p=1; p<arraySize+1;p++){
            arrayList5.push_front(100);
        }
        for(int k = 1; k<arraySize+1;k++){
            arrayList5.pop_back();//Insertion at the back
        }
        stop=clock();
        double timeTaken = (1000* ((double)stop-start)/CLOCKS_PER_SEC);
        cout<<"|  "<<arraySize<<"       | " << fixed << setprecision(4) << timeTaken <<  " milliseconds  |" << endl;
    }
}


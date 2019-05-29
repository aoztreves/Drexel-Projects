//
//  concatenatelist.cpp
//  pa1
//
//  Created by Aslan Oztreves on 3/5/17.
//  Copyright © 2017 Aslan Oztreves. All rights reserved.
//

#include "listconcat.h"
#include <iostream>
#include <cstdlib>
#include "listconcat.h"
//#include "arraylist.h"
#include "pointerlist.h"
#include <vector>

using namespace std;

concatenatelist::concatenatelist(){
    
}
void concatenatelist::concatenateList(){
  
    Pointer al = Pointer();
    Pointer al2 = Pointer();
    Pointer al3 = Pointer();
    Pointer al4 = Pointer();
    Pointer al5 = Pointer();
    
    vector<Pointer> al6;
    
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
    // int FULLSIZE = al.END()+al2.END()+al3.END()+al4.END()-4;
    //cout << FULLSIZE;
    //int counter = 1;
    
    al6.push_back(al);
    al6.push_back(al2);
    al6.push_back(al3);
    al6.push_back(al4);
    //for(int i=0;i<FULLSIZE;i++){
       // cout<<al6[0].RETRIEVE(2)<< " ";
    //}
    
    /*while(counter != 20){
        for(int j=1;j<20+1;j++){
            al5.INSERT(counter+1,al6[counter].RETRIEVE(j));
        }
        counter=counter+1;
    }
    for(int i=0;i<20;i++){
        cout<<al5.RETRIEVE(i)<< " ";
    }
    cout << endl;
    */
    for(int i=0;i<al6.size();i++){
        for(int j=1;j<al6[i].END();j++){
            al5.INSERT(al5.END(), al6[i].RETRIEVE(j));
        }
    }
    for(int i=1;i<21;i++){
        cout<<al5.RETRIEVE(i)<< " ";
    }
    cout << endl;
    al.MAKENULL();
    al2.MAKENULL();
    al3.MAKENULL();
    al4.MAKENULL();
    al5.MAKENULL();
    
    
    
}


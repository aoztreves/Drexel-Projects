//
//  preorder.cpp
//  pa2-done
//
//  Created by Aslan Oztreves on 3/6/17.
//  Copyright © 2017 Aslan Oztreves. All rights reserved.
//

#include "preorder.h"
#include <iostream>
#include <stack>
#include <fstream>
#include <string>
#include <sstream>

using namespace std;

preorder::preorder(){
    
}
int preorder::mainpreorder(){
    stack<int> s;
    char expression[40];
   
    expression[0]='+';
    expression[1]='*';
    expression[2]='5';
    expression[3]='3';
    expression[4]='*';
    expression[5]='2';
    expression[6]='8';
    
    
    int n;
    int result;
    reverseArray(expression);
    
    
    for(unsigned int i=0;i<17;i++){
        if(Number(expression[i])==true)
        {
            char c = expression[i];
            n = c-'0';//convert char to integer
            s.push(n); //push into statck
        }
        if(expression[i]=='+')
        {
            int x = s.top();
            s.pop();
            int y = s.top();
            s.pop();
            result = x+y;
            s.push(result);
        }
        if(expression[i]=='-')
        {
            int x = s.top();
            s.pop();
            int y = s.top();
            s.pop();
            result = y-x;
            s.push(result);
        }
        if(expression[i]=='*')
        {
            int x = s.top();
            s.pop();
            int y = s.top();
            s.pop();
            result = x*y;
            s.push(result);
        }
        if(expression[i]=='/')
        {
            int x = s.top();
            s.pop();
            int y = s.top();
            s.pop();
            result = y/x;
            s.push(result);
        }
    }
    cout << "Expression : (5*3)+(2*8) " << endl;
    cout << "Result of this expression is : " << s.top()<<endl;

    
    
    return 0;
}
void preorder::reverseArray(char arr[]){
    int end = 14;
    int start = 0;
    char temp;
    while(start < end)
    {
        temp = arr[start];
        arr[start] = arr[end];
        arr[end] = temp;
        start++;
        end--;
    }
}
bool preorder::Number(char &n){
    if(!isdigit(n)){
        return false;
    }
    else
        return true;
}

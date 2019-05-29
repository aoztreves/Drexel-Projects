//
//  postorder.cpp
//  pa2-done
//
//  Created by Aslan Oztreves on 3/6/17.
//  Copyright © 2017 Aslan Oztreves. All rights reserved.
//

#include "postorder.h"
#include <iostream>
#include <stack>
#include <string>
#include <stdio.h>
#include <cstdio>
using namespace std;

postorder::postorder(){
    
}
int postorder::mainpostorder(){
    stack<int> s;
    char expression[40];
    /*int x;
    //getchar(cin, line);
    do{
        x=getchar();
        putchar(x);
        cout << x << endl;
    }while(x != ' ');
    
    
    
    string temp;
    for(int i=0;i<10;i++){
        temp=line.substr(i,1);
        temp.c_str();
        expression[i]=temp[u0];
    }
    
    //line.substr(i,1);
    
    
    */
    expression[0]='5';
    expression[1]='3';
    expression[2]='+';
    expression[3]='2';
    expression[4]='8';
    expression[5]='+';
    expression[6]='*';
    //EXPRESSION (A+B)*(C+D) 
    
    int n;
    int result;
    
    for(unsigned int i=0;i<sizeof(expression);i++){
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
    cout << "Expression : (5+3)*(2+8) " << endl;
    cout << "Result of this expression is : " << s.top()<<endl;
    
    return 0;

}
bool postorder::Number(char &n){
    if(!isdigit(n)){
        return false;
    }
    else
        return true;
}

//
//  levelorder.cpp
//  pa2-done
//
//  Created by Aslan Oztreves on 3/7/17.
//  Copyright © 2017 Aslan Oztreves. All rights reserved.
//

#include "levelorder.h"
#include "lcrstree.h"
#include <iostream>
#include "tNode.h"
#include "node.h"
#include <cstdlib>
using namespace std;

levelorder::levelorder(){
    
}
void levelorder::levelOrder(){
    
    tnode first=new tNode();
    tnode second=new tNode();
    tnode third=new tNode();
    tnode fourth=new tNode();
    tnode fifth=new tNode();
    tnode seventh=new tNode();
    tnode eigth=new tNode();
    first->l=100;
    second->l=250;
    third->l=350;
    fourth->l=400;
    fifth->l=550;
    seventh->l=750;
    eigth->l=850;
    cout << endl << endl;
    cout << "LEVELORDER : "<<endl;
    cout<<"TREE:"<<endl;
    cout<<"      100"<<endl;
    cout<<"    /  | \\"<<endl;
    cout<<"   /   |  \\"<<endl;
    cout<<"  250  350  550"<<endl;
    cout<<" /   /  \\"<<endl;
    cout<<"400  750  850"<<endl;
    first->left_child=second;
    first->right_sibling=NULL;
    second->left_child=fourth;
    second->right_sibling=third;
    third->left_child=seventh;
    third->right_sibling=fifth;
    fourth->left_child=NULL;
    fourth->right_sibling=NULL;
    fifth->left_child=NULL;
    fifth->right_sibling=NULL;
    seventh->left_child=NULL;
    seventh->right_sibling=eigth;
    eigth->left_child=NULL;
    eigth->right_sibling=NULL;
    
    tnode node = new tNode();
    tnode temp= new tNode();
    tnode root= new tNode();

    cout << "EXPECTED ANSWER FOR THIS TREE IS = "<<"100-250-350-550-400-750-850"<<endl;
    cout << "ANSWER IS = ";
    cout << LABEL(ROOT(first)) << "-";
    
    int j=1;
    int counter=1;
    root=ROOT(first);
    node=root;
    
    while(counter != 0){
        for (int i=0;i<j;i++){
            if(LABEL(node->left_child) != -1){
                temp =node;
                node= node->left_child;
            }
        }
        cout << LABEL(node) << "-";
        while(LABEL(RIGHT_SIBLING(node)) != -1){
            node = node->right_sibling;
            cout<<LABEL(node) << "-";
        }
        node=temp->left_child;
        if((LABEL(RIGHT_SIBLING(node->left_child)) != -1) ||(LABEL(LEFTMOST_CHILD(node)) != -1)){
            if(LABEL(RIGHT_SIBLING(node)) != -1){
                node =node->right_sibling;
                //cout<< LABEL(node) << "-";
            }
            for (int i=0;i<j;i++){
                if(LABEL(node->left_child) != -1){
                    temp =node;
                    node= node->left_child;
                }
            }
            cout << LABEL(node) << "-";
            while(LABEL(RIGHT_SIBLING(node)) != -1){
                node = node->right_sibling;
                cout<<LABEL(node) << "-";
            }
        }
        else{
            j++;
            node=root;
        }
        if(counter == j){
            //node = temp;
            if(LABEL(RIGHT_SIBLING(node)) != -1){
                node=node->right_sibling;
                
            }
            j--;
        }
        counter =j;
    }
    
    
    
    
    /*
    if(LABEL(ROOT(first)->left_child) != -1){
        root=ROOT(first);
        temp=first->left_child;
        temp1=temp;
        cout<<LABEL(LEFTMOST_CHILD(first)) << "-";
        while( LABEL(RIGHT_SIBLING(temp)) != -1){
            temp=temp->right_sibling;
            cout <<LABEL(temp) << "-";
        }
        temp=temp1;
        if(LABEL(temp->left_child) != -1){
            temp=temp->left_child;
            cout<<LABEL(temp)<<"-";
            while( LABEL(RIGHT_SIBLING(temp)) != -1){
                temp=temp->right_sibling;
                cout <<LABEL(temp) << "-";
            }
            temp=temp1;
        }
        if(LABEL(temp->right_sibling) != -1){
            temp=temp->right_sibling;
            while( LABEL(LEFTMOST_CHILD(temp)) != -1){
                temp=temp->left_child;
                cout <<LABEL(temp) << "-";
                if(LABEL(temp->right_sibling) != -1){
                    temp=temp->right_sibling;
                    cout <<LABEL(temp);
                }
            }
        }
    }*/
    cout<<endl;
}

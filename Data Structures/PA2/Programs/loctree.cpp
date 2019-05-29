//
//  loctree.cpp
//  asd
//
//  Created by Aslan Oztreves on 3/6/17.
//  Copyright © 2017 Aslan Oztreves. All rights reserved.
//

#include <stdio.h>

#include "loctree.h"
#include <iostream>
using namespace std;

//loctree::loctree(){}
loctree::loctree(int i,...){
    va_list vList;
    va_start(vList,i);
    if(i>0){
        for(int j=0;j<i;j++){
            hnode.push_back(va_arg(vList,nnode));
        }
    }else{
        hnode[0]=NULL;
    }
}

nnode loctree::PARENT(nnode node){
    vector<nnode> temp = hnode;
    for(int i=0;i<temp.size();i++){
        nnode parent=temp[i];
        temp[i]=temp[i]->next;
        while(temp[i]!=NULL){
            if(temp[i]->element==node->element){
                return parent;
            }
            else{
                temp[i]=temp[i]->next;
            }
        }
    }
    return NULL;
}
nnode loctree::LEFTMOST_CHILD(nnode node){
    for(int i=0;i<hnode.size();i++){
        if((hnode[i]->element==node->element)&&(hnode[i]->next!=NULL)){
            return hnode[i]->next;
        }
    }
    return NULL;
}
nnode loctree::RIGHT_SIBLING(nnode node){
    
    if(node->next != NULL){
        return node->next;
    }
    return NULL;
}
int loctree::LABEL(nnode node){
    if(node == NULL){
        cout<<"EMPTY NODE"<<endl;
        return -1;
    }
    else{
        return node->element;//if not null then return the label
    }
}
nnode loctree::ROOT(){
    return hnode[0];//Return the first top of the node which is always root
}
void loctree::MAKENULL(){
    for(int i=0;i<hnode.size();i++){
        hnode[i]=NULL;
    }
}


void loctree::PREORDER(nnode node){
    nnode children;
    cout << LABEL(node) << " ";
    children = LEFTMOST_CHILD(node);
    while(children != NULL){
        PREORDER(children);
        children=RIGHT_SIBLING(children);
    }
}
void loctree::POSTORDER(nnode node){
    nnode children;
    //cout << LABEL(node)<< " ";
    children=LEFTMOST_CHILD(node);
    while(children != NULL){
        POSTORDER(children);
        children = RIGHT_SIBLING(children);
    }
    cout << LABEL(node)<< " ";
}







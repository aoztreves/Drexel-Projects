//
//  lmcrsTree.cpp
//  asd
//
//  Created by Aslan Oztreves on 3/6/17.
//  Copyright © 2017 Aslan Oztreves. All rights reserved.
//

#include "lcrstree.h"
#include "tNode.h"

#include <stdio.h>
#include <iostream>
#include <cstdlib>
#include <stdarg.h>

tnode PARENT(tnode node,tnode T){
    if(T != NULL){
        tnode temp=T->left_child;
        while(temp != NULL){
            if(temp == node){
                return T;
            }
            else{
                temp=temp->right_sibling;
            }
        }
        if((T->right_sibling != NULL) && T->left_child != NULL){
            PARENT(node,T->right_sibling);
            PARENT(node,T->left_child);
        }
        else if(T->left_child != NULL){
            PARENT(node,T->left_child);
        }
        else if(T->right_sibling != NULL){
            PARENT(node,T->right_sibling);
        }
    }
    return NULL;
}
tnode LEFTMOST_CHILD(tnode node){
    return node->left_child;
}
tnode RIGHT_SIBLING(tnode node){
    return node->right_sibling;
}
int LABEL(tnode node){
    if(node != NULL){
        return node->l;
    }
    else{
        return -1;
    }
    
}
tnode CREATE(int v,int p,...){
    tnode ntnode = new tNode();
    ntnode->l=v;
    va_list vList2;
    va_start(vList2,p);
    if(p > 0){
        tnode tem =ntnode;
        ntnode->left_child=va_arg(vList2,tnode);
        ntnode=ntnode->left_child;
        ntnode->right_sibling=NULL;
        for(int j=0;j<p;j++){
            ntnode->right_sibling=NULL;
            ntnode->right_sibling=va_arg(vList2, tnode);
            ntnode = ntnode ->right_sibling;
            ntnode->right_sibling=NULL;
        }
        ntnode = tem;
        va_end(vList2);
    }
    else{
        cout << "NO TREES" << endl;
    }
    
    return ntnode;
}
tnode ROOT(tnode node){
    if(node == NULL){
        return NULL;
    }
    return node;
}
void MAKENULL(tnode node){
    node->left_child=NULL;
    node->right_sibling=NULL;
}
void POSTORDER(tnode node){
    tnode children;
    children=node->left_child;
    //node=node->left_child;
    while(children != NULL){
        POSTORDER(children);
        children=children->right_sibling;
    }
    cout << LABEL(node)<< " ";
}
void PREORDER(tnode node){
    tnode children;
    cout << LABEL(node) << " ";
    children= node->left_child;
    
    while( children != NULL){
        PREORDER(children);
        children=children->right_sibling;
        
        //children=children->right_sibling;
    }
    
}

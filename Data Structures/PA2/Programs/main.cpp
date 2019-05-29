//
//  main.cpp
//  asd
//
//  Created by Aslan Oztreves on 3/3/17.
//  Copyright © 2017 Aslan Oztreves. All rights reserved.
//

#include <iostream>
#include "node.h"
#include "pointerqueue.h"
#include "tNode.h"
#include "loctree.h"
#include "lcrstree.h"
#include "timing.h"
#include "preorder.h"
#include "postorder.h"
#include "levelorder.h"


using namespace std;
void testforLCSTree();
void testforLOCTree();

int main() {
    
    
    // TEST CASES
    testforLCSTree();
    testforLOCTree();
    PointerQueue pq = PointerQueue();
    pq.pointerqueueTest();
    
    // TIMING CASES
    timing time = timing();
    time.timeforLCRSTree();
    time.timeforLOCTree();
    
    // PREORDER MATH
    cout << endl<<endl<<"PREORDER"<<endl;
    preorder preO = preorder();
    preO.mainpreorder();
    cout << endl<<endl<<"POSTORDER"<<endl;
    // POSTORDER MATH
    postorder postO = postorder();
    postO.mainpostorder();
    
    // LEVELORDER
    levelorder lo = levelorder();
    lo.levelOrder();
    
    return 0;
}

void testforLOCTree(){
    
    
    nnode first=new node();
    nnode second=new node();
    nnode third=new node();
    nnode fourth=new node();
    nnode fifth=new node();
    nnode seventh=new node();
    nnode eigth=new node();
    nnode hnode1=new node();
    nnode hnode2=new node();
    nnode hnode3=new node();
    nnode hnode4=new node();
    nnode hnode5=new node();
    nnode hnode7=new node();
    nnode hnode8=new node();
    first->element=10;
    second->element=20;
    third->element=30;
    fourth->element=40;
    fifth->element=50;
    seventh->element=70;
    eigth->element=80;
    hnode1->element=10;
    hnode2->element=20;
    hnode3->element=30;
    hnode4->element=40;
    hnode5->element=50;
    hnode7->element=70;
    hnode8->element=80;
    first->next=second;
    second->next=third;
    third->next=fifth;
    fourth->next=NULL;
    fifth->next=NULL;
    seventh->next=eigth;
    eigth->next=NULL;
    hnode1->next=second;
    hnode2->next=fourth;
    hnode3->next=seventh;
    hnode4->next=NULL;
    hnode5->next=NULL;
    hnode7->next=NULL;
    hnode8->next=NULL;
    cout<<"Lets create a tree that looks like this:"<<endl;
    cout<<"      10"<<endl;
    cout<<"    /  | \\"<<endl;
    cout<<"   /   |  \\"<<endl;
    cout<<"  20  30  50"<<endl;
    cout<<" /   /  \\"<<endl;
    cout<<"40  70  80"<<endl;
    loctree vList(7,hnode1,hnode2,hnode3,hnode4,hnode5,hnode7,hnode8);
    cout<<endl<<"The root of this tree is:";
    cout<<vList.LABEL(vList.ROOT());
    cout<<endl<<"The parent of 30 is:";
    cout<<vList.LABEL(vList.PARENT(third));
    cout<<endl<<"The LMC of 10 is:";
    cout<<vList.LABEL(vList.LEFTMOST_CHILD(first));
    cout<<endl<<"The right sibling of 30 is:";
    cout<<vList.LABEL(vList.RIGHT_SIBLING(third));
    cout<<endl<<"Post order of this tree:";
    vList.POSTORDER(first);
    cout<<endl<<"Pre order of this tree:";
    vList.PREORDER(first);
    cout<<endl;
    
}

void testforLCSTree(){
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
    cout<<endl<<"The root is:";
    cout<<LABEL(ROOT(first));
    cout<<endl<<"The parent of 300 is:(should be 100) = ";
    cout<<LABEL(PARENT(third,first));
    cout<<endl<<"The LMC of 100 is: (should be 250) = ";
    cout<<LABEL(LEFTMOST_CHILD(first));
    cout<<endl<<"The right sibling of 350 is:(should be 550) = ";
    cout<<LABEL(RIGHT_SIBLING(third));
    cout<<endl<<"Post order of this tree:";
    POSTORDER(first);
    cout<<endl<<"Pre order of this tree:";
    PREORDER(first);
    cout<<endl;
    
}

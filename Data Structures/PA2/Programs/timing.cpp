//
//  timing.cpp
//  asd
//
//  Created by Aslan Oztreves on 3/6/17.
//  Copyright © 2017 Aslan Oztreves. All rights reserved.
//

#include "timing.h"
#include "node.h"
#include "pointerqueue.h"
#include "tNode.h"
#include "loctree.h"
#include "lcrstree.h"

timing::timing(){
    
}
void timing::timeforLOCTree(){
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
    cout<< " TEST CASE FOR LOCTREE " << endl;
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
    clock_t start,stop;
    cout << "---- Height 3 the time for LOCTREE PREORDER ----- : "<<endl;
    cout << "PREORDER is = ";
    start=clock();
    PREORDER(first);
    stop=clock();
    double timeTaken = (1000* ((double)stop-start)/CLOCKS_PER_SEC);
    cout << endl<<"Time taken is = " <<timeTaken << endl;
    cout << "---- Height 3 the time for LOCTREE POSTORDER ----- : "<<endl;
    cout << "POSTORDER is = ";
    start=clock();
    POSTORDER(first);
    stop=clock();
    double timeTaken3 = (1000* ((double)stop-start)/CLOCKS_PER_SEC);
    cout << endl<<"Time taken is = " <<timeTaken3 << endl;
    
    cout<<endl;
    cout<< " TEST CASE 2 FOR LOCTREE " << endl;
    cout<<"TREE:"<<endl;
    cout<<"              100"<<endl;
    cout<<"           /  |  \\"<<endl;
    cout<<"          /   |    \\"<<endl;
    cout<<"        250  350     550"<<endl;
    cout<<"        /   /   \\   /   \\"<<endl;
    cout<<"      400  750   850 1250 1350"<<endl;
    cout<<"       /   /   "<<endl;
    cout<<"    950   1100 " << endl;
    cout<<"     /"<<endl;
    cout<<"  1050"<<endl;
    cout<<"  /"<<endl;
    cout<<"1150"<<endl;
    tnode first1=new tNode();
    tnode second2=new tNode();
    tnode third3=new tNode();
    tnode fourth4=new tNode();
    tnode fifth5=new tNode();
    tnode seventh7=new tNode();
    tnode eigth8=new tNode();
    tnode nineth9=new tNode();
    tnode tenth10=new tNode();
    tnode eleventh11=new tNode();
    tnode twelved12=new tNode();
    tnode thirth13=new tNode();
    tnode fourth14 = new tNode();
    tnode fiftnth15 = new tNode();
    
    first1->l=100;
    second2->l=250;
    third3->l=350;
    fourth4->l=400;
    fifth5->l=550;
    seventh7->l=750;
    eigth8->l=850;
    nineth9->l=950;
    tenth10->l=1050;
    eleventh11->l=1150;
    twelved12->l=1250;
    thirth13->l= 1350;
    fourth14->l=1100;
    fiftnth15->l=1103;
    
    first1->left_child=second2;
    first1->right_sibling=NULL;
    second2->left_child=fourth4;
    second2->right_sibling=third3;
    third3->left_child=seventh7;
    third3->right_sibling=fifth5;
    fourth4->left_child=nineth9;
    fourth4->right_sibling=NULL;
    fifth5->left_child=twelved12;
    twelved12->right_sibling=thirth13;
    fifth5->right_sibling=NULL;
    seventh7->left_child=fourth14;
    fourth14->left_child=fiftnth15;
    
    seventh7->right_sibling=eigth8;
    eigth8->left_child=NULL;
    eigth8->right_sibling=NULL;
    nineth9->left_child=tenth10;
    tenth10->left_child=eleventh11;
    eleventh11->left_child=NULL;
    eleventh11->right_sibling=NULL;
    fiftnth15->left_child=NULL;
    fiftnth15->right_sibling=NULL;
    fourth14->right_sibling=NULL;
    twelved12->left_child=NULL;
    thirth13->right_sibling=NULL;
    thirth13->left_child=NULL;
    clock_t start2,stop2;
    cout << "---- Height 6 the time for LOCTREE PREORDER ----- : "<<endl;
    cout << "PREORDER is = ";
    start2=clock();
    PREORDER(first1);
    stop2=clock();
    double timeTaken2 = (1000* ((double)stop2-start2)/CLOCKS_PER_SEC);
    cout << endl<<"Time taken is = " <<timeTaken2 << endl;
    cout << "---- Height 6 the time for LOCTREE POSTORDER ----- : "<<endl;
    cout << "POSTORDER is = ";
    start2=clock();
    POSTORDER(first1);
    stop2=clock();
    double timeTaken4 = (1000* ((double)stop2-start2)/CLOCKS_PER_SEC);
    cout << endl<<"Time taken is = " <<timeTaken4 << endl<<endl;

    
}
void timing::timeforLCRSTree(){
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
    cout<< " TEST CASE FOR LCRSTREE " << endl;
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
    clock_t start,stop;
    cout << "---- Height 3 the time for LCRSTREE PREORDER ----- : "<<endl;
    cout << "PREORDER is = ";
    start=clock();
    PREORDER(first);
    stop=clock();
    double timeTaken = (1000* ((double)stop-start)/CLOCKS_PER_SEC);
    cout << endl<<"Time taken is = " <<timeTaken << endl;
    cout << "---- Height 3 the time for LCRSTREE POSTORDER ----- : "<<endl;
    cout << "POSTORDER is = ";
    start=clock();
    POSTORDER(first);
    stop=clock();
    double timeTaken3 = (1000* ((double)stop-start)/CLOCKS_PER_SEC);
    cout << endl<<"Time taken is = " <<timeTaken3 << endl;

    cout << endl;
    cout<< " TEST CASE 2 FOR LCRSTREE " << endl;
    cout<<"TREE:"<<endl;
    cout<<"              100"<<endl;
    cout<<"           /  |  \\"<<endl;
    cout<<"          /   |    \\"<<endl;
    cout<<"        250  350     550"<<endl;
    cout<<"        /   /   \\   /   \\"<<endl;
    cout<<"      400  750   850 1250 1350"<<endl;
    cout<<"       /   /   "<<endl;
    cout<<"    950   1100 " << endl;
    cout<<"     /"<<endl;
    cout<<"  1050"<<endl;
    cout<<"  /"<<endl;
    cout<<"1150"<<endl;
    tnode first1=new tNode();
    tnode second2=new tNode();
    tnode third3=new tNode();
    tnode fourth4=new tNode();
    tnode fifth5=new tNode();
    tnode seventh7=new tNode();
    tnode eigth8=new tNode();
    tnode nineth9=new tNode();
    tnode tenth10=new tNode();
    tnode eleventh11=new tNode();
    tnode twelved12=new tNode();
    tnode thirth13=new tNode();
    tnode fourth14 = new tNode();
    tnode fiftnth15 = new tNode();
    
    first1->l=100;
    second2->l=250;
    third3->l=350;
    fourth4->l=400;
    fifth5->l=550;
    seventh7->l=750;
    eigth8->l=850;
    nineth9->l=950;
    tenth10->l=1050;
    eleventh11->l=1150;
    twelved12->l=1250;
    thirth13->l= 1350;
    fourth14->l=1100;
    fiftnth15->l=1103;
    
    first1->left_child=second2;
    first1->right_sibling=NULL;
    second2->left_child=fourth4;
    second2->right_sibling=third3;
    third3->left_child=seventh7;
    third3->right_sibling=fifth5;
    fourth4->left_child=nineth9;
    fourth4->right_sibling=NULL;
    fifth5->left_child=twelved12;
    twelved12->right_sibling=thirth13;
    fifth5->right_sibling=NULL;
    seventh7->left_child=fourth14;
    fourth14->left_child=fiftnth15;
    
    seventh7->right_sibling=eigth8;
    eigth8->left_child=NULL;
    eigth8->right_sibling=NULL;
    nineth9->left_child=tenth10;
    tenth10->left_child=eleventh11;
    eleventh11->left_child=NULL;
    eleventh11->right_sibling=NULL;
    fiftnth15->left_child=NULL;
    fiftnth15->right_sibling=NULL;
    fourth14->right_sibling=NULL;
    twelved12->left_child=NULL;
    thirth13->right_sibling=NULL;
    thirth13->left_child=NULL;
    clock_t start2,stop2;
    cout << "---- Height 6 the time for LCRSTREE PREORDER ----- : "<<endl;
    cout << "PREORDER is = ";
    start2=clock();
    PREORDER(first1);
    stop2=clock();
    double timeTaken2 = (1000* ((double)stop2-start2)/CLOCKS_PER_SEC);
    cout << endl<<"Time taken is = " <<timeTaken2 << endl;
    cout << "---- Height 6 the time for LCRSTREE POSTORDER ----- : "<<endl;
    cout << "POSTORDER is = ";
    start2=clock();
    POSTORDER(first1);
    stop2=clock();
    double timeTaken4 = (1000* ((double)stop2-start2)/CLOCKS_PER_SEC);
    cout << endl<<"Time taken is = " <<timeTaken4 << endl;
    
}

//
//  listofchildrenTree.h
//  asd
//
//  Created by Aslan Oztreves on 3/6/17.
//  Copyright © 2017 Aslan Oztreves. All rights reserved.
//

#ifndef loctree_h
#define loctree_h



#include "node.h"
#include <stdio.h>
#include <iostream>
#include <vector>

using namespace std;

class loctree{
private:
    vector<nnode> hnode;
public:

    loctree(int,...);
    nnode PARENT(nnode);
    nnode LEFTMOST_CHILD(nnode);
    nnode RIGHT_SIBLING(nnode);
    int LABEL(nnode);
    loctree CREATE(int,int,...);
    nnode ROOT();
    void MAKENULL();
    void PREORDER(nnode);
    void POSTORDER(nnode);

};

#endif /* listofchildrenTree_h */

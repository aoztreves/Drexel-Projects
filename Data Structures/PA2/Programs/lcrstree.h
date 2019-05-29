//
//  lmcrsTree.hpp
//  asd
//
//  Created by Aslan Oztreves on 3/6/17.
//  Copyright © 2017 Aslan Oztreves. All rights reserved.
//

#ifndef lcrstree_h
#define lcrstree_h

#include <stdio.h>
#include <iostream>
#include <vector>

#include "node.h"
#include "tNode.h"
#include "loctree.h"

using namespace std;

tnode PARENT(tnode,tnode);
tnode LEFTMOST_CHILD(tnode);
tnode RIGHT_SIBLING(tnode);
int LABEL(tnode);
tnode CREATE(int v,int c,...);
tnode ROOT(tnode);
void MAKENULL(tnode);
void POSTORDER(tnode);
void PREORDER(tnode);

#endif 

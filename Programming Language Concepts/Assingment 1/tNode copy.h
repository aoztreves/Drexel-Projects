//
//  tNode.h
//  asd
//
//  Created by Aslan Oztreves on 3/6/17.
//  Copyright © 2017 Aslan Oztreves. All rights reserved.
//

#ifndef tNode_h
#define tNode_h

typedef struct tNode *tnode;
struct tNode
{
    int l;//label
    int h;//height
    tnode left_child;
    tnode right_sibling;
};
#endif /* tNode_h */

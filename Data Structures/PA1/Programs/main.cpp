//
//  main.cpp
//  dv
//
//  Created by Aslan Oztreves on 2/20/17.
//  Copyright © 2017 Aslan Oztreves. All rights reserved.
//

#include <iostream>
#include <iomanip>
#include <fstream>
#include <ctime>
#include "arraylist.h"
#include "arraystack.h"
#include "pointerlist.h"
#include "pointerstack.h"
#include "timing.h"
#include "testing.h"


using namespace std;

int main(int argc, char* argv[]) {
    //TIMING CASES

    timing timeT =timing();
    
    timeT.timingForArrayList();
    timeT.timingForArrayStack();
    timeT.timingForPointerList();
    timeT.timingForPointerStack();
    timeT.timingForLibaryStack();
    timeT.timingForLibaryList();
    
    
    //TEST CASES
    testing test = testing();
    
    test.testingForArrayList();
    test.testingForArrayStack();
    test.testingForPointerList();
    test.testingForPointerStack();
    
    return 0;
}

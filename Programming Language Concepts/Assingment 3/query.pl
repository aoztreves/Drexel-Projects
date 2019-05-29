/*solution*/

:- set_prolog_flag(double_quotes, chars).

csg(C, S, G) :- C = "CS101", S=12345, G="A".
csg(C, S, G) :- C = "CS101", S=67890, G="B".
csg(C, S, G) :- C = "CS101", S=33333, G="C".
csg(C, S, G) :- C = "EE200", S=12345, G="B+".
csg(C, S, G) :- C = "EE200", S=22222, G="A-".
csg(C, S, G) :- C = "PH100", S=67890, G="C+".

book(N, I) :- N = "C. Brown", I = 12345.
book(N, I) :- N = "L. Van Pelt", I = 67890.
book(N, I) :- N = "P. Patty", I = 22222.

/* p -->  C*/
preReq(C, P) :- C = "CS101", P = "CS100".
preReq(C, P) :- C = "EE200", P = "EE005".
preReq(C, P) :- C = "EE200", P = "CS100".
preReq(C, P) :- C = "CS120", P = "CS101".
preReq(C, P) :- C = "CS121", P = "CS120".
preReq(C, P) :- C = "CS205", P = "CS101".
preReq(C, P) :- C = "CS206", P = "CS121".
preReq(C, P) :- C = "CS206", P = "CS205".


/* problem*/
getByName(N, C, G) :- book(N, I), csg(C, I, G).



/* problem*/
before(C, B) :- preReq(C, B).
before(C, B) :- preReq(C, X), before(X, B).

 
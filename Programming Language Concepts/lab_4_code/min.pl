min([],X,X).
min([H|T],M,X) :- H =< M, min(T,H,X).
min([H|T],M,X) :- M < H, min(T,M,X).
min([H|T],X) :- min(T,H,X).
# 	
#
#	Aslan Oztreves	
#	Lists: array implementation of operations:
#	MAKEFILE	
#	PROGRAMMING ASSIGNMENT 1
#	02/17/2017
#
#

CC=g++
CFLAGS = -c
.PHONY: clean all
all : build

build: main.o testing.o timing.o arraylist.o pointerstack.o pointerlist.o arraystack.o
	$(CC) main.o testing.o timing.o arraylist.o pointerstack.o pointerlist.o arraystack.o -o build
	./build
	rm ./build
	rm -rf *o main
main.o : main.cpp
	$(CC) $(CFLAGS) main.cpp
testing.o: testing.cpp
	$(CC) $(CFLAGS) testing.cpp
timing.o : timing.cpp
	$(CC) $(CFLAGS) timing.cpp
arraylist.o : arraylist.cpp 
	$(CC) $(CFLAGS) arraylist.cpp
arraystack.o : arraystack.cpp 
	$(CC) $(CFLAGS) arraystack.cpp
pointerlist.o : pointerlist.cpp 
	$(CC) $(CFLAGS) pointerlist.cpp 
pointerstack.o : pointerstack.cpp
	$(CC) $(CFLAGS) pointerstack.cpp
timing : timing.o main.o arraylist.o pointerstack.o pointerlist.o arraystack.o
	$(CC) timing.o main.o arraylist.o pointerstack.o pointerlist.o arraystack.o -o time
	./time
	rm ./time
	rm -rf *o main
testing : main.o timing.o arraylist.o pointerstack.o pointerlist.o arraystack.o
	$(CC) main.o timing.o arraylist.o pointerstack.o pointerlist.o arraystack.o -o testt
	./testt
	rm ./testt
	rm -rf *o main
clean:
	rm -rf *o main
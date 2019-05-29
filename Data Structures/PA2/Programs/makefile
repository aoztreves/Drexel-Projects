# 	
#
#	Aslan Oztreves	
#
#	MAKEFILE	
#	PROGRAMMING ASSIGNMENT 2
#	02/17/2017
#
#

CC=g++
CFLAGS = -c
.PHONY: clean all
all : build

build: main.o lcrstree.o levelorder.o listconcat.o loctree.o mergelists.o pointerlist.o pointerqueue.o preorder.o postorder.o timing.o
	$(CC) main.o lcrstree.o levelorder.o listconcat.o loctree.o mergelists.o pointerlist.o pointerqueue.o preorder.o postorder.o timing.o -o build
	./build
	rm ./build
	rm -rf *o main
main.o : main.cpp
	$(CC) $(CFLAGS) main.cpp
lcrstree.o : lcrstree.cpp
	$(CC) $(CFLAGS) lcrstree.cpp
levelorder.o : levelorder.cpp
	$(CC) $(CFLAGS) levelorder.cpp
listconcat.o: listconcat.cpp
	$(CC) $(CFLAGS) listconcat.cpp
loctree.o: loctree.cpp
	$(CC) $(CFLAGS) loctree.cpp
mergelists.o: mergelists.cpp
	$(CC) $(CFLAGS) mergelists.cpp
pointerlist.o: pointerlist.cpp
	$(CC) $(CFLAGS) pointerlist.cpp
pointerqueue.o: pointerqueue.cpp
	$(CC) $(CFLAGS) pointerqueue.cpp
preorder.o: preorder.cpp
	$(CC) $(CFLAGS) preorder.cpp
postorder.o: postorder.cpp
	$(CC) $(CFLAGS) postorder.cpp
timing.o: timing.cpp
	$(CC) $(CFLAGS) timing.cpp
lcrstree:main.o lcrstree.o levelorder.o listconcat.o loctree.o mergelists.o pointerlist.o pointerqueue.o preorder.o postorder.o timing.o
	$(CC) $(CFLAGS) main.o lcrstree.o levelorder.o listconcat.o loctree.o mergelists.o pointerlist.o pointerqueue.o preorder.o postorder.o timing.o -o lcrstree
	./lcrstree
	rm ./lcrstree
	rm -rf *o main
levelorder:main.o lcrstree.o levelorder.o listconcat.o loctree.o mergelists.o pointerlist.o pointerqueue.o preorder.o postorder.o timing.o
	$(CC) $(CFLAGS) main.o lcrstree.o levelorder.o listconcat.o loctree.o mergelists.o pointerlist.o pointerqueue.o preorder.o postorder.o timing.o -o levelorder
	./levelorder
	rm ./levelorder
	rm -rf *o main
	
listconcat:main.o lcrstree.o levelorder.o listconcat.o loctree.o mergelists.o pointerlist.o pointerqueue.o preorder.o postorder.o timing.o
	$(CC) $(CFLAGS) main.o lcrstree.o levelorder.o listconcat.o loctree.o mergelists.o pointerlist.o pointerqueue.o preorder.o postorder.o timing.o -o listconcat
	./listconcat
	rm ./listconcat
	rm -rf *o main
mergelists:main.o lcrstree.o levelorder.o listconcat.o loctree.o mergelists.o pointerlist.o pointerqueue.o preorder.o postorder.o timing.o
	$(CC) $(CFLAGS) main.o lcrstree.o levelorder.o listconcat.o loctree.o mergelists.o pointerlist.o pointerqueue.o preorder.o postorder.o timing.o -o mergelists
	./mergelists
	rm ./mergelists
	rm -rf *o main
pointerlist:main.o lcrstree.o levelorder.o listconcat.o loctree.o mergelists.o pointerlist.o pointerqueue.o preorder.o postorder.o timing.o
	$(CC) $(CFLAGS) main.o lcrstree.o levelorder.o listconcat.o loctree.o mergelists.o pointerlist.o pointerqueue.o preorder.o postorder.o timing.o -o pointerlists
	./pointerlists
	rm ./pointerlists
	rm -rf *o main
	
pointerqueue:main.o lcrstree.o levelorder.o listconcat.o loctree.o mergelists.o pointerlist.o pointerqueue.o preorder.o postorder.o timing.o
	$(CC) $(CFLAGS) main.o lcrstree.o levelorder.o listconcat.o loctree.o mergelists.o pointerlist.o pointerqueue.o preorder.o postorder.o timing.o -o pointerqueue
	./pointerqueue
	rm ./pointerqueue
	rm -rf *o main
preorder:main.o lcrstree.o levelorder.o listconcat.o loctree.o mergelists.o pointerlist.o pointerqueue.o preorder.o postorder.o timing.o
	$(CC) $(CFLAGS) main.o lcrstree.o levelorder.o listconcat.o loctree.o mergelists.o pointerlist.o pointerqueue.o preorder.o postorder.o timing.o -o preorder
	./preorder
	rm ./preorder
	rm -rf *o main
postorder:main.o lcrstree.o levelorder.o listconcat.o loctree.o mergelists.o pointerlist.o pointerqueue.o preorder.o postorder.o timing.o 
	$(CC) $(CFLAGS) main.o lcrstree.o levelorder.o listconcat.o loctree.o mergelists.o pointerlist.o pointerqueue.o preorder.o postorder.o timing.o -o postorder
	./postorder
	rm ./postorder
	rm -rf *o main
timing:main.o lcrstree.o levelorder.o listconcat.o loctree.o mergelists.o pointerlist.o pointerqueue.o preorder.o postorder.o timing.o 
	$(CC) $(CFLAGS)main.o lcrstree.o levelorder.o listconcat.o loctree.o mergelists.o pointerlist.o pointerqueue.o preorder.o postorder.o timing.o -o timing
	./timing
	rm ./timing
	rm -rf *o main
clean:
	rm -rf *o main
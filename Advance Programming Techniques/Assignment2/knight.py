#!/usr/bin/python
#aslan oztreves
#11/01/2016


import sys
import random
#Arguments
if( len(sys.argv) != 4):
	print "Need to enter 3 arguments"
	sys.exit()
row=sys.argv[1]
col=sys.argv[2]
attempts=int(sys.argv[3])
rows=int(row)
cols=int(col)
#Variables
board={}
nextposposition=[]
movecounter = 1
difcounter= 0
nextmove =[]
#Function names are self explanatory
def creating_board(rows,cols):
	for r in range(0,rows):
		for c in range(0,cols):
			board.update({(r,c):"x"})
#Creating the board, dict with 2 keys and a value, setting everything to x initally

def printing_board(rows,board):
	rowcount=1
	list = board.keys()
	list.sort()
	for l in list:
		print board[l],
		if rowcount%rows==0:
			print " "+'\n'
		rowcount+=1
	#Printing the board

def possible_moves(board,position,nextposposition,nextmove):
	posmoves =[(1, 2), (1, -2), (-1, 2), (-1, -2),#manuel calculation of possible moves
				  (2, 1), (2, -1), (-2, 1), (-2, -1)]
	for move in posmoves:
		x = position[0] + move[0]
		y = position[1] + move[1]
		if ( x >= rows):
			continue
		elif (x <0):
			continue
		elif (y >= cols):
			continue
		elif (y <0):
			continue
		else:
			nextposposition.append((x,y))
	return nextposposition#all possible avaiable spots

def knight_tour(board,nextposposition,position):
	nextmove = random.choice(nextposposition)#random choice
	if(board[nextmove]=="x"):#if statment for not visiting same square	
		position = nextmove
		global movecounter
		movecounter += 1
		board[position] = movecounter
	return position

if(len(sys.argv) == 4):
	for argv in range(0,attempts):#Looping for number attepmts
		creating_board(rows,cols)
		board[(0,0)] = 1#starting point/first move
		position = [0,0]
	
		nextposposition=possible_moves(board,position,nextposposition,nextmove)
		position=knight_tour(board,nextposposition,position)
		nextposposition=[]
		i = 0
		j = 0
		for j in range(0,len(board)*10000):
			if( nextposposition == []):
				if(movecounter == len(board)):#every square had to be visited for success
					print "Success"
  					printing_board(rows,board)
					break
				
				nextposposition=possible_moves(board,position,nextposposition,nextmove)
				position=knight_tour(board,nextposposition,position)
				nextposposition=[]
		print "Failed"
		printing_board(rows,board)	
		movecounter=1	#refresing the counter


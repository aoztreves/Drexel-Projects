from __future__ import print_function
import random
from random import randrange
import copy
import time


def GetMoves(Player,Board):
	MoveList = []
	for i in range(1,NumRows+1):
		for j in range(1,NumCols+1):
			if Board[i][j] == Player:
				for m in range(-1,2):
					for n in range(-1,2):
						if abs(m) != abs(n):
							if Board[i + m][j + n] == Empty:
								MoveList.append([i,j,i+m,j+n])
	return MoveList

def GetHumanMove(Player,Board):
	
	MoveList = GetMoves(Player,Board)
	Move = None

	while(True):
		FromRow, FromCol, ToRow, ToCol = map(int, \
			input('Input your move (FromRow, FromCol, ToRow, ToCol): ').split(' '))

		ValidMove = False
		if not ValidMove:
			for move in MoveList:
				if move == [FromRow, FromCol, ToRow, ToCol]:
					ValidMove = True
					Move = move
		if ValidMove:
			break
		print('Invalid move.')
	return Move
'''
def ApplyMove(Board,Move):
	FromRow, FromCol, ToRow, ToCol = Move
	Board[ToRow][ToCol] = Board[FromRow][FromCol]
	Board[FromRow][FromCol] = Empty
	return Board
'''
def ApplyMove(Board,Move):
	tempBoard = copy.deepcopy(Board)
	FromRow, FromCol, ToRow, ToCol = Move
	tempBoard[ToRow][ToCol] = tempBoard[FromRow][FromCol]
	tempBoard[FromRow][FromCol] = Empty
	return tempBoard

def InitBoard(Board):
	for i in range(0,BoardRows+1):
		for j in range(0,BoardCols+1):
			Board[i][j] = OutofBounds

	for i in range(1,NumRows+1):
		for j in range(1,NumCols+1):
			Board[i][j] = Empty
	for j in range(1,NumCols+1):
		if odd(j):
			Board[1][j] = x
			Board[NumRows][j] = o
		else:
			Board[1][j] = o
			Board[NumRows][j] = x
def odd(n):
	return n%2 ==1

def ShowBoard(Board):
	print('')
	row_divider = "+" + "-"*(NumCols*4-1) + "+"
	print(row_divider)

	for i in range(1,NumRows+1):
		for j in range(1,NumCols+1):
			if Board[i][j] == x:
				print('| X ', end="")
			elif Board[i][j] == o:
				print('| O ', end="")
			elif Board[i][j] == Empty:
				print('|   ', end="")
		print('|')
		print(row_divider)
	print("")

def Win (Player, Board):
#-------------------------------------------------------------------------
#	Determines if Player has won, by finding '3 in a row'. 
#-------------------------------------------------------------------------
  for i in range(1,NumRows+1):
    for j in range(1,NumCols+1):
      if Board[i][j] == Player:
        if (Board[i][j-1] == Player and Player == Board[i][j+1]):
          return True
        if (Board[i-1][j] == Player and Player == Board[i+1][j]):
          return True
        if (Board[i-1][j+1] == Player and Player == Board[i+1][j-1]):
        	return True
        if (Board[i+1][j+1] == Player and Player == Board[i-1][j-1]):
        	return True
  return False 
def gameisFinished(Board):
	if Win(-1,Board) or Win(1,Board):
		return True
	return False

def checkTieGame(Board):
	tieGame = True
	for i in range(1,NumRows+1):
		for j in range(1,NumCols+1):
			if Board[i][j] != Empty:
				tieGame = True
				continue
			else:
				tieGame = False
				return tieGame
	return tieGame
	
def changePlayer(Player):
  if Player == -1:
    Player = 1
  else:
    Player = -1
  return Player 

def playRandom(Player,Board):
	MoveList = GetMoves(Player,Board)
	k = randrange(0,len(MoveList))
	Move = MoveList[k]
	return Move

def GetComputerMove (Player, Board): 
#-------------------------------------------------------------------------
# If the opponent is a computer, use artificial intelligence to select
# the best move. 
# For this demo, a move is chosen at random from the list of legal moves.
#-------------------------------------------------------------------------
	move = AlphaBetaSearch(Player,Board)
	return move

def AlphaBetaSearch(Player,Board):
	print("Alpha beta search")
	best_score = float('inf')
	best_move = None
	for move in GetMoves(Player,Board):
		#print("Considiring move :" + str(move))
		tempBoard = ApplyMove(Board,move)
		score = MinValue(changePlayer(Player),tempBoard, float('-inf'), float('inf'),1)
		#print("Backed up value: " + str(score))
		if best_move is None or score > best_score:
			best_score = score
			best_move = move
	print("Best Move: " + str(best_move) + " with backedup Value " + str(best_score))
	return best_move

'''
def miniMax(Player,Board):
  #print(Player)
  #best_move = None
  if Player == -1:
  	best_move = None
    best_score = float('-inf')
    for move in GetMoves(Player,Board): 
      tempBoard = ApplyMove(Board,move)
      score = miniMax(changePlayer(Player),Board) 
      best_score = min(best_score,score)
      if best_move is None or score > best_score:
			best_score = score
			best_move = move
    return best_move
  else:
    best_score = float('inf')
    for move in GetMoves(Player,Board):
      tempBoard = ApplyMove(Board,move)
      value = miniMax(changePlayer(Player),Board) 
      best_score = max(best_score,score)
    return best_score
'''
def MaxValue(Player,Board,alpha,beta,depth):
	global MaxDepth
	if depth > MaxDepth:
		return ao428_h(Player,Board)
	if Win(Player,Board) or Win(changePlayer(Player),Board):
		return ao428_h(Player,Board)
	score = float('-inf')
	for move in GetMoves(Player,Board):
		score = max(score, MinValue(changePlayer(Player),ApplyMove(Board,move),alpha,beta,depth+1))
		if score >=beta:
			return score
		alpha = max(alpha, score)
	return score
def MinValue(Player,Board,alpha,beta,depth):
	global MaxDepth
	if depth > MaxDepth:
		return ao428_h(changePlayer(Player),Board)
	if Win(Player,Board) or Win(changePlayer(Player),Board):
		return ao428_h(changePlayer(Player),Board)
	score = float('inf')
	for move in GetMoves(Player,Board):
		score = min(score, MaxValue(changePlayer(Player),ApplyMove(Board,move),alpha,beta,depth+1))
		if score <= alpha:
			return score
		beta = min(beta, score)
	return score
def ao428_h(Player,Board):
	opponent = changePlayer(Player)

	playerScores = {Player: 0, opponent: 0}

	lineScoreMultiplier = 1
	adjecentScoreMultiplier = 2

	for player in playerScores:
		if Win(Player,Board):
			playerScores[Player] = 10000
			continue
		locations = []
		for i in range(1,NumRows+1):
			for j in range(1,NumCols+1):
				if Board[i][j] == player:
					locations.append((i,j))
		best_score = float('-inf')
		for location in locations:
			lineScore = 0
			adjancencyScore = 0
			remainingLocations = copy.deepcopy(locations)
			remainingLocations.remove(location)
			for remainingLocation in remainingLocations:
				if location[0] == remainingLocation[0]:
					if abs(location[1]- remainingLocation[1] == 1):
						adjancencyScore += 1
					lineScore += 1
				elif location[1] == remainingLocation[0]:
					lineScore += 1
					if abs(location[0]- remainingLocation[0]) == 1:
						adjancencyScore += 1
				elif abs(location[0]-remainingLocation[0]) == abs(location[1]-remainingLocation[1]):
					lineScore += 1
					if abs(location[0] - remainingLocation[0]) == 1:
						adjancencyScore += 1
			score = (lineScore*lineScoreMultiplier) + (adjancencyScore*adjecentScoreMultiplier)
			if score > best_score:
				best_score = score
		distance = 0
		originLocation = locations.pop(0)
		for location in locations:
			distance += abs(location[0]-originLocation[0]) + abs(location[1]-originLocation[1])
		finalScore = best_score - distance
		playerScores[Player] = finalScore
	return playerScores[Player] - playerScores[changePlayer(Player)]

if __name__ == "__main__":
	x = -1
	o = 1
	Empty = 0
	OutofBounds = 2
	NumRows = 5
	BoardRows = NumRows + 1
	NumCols = 4
	BoardCols = NumCols + 1
	MaxMoves = 4*NumCols
	NumInPackedBoard = 4 * (BoardRows+1) *(BoardCols+1)
	infinity = 10000
	MaxDepth = 4
	Board = [[0 for col in range(BoardCols+1)] for row in range(BoardRows+1)]
	
	
	while(True):
		i = input("MaxDepth:")
		try:
			MaxDepth = int(i)
			break
		except ValueError:
			print("Must enter an int")
			continue
			
	print("Tic_Tical")
	print("This program is desgined for play agains a  human or for self-play")
	playAgainstComputer = True
	
	while(True):
		i = input("Do you wish to put your own skills against the computer (y/n) ?")
		if i == 'y':
			playAgainstComputer = True
			break
		elif i == 'n':
			break
		print("Invalid input")
	

	player1Name = input("Player 1 name:")
	#player1Name = "Aslan"
	player2Name = "Computer"
	if not playAgainstComputer:
		player2Name = input("Player 2 name:")
	players = {x:None,o:None}
	player1isX = randrange(0,2)
	
	print("")
	print("Max depth = " + str(MaxDepth))
	print("")
	print("Randomizing Order")
	

	print(player1Name + " playes " + ("X" if player1isX else "O"))
	print(player2Name + " playes " + ("O" if player1isX else "X"))

	while(True):
		i = input("Do you wish X or O to go first (x/o) ?")
		if i == 'x':
			player = x
			break
		elif i == 'o':
			player = o
			break
		print("Invalid input")
	
	print("\n The squares of the board are numbered by row and column, with '1 1' ")
	print("in the upper left corner, '1 2' directly to the right of '1 1', etc.")
	print("")
	print("Moves are of the form 'i j m n', where (i,j) is a square occupied")
	print("")
	#print("You move the 'X' pieces. \n")
	
	playerName = (player2Name if not player1isX else player1Name)
	print(playerName + "'s Turn!")
	
	numberofGames = 10
	counter = 0
	computercounter = 0
	randomcounter = 0
	averegeNumberofStates = 0
	AverageTimePassed = 0
	while(counter<numberofGames):
		statecounter = 0
		start_time = time.time()
		InitBoard(Board)
		ShowBoard(Board)
		if playerName == "Computer":
			moveCounter = 0
		else:
			moveCounter = 1
		while(True):
			statecounter += 1	
			if moveCounter%2==0:
				moveCounter += 1
				Move = GetHumanMove(player,Board)
			else:
				moveCounter += 1
				Move = GetComputerMove(player,Board)
			Board = ApplyMove(Board,Move)
			ShowBoard(Board)
			if(Win(player,Board)):
				if player == -1:
					print("X wins")
					break
				else:
					print("O wins")
					break;
			player = changePlayer(player)

		timePassed = time.time()-start_time
		counter += 1
		print("Score :")
		print("Computer : " + str(computercounter))
		print("Random : " + str(randomcounter))
		print("Number of states it took: " + str(statecounter))
		print("Time passed : " + str(timePassed))
		AverageTimePassed += timePassed
		averegeNumberofStates += statecounter
	print("Average number of states : " + str(averegeNumberofStates/10))
	print("Average time for 10 runs in seconds: " + str(AverageTimePassed/10))

 











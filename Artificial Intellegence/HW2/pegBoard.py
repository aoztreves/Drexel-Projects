#!/usr/bin/python
import sys
import random
import time

initialState = 0b1111110111111111 #no peg at position 9
M = 4
N = 4
board = M*N

def goal(state):
	#for i in range(M*N):
	if state == 2**9:
		return True
	return False

def applyRule(rule,state):
	j = (2**rule[0])
	g = (2**rule[1])
	np = (2**rule[2])
	return (state - j - g  + np ) #Calculating the decimal number of state

def preCondition(rule,state):
	j = (2**rule[0])
	g = (2**rule[1])
	np = (2**rule[2])
	if not ((j&state == j) and (g&state==g) and (np&state==0)):
		return False
	jPos = (rule[0]//N,rule[0]%N)
	gPos = (rule[1]//N,rule[1]%N)
	npPos = (rule[2]//N,rule[2]%N)
	#Horizontal
	if (jPos[0] - gPos[0] == 0):
		if (jPos[0] != npPos[0]):
			return False
		if abs(jPos[1] - gPos[1]) != 1:
			return False
		if abs(gPos[1] - npPos[1]) != 1:
			return False
		return True
	#Vertical
	if (jPos[1] - gPos[1])==0:
		if jPos[1] != npPos[1] != 0:
			return False
		if abs(jPos[0] - gPos[0]) != 1:
			return False
		if abs(gPos[0] - npPos[0]) != 1:
			return False
		return True
	#diagonal
	if abs(jPos[0] - gPos[0]) == 1 and abs(jPos[1] - gPos[1]) == 1:
		if abs(gPos[0] - npPos[0]) != 1 or abs(gPos[1] - npPos[1]) != 1:
			return False
		if abs(jPos[0] - npPos[0]) != 2 or abs(jPos[1] - npPos[1]) != 2:
			return False
		return True
	return False
def applicableRules(state):
	result = []
	for j in range(board):
		for g in range(board):
			if g == j:
				continue
			for np in range(board):
				if np == j or np == g:
					continue
				rule = (j,g,np)
				if preCondition(rule,state):
					result.append(rule) # running 3 loops for getting all possible rules, checking them agains the precondition values thus not every rule makes it to the list
	return result
def describeState(state):
	binaryValues = [int(x) for x in bin(state)[2:]] #This gets all the binary numbers
	forCompleting = board - len(binaryValues) #complete by adding missing ones
	forAdding = [0] * forCompleting
	forAdding.extend(binaryValues)
	binaryValues = forAdding
	i = 0
	for n in range(N):
		for m in range(M):
			print("X" if binaryValues[i] else "O",end="") #X or 0 depending on the value
			i += 1
		print("")
	print("-------------------") #easiness to read


def describeRule(rule):
	print('The peg in slot {} jumps over the peg in slot {} and lands in slot {}.'.format(rule[0],rule[1],rule[2])) # Describing what is about to happen

def flailWildly(state):
	currentState = state
	while not goal(currentState): # when state is not the goal continues
		print("currentState:")
		describeState(currentState)
		rulesToChoose = applicableRules(currentState)# getting all applicable rules
		if len(rulesToChoose) == 0: 
			print("Failure") #when no possible moves left
			sys.exit(0)
		chosenRule = random.choice(rulesToChoose)
		print("Chosen rule:")
		describeRule(chosenRule)
		currentState = applyRule(chosenRule,currentState) #appliting the rule

def backTrack(state):
	stateList = [] #initiate all variables
	deadEnd = []
	currentState = state
	backtrackCounter = 0
	print("Starting State:")
	describeState(currentState)
	while not goal(currentState): #when not goal
		if not (currentState in stateList): #to not overflow statelist or duplicates
			stateList.insert(0,currentState)	
		rulesToChoose = applicableRules(currentState)
		if len(rulesToChoose) == 0:
			if currentState in deadEnd:
				stateList.remove(currentState)
				currentState = stateList[0]
				backtrackCounter += 1
				continue
			deadEnd.insert(0,currentState)
			stateList.remove(currentState)
			currentState = stateList[0]
			backtrackCounter += 1
			continue
		chosenRule = random.choice(rulesToChoose)
		if applyRule(chosenRule,currentState) in deadEnd:
			deadEnd.insert(0,currentState)
			stateList.remove(currentState)
			currentState = stateList[0]
			backtrackCounter += 1
			continue
		describeRule(chosenRule)
		describeState(currentState)
		currentState = applyRule(chosenRule,currentState)
		backtrackCounter += 1

	print("Succesfully, Solved!")
	print("Number of Calls:")
	print(backtrackCounter)
	print("Number of failures:")
	print(len(deadEnd))
	print("Solution Path:")
	print(stateList)
	print("Board:")
	describeState(currentState)
	
	

for i in range(3):
	backTrack(initialState)
	time.sleep(10)


#flailWildly(initialState) ##starting the process















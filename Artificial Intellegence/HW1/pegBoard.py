#!/usr/bin/python
import sys
import random

initialState = 65023 # 1111 1101 1111 1111 no peg at position 9
board = {}
results = []

def goal(state):
	if state == 512: # 0000 0010 0000 0000
		return True
	else:
		return False

def applyRule(rule,state):
	return (state - (2**rule[0]) - (2**rule[1]) + (2**rule[2])) #Calculating the decimal number of state

def preCondition(rule,state):
	#rule[0] = int(rule[0],16) #changing all to decimal numbers
	#rule[1] = int(rule[1],16)
	#rule[2] = int(rule[2],16)
	if (rule[0] + 1 == rule[1]) and (rule[1] + 1 == rule[2]):
		return True
	elif (rule[0] - 1 == rule[1]) and (rule[1] - 1 == rule[2]):
		return True
	elif (rule[0] + 4 == rule[1]) and (rule[1] + 4 == rule[2]):
		return True
	elif (rule[0] - 4 == rule[1]) and (rule[1] - 4 ==rule[2]):
		return True
	elif (rule[0] + 3 == rule[1]) and (rule[1] + 3 == rule[2]):
		return True
	elif (rule[0] - 3 == rule[1]) and (rule[1] - 3 == rule[2]):
		return True
	else:
		return False

def applicableRules(state):
	
	for i in range(0,15):
		for j in range(0,15):
			for k in range(0,15):
				rule = [i , j , k]
				if preCondition(rule,state):
					results.append(rule) # running 3 loops for getting all possible rules, checking them agains the precondition values thus not every rule makes it to the list
def creating_board():
	for r in range(0,4):#creating the board
		for c in range(0,4):
			board.update({(r,c):"x"})

#def describeState(state): # didint have time to finish this function

def describeRule(rule):
	print "The peg in slot %s jumps over the peg in slot %s and lands in slot %s" % (rule[0],rule[1],rule[2]) # Describing what is about to happen

def flailWildly(state):
	while not goal(state): # when state is not the goal continues
		applicableRules(state) # getting all applicable rules
		if len(results) == 0: 
			print "Failure" #when no possible moves left
			sys.exit(0)
		for i in range(len(results)): #trying to find goal
			print results
			describeRule(results[i]) #describe rule
			state = applyRule(results[i],state) #appliting the rule
			flailWildly(state) #recursive
	print "Success"


flailWildly(initialState) ##starting the process













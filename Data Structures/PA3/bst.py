#problem3

import collections
import sys 
from math import log 
import random
import Queue

class Node:
	def __init__(self,x):
		self.val = x
		self.left = None
		self.right = None

	def MENBER(self, x): #check if val x is in the tree x: val n: node
		if x == self.val:
			return True
		elif a is None:
			return False
		elif x > self.val:
			return MENBER(x, self.right)
		elif x < self.val:
			return MEMBER(x, self.left)

	def INSERT(self, x): #insert int x to an exsiting node self
		c = 1 #takes 1 step to reach the first node
		while True:
			if (x < self.val) and (self.left == None):
				n = Node(x)
				self.left = n
				return c
			elif (x > self.val) and (self.right == None):
				n = Node(x)
				self.right = n
				return c
			elif x < self.val:
				self = self.left
				c += 1 # counting step it takes to reach the new node
			elif x > self.val:
				self = self.right
				c += 1

	def LEFTMOST_CHILD(n,self):
		while True:
			if self.left == None:
				return n
			else:
				self.left

	def DELETE(x,p): #x is int p is the existing node
		if (p.left == None) or (p.right == None): #terminating condition
			print 'couldnt find the node with val' + str(x)
			return
		if x == p.val: 				#terminating condition
			print 'the function can not delete the current node'
		if x == p.left.val:
			p.left = None
		if x == p.right.val:
			p.right = None
		elif x < p.val:
			return DELETE(x. p.left)
		elif x > p.val:
			return DELETE(x. p.right)

	def locate(x, a, l=0):
		if a is None:
			return None 
		
		elif x > a.element:
			return locate(x, p.right, l+1)
		elif x == a.element:
			return l
		elif x< a.element:
			return locate(x, p.left, l+1)	


####################
count = 0		  # count number of node 
l = [None] * 255 #list is for myself not gonna need it 
bigSum = 0       #initializing my sum of step takin

print 'randomly creting a BST (size 256, 2^6) ....... \n'

n = Node(128)
for i in random.sample(xrange(0,256), 256):
	if i == 128:
		continue
	c = n.INSERT(i) # recording the step to reach a node mising
	l[count] = c
	count += 1
	bigSum += c # incrementing to the sum

print 'BST created\n'
print 'the average step to reach a node: ',
print bigSum / 255.0

# the Queue will print all nodes in level order
# its for me to check if they are right 
'''
q = Queue.Queue()
q.put(n)

while not q.empty():
	if q.queue[0].left != None:
		q.put(q.queue[0].left) #put its child to the que
	if q.queue[0].right != None:
		q.put(q.queue[0].right)
	#print q.queue[0].val
	q.get()
'''
import sys
import Queue

Maxsize = 26
global count
count = 0
class Node:
	"""docstring for Node"""
	def __init__(self,c):
		self.val = c
		self.end = False
		self.next = [None] * Maxsize


def INSERT(n, c): ##insert a alphabet to a node 
	i = ord(c) - 97 #figure out the index
	#print i
	if n.next[i] == None:
		#tmp = Node(c) # make a node
		n.next[i] = Node(c)
	n = n.next[i]
	return n

	
def INSERT2(n,c): #create a word
	i = ord(c) - 97
	if n.next[i] != None:
		n = n.next[i] #move


############
root = Node(None)
tmp = root
# reading file by only charctor 
with open('alice30.txt') as f:
	print 'reading......'
	while True:
  		c = f.read(1)
  		if not c:
  			print "End of file"
  			break
  		if c.isalpha(): # each alphabet reads here
  			c = c.lower()
			tmp = INSERT(tmp, c)
  			#print "Read a character:", c
  		else:
  			tmp = root



#use queue to find every child
q = Queue.Queue()
q.put(root)

while not q.empty():
	for i in range(24):
		if q.queue[0].next[i] != None:
			q.put(q.queue[0].next[i]) #put its child to the que
	q.get()
	count += 1
print '/---------------'
print repr('the size of tries (only alphabets, not including , . ! * \n): ')
print count

'''
print root.next[2].val
print root.next[2].next[0].val
print root.next[2].next[0].next[19].val
#print root.next[19].next[21].val
'''


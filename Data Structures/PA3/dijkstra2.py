#!/usr/bin/python

import heapq
#Using heapq to model priority queues

def dijkstra(adjlst, cost, s, t):
	q = [] #priority queue
	d = {s:0} #Stores the minimal distances
	qd = {} #stores the distance the parent and the vertex
	p = {} #Stores previously visited vertex
	visited = set([s])

	for v in adjlst.get(s, []):
		d[v] = cost[s,v]
		item = [d[v],s,v]
		heapq.heappush(q,item) #push item onto heap
		qd[v] = item

	while q:
		costs, parent, u = heapq.heappop(q)
		#u is the current vertex
		if u not in visited: #Check to see we havent already gone to u
			p[u] = parent #sets u's predecessor vertex
			visited.add(u)
			if u == t: #Check to see if we're at the last vertex
				return p, d[u]
			for v in adjlst.get(u,[]):
				if d.get(v): #Dijkstra algorithm
					if d[v] > (cost[u, v] + d[u]):
						d[v] = cost[u, v] + d[u]
						qd[v][0] = d[v]
						qd[v][1] = u
						heapq._siftdown(q, 0, q.index(qd[v]))
					else:
						d[v] = cost[u,v] + d[u]
						item = [d[v],u,v]
						heapq.heappush(q,item)
						qd[v] = item
	return None

def undirect(cost): #Makes the costs undirected
	ucost = {}
	for k, w in cost.iteritems():
		ucost[k] = w
		ucost[(k[1],k[0])] = w
	return ucost

adjlst = { 1: [2,3,4,5,6],
			  2: [1,3],
			  3: [1,2],
			  4: [1,5],
			  5: [1,4,6],
			  6: [1,5]}
#Values stored in adjacency list, taken from review 2 problem 6

cost = { (1,2): 4,
			(1,3): 1,
			(1,4): 5,
			(1,5): 8,
			(1,6): 10,
			(3,2): 2,
			(4,5): 2,
			(5,6): 1}
#Costs of vertex movements

s = 1
t = 6
cost = undirect(cost)
predecessor, min_cost = dijkstra(adjlst, cost, s, t)
c = t
path = [c]
print "The minimum cost is: ", min_cost
while predecessor.get(c):
	path.insert(0, predecessor[c])
	c = predecessor[c]
print "shortest path: ", path

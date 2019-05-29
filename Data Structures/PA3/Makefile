.PHONY: closedhash, bst, trie, dijkstra2, clean

openhash: 
	@g++ -std=c++11 openhash.cpp -o openhash.o
	@./openhash.o

closedhash: closedhash.py
	@python closedhash.py

bst: bst.py
	@python bst.py

trie: trie.py
	@python trie.py

dijkstra2: dijkstra2.py
	@python dijkstra2.py

floyd: 
	@g++ -std=c++11 floyd.cpp -o floyd.o	
	@./floyd.o

clean:
	@\rm -f *.o

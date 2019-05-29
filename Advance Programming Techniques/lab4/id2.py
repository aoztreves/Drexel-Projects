#!/usr/bin/python
#Aslan Oztreves
#10/12/2016



import sys
sifile= sys.stdin
filen = sys.argv
if len(sys.argv)  == 1:
	sifile
#line = sys.stdin.readline()

dict = { }

line = sifile.readline()
#for arg in sys.argv:
#	print arg
#filen.remove('./id2.py')
#print filen
#print line
while line :

	ID , name = line.split(" ",1)

	dict[ ID ] = name
	
	line = sifile.readline()


#print "list" , sorted(list1)
for x in dict :
   print x, dict[x]

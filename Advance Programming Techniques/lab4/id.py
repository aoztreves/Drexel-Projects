#!/usr/bin/python
#Aslan Oztreves
#10/12/2016


fileName = raw_input("Please input file name ")
readFile = file( fileName , "r" )
#readFile = file( "ids" , "r" )

line = readFile.readline()

list1 = [ ]
dict = { }
while line :

	ID , name = line.split(" ",1)
	
#	list1.append( int(ID) )	

	dict[ ID ] = name

	line = readFile.readline()

#print "list" , sorted(list1)



for x in dict :
	print x, dict[x]


#!/usr/bin/python
#Aslan Oztreves
#10/12/2016



readFile = file( "students.csv" , "r" )

line = readFile.readline()

while line :

   name , numbers  = line.split(",",1)

   n = numbers.split(",")

   s=0

   for x in range(len(n)):
      numero = n[x]
      s = s + int(numero)

   average = ( s / len(n) )
   print name ,average
   line = readFile.readline()

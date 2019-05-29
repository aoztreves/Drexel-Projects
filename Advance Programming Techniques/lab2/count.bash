#!/bin/bash
#count.bash
#Aslan Oztreves
#	09/29/2016


read -p "Do you want to see the script as it executes? (y/[n]) => " debugOn
if [ "$debugOn" == "y" -o "$debugOn" == "Y" ] ; then
	set -x		# very useful switch to the set command
fi

#Commands
#FILES=/home/ao428/*
for Filename in *
	do
#		numofLines=wc -l $Filename
#		numofWords=wc -w $Filename
		echo -n "$Filename "  
		wc -wl < $Filename 

#		echo $numofLines
#		echo $numofWords
done
#filename=./a.out


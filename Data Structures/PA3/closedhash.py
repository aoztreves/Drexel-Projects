#!/usr/bin/python

#Aslan Oztreves

import random
import sys

insertN=0
deleteN=0
counter1=0
counter2=0

#Creating the hash table
def hash_table(x,A):
	sum=0
	for i in range(0,len(x)):
		sum=sum+ord(x[i])
	ht=sum%len(A)
	return ht
#Deleting everything
def MAKENULL(A):
	for i in range(0,len(A)):
		A[i]=''
#Checking if its a member
def MEMBER(x,A):
	if(A[locate(x,A,"member")] == x):
		return True
	else:
		return False
#inserting to the hashtable
def INSERT(x, A):
    global insertN
    if A[locate(x, A, "insert")]==x:
        return
    bucket=locate1(x, A)
    if (A[bucket]=='') or (A[bucket]==None):
        insertN +=1
        A[bucket]=x
    else:
        sys.exit(-1)
#delete a certain one
def DELETE(x,A):
	global deleteN
	bucket=locate(x,A,"delete")
	if(A[bucket]==x):
		deleteN += 1
		A[bucket]=None
def locate(x, A, option):
    global counter1
    global counter2
    first=hash_table(x, A)
    i=0
    while (i<len(A)) and (A[(first+i)%len(A)]!=x) and (A[(first+i)%len(A)]!=''):
        if option=="insert":
            counter1+=1
        elif option=="delete":
            counter2+=1
        i=i+1
    return ((first+i)%len(A))
def locate1(x,A):
    global counter1
    global counter2
    first=hash_table(x,A)
    i=0
    while (i<len(A)) and (A[(first+i)%len(A)]!=x) and (A[(first+i)%len(A)]!='') and (A[(first+i)%len(A)]!=None):
        counter1=counter1+1
        i=i+1
    return ((first+i) %len(A))
def test(elements, buckets):
    global counter1
    global counter2
    global insertN
    global deleteN
    
    #Initialize values of buckets and the words to be hashed, Got this reading the words in the dict from an online resource "stackoverflow"
    bucket=['' for i in xrange(buckets)]
    word_file="/usr/share/dict/words"
    words=open(word_file).read().splitlines()
    
    randWords=[]

    for i in range(0, buckets):
        randWords.append(random.choice(words))

    #Test INSERT
    print "Insert Test"
    for i in range(0, elements):#insert
        INSERT(randWords[i],bucket)
    print "buckets ="
    for i in range(0, len(bucket)):
        print "[",i,"]",bucket[i]

    #Test MEMBER and DELETE
    print "MEMBER/DELETE Test"
    DELETE(randWords[0],bucket)
    print "aslan a member?"
    mem=MEMBER("aslan",bucket)
    print mem, "(should be False)"

    INSERT("aslan", bucket)
    print "after inserting aslan test member again"
    print "'aslan a member?"
    mem=MEMBER("aslan",bucket)
    print mem, "(should be True)"

    print "deleting everything but aslan"
    for i in range(0, elements):
        DELETE(randWords[i],bucket)
    for i in range(0, len(bucket)):
        print "[",i,"]",bucket[i]
    
    #Test MAKENULL
    print "MAKENULL Test"
    MAKENULL(bucket)
    print "buckets = "
  
    for i in range(0, len(bucket)):
        print "[",i,"]",bucket[i]

    #Test average number of probes
    print "AVERAGE Test"
    print "#elements:", elements
    print "#buckets:", buckets
    timing=(float(elements)/float(buckets))
    print "Timing:", timing
    print "probes for inserted:", counter1
    print "probes for deleted:", counter2
    print "inserts:", insertN
    print "deletes:", deleteN
    averageInserts=float(counter1)/float(insertN)
    averageDeletes=float(counter2)/float(deleteN)
    expectedInserts=(1+(1/((1-timing)*(1-timing))))/2
    expectedDeletes=(1+(1/((1-timing))))/2
    print "Average inserts:", averageInserts
    print "Expected average inserts:", expectedInserts
    print "Average deletes:", averageDeletes
    print "Expected deletes:", expectedDeletes
    
    counter1=0
    counter2=0
    insertN=0
    deleteN=0
    

test(3,10)



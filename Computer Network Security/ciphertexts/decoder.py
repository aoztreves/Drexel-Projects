
import string
import time
import binascii
file = []
file.append('ct1.hex')
file.append('ct2.hex')
file.append('ct3.hex')
file.append('ct4.hex')
file.append('ct5.hex')
file.append('ct6.hex')
cipherChar = []
xor12 = []
xor13 = []
xor14 = []
xor15 = []
xor16 = []
xor23 = []
xor24 = []
xor25 = []
xor26 = []
xor34 = []
xor35 = []
xor36 = []
xor45 = []
xor46 = []
xor56 = []

def namestr(obj, namespace):
    return [name for name in namespace if namespace[name] is obj]
def printList(l):
	counter2 = 0
	print(namestr(l, globals()))
	while (counter2 != len(l)):
		print(chr(l[counter2]), end='')
		counter2 += 1
	print("")

def getCombinations():
	counter = 1
	textCounter=0
	while (counter != 120):
		with open(file[0]) as f1:
			for i in range(counter):
				line1 = f1.readline()
			val1 = int(line1[2:],16)
			print(chr(val1),end='')
		with open(file[1]) as f2:
			for j in range(counter):
				line2 = f2.readline()
			val2 = int(line2[2:],16)
		with open(file[2]) as f3:
			for k in range(counter):
				line3 = f3.readline()
			val3 = int(line3[2:],16)
		with open(file[3]) as f4:
			for l in range(counter):
				line4 = f4.readline()
			val4 = int(line4[2:],16)
		with open(file[4]) as f5:
			for m in range(counter):
				line5 = f5.readline()
			val5 = int(line5[2:],16)
		with open(file[5]) as f6:
			for n in range(counter):
				line6 = f6.readline()
			val6 = int(line6[:4],16)

		xor12.append(val1^val2)
		xor13.append(val1^val3)
		xor14.append(val1^val4)
		xor15.append(val1^val5)
		xor16.append(val1^val6)
		xor23.append(val2^val3)
		xor24.append(val2^val4)
		xor25.append(val2^val5)
		xor26.append(val2^val6)
		xor34.append(val3^val4)
		xor35.append(val3^val5)
		xor36.append(val3^val6)
		xor45.append(val4^val5)
		xor46.append(val4^val6)
		xor56.append(val5^val6)
		counter += 1
		
def cipherDrag(list,word):
	for i in range(120):
		xor = (list[i:i+len(word)] ^ ord(word))
		print(xor, end ='')
getCombinations()
cipherDrag(xor12,"Steve")
cipherDrag(xor13,"Steve")
cipherDrag(xor14,"Steve")
cipherDrag(xor15,"Steve")
cipherDrag(xor16,"Steve")


'''
	dra
	chr1 = text[textCounter].encode('utf-8')

	val = int((binascii.hexlify()), 16)
	#print(namestr(l, globals()))
	xor = (xor12[textCounter] ^ val)
	textCounter += 1
	print(xor)
'''


	
'''
printList(xor12)
printList(xor13)
printList(xor14)
printList(xor15)
printList(xor16)
printList(xor23)
printList(xor24)
printList(xor25)
printList(xor26)
printList(xor34)
printList(xor35)
printList(xor36)
printList(xor45)
printList(xor46)
printList(xor56)



with open(file3) as f:
	line = f.readline().strip()	
	while line:
		#print(line)
		asciiLine = chr(int(line[:4],16))
		print(asciiLine,end ='')
		#val1 = int(line[:4],16)
		cipherChar.append(ord(asciiLine))
		#print(asciiLine,end='')
		line = f.readline().strip()
	print("aslan")

with open(file2) as f:
	line = f.readline().strip()	
	while line:
		#print(line)
		asciiLine = chr(int(line[:4],16))
		#val1 = int(line[:4],16)
		cipherChar.append(ord(asciiLine))
		print(asciiLine,end='')
		line = f.readline().strip()
	print("")


		for j in range(10):
		i = 0
		for i in range(len(cipherChar)):
			if cipherChar[i] == 32:
				continue
			cipherChar[i] = cipherChar[i] + 1
			if (chr(cipherChar[0]) in string.ascii_lowercase) or (chr(cipherChar[0]) in string.ascii_uppercase):
				print(chr(cipherChar[i]),end='')
				
		print(j)
	for i in range(128):
		print(cipherChar[i],end=' ')
	print(len(cipherChar))'''

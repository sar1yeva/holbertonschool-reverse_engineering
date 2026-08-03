encrypted_hex = "9E89846A786585866A977D797C8463807C7F6B67848BAB907B698370896B997C797C8D6C6F7E81AE866AB36D7B7F669D7E6A7F96678F9382898263B474"
cipher_bytes = bytes.fromhex(encrypted_hex)

key = "mysecretkey"
key_len = len(key)

flag = []
for i, byte in enumerate(cipher_bytes):
    k1 = ord(key[i % key_len])
    k2 = ord(key[(i + 1) % key_len])

    # 1. Toplamanı tərsinə çeviririk (modulo 256)
    temp = (byte - k2) & 0xFF
    # 2. XOR əməliyyatını tərsinə çeviririk
    orig_char = temp ^ k1

    flag.append(chr(orig_char))

print("FLAG:", "".join(flag))

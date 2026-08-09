exponent = 0x0000ffffffffffff
modulus = 0x0ffffffffffffffb

encrypted = [
    0x6f836cb672d9828e,
    0x699a77a760da96a8,
    0x779872a077db84bc,
    0x6184778c75d182a5,
    0x5f9070ba69da83a8,
    0x61a86dba4fc198a4,
    0x00f763a763c08099
]

key = pow(2, exponent, modulus)

flag = b""

for value in encrypted:
    decrypted = value ^ key
    flag += decrypted.to_bytes(8, "little")

print(flag.decode())

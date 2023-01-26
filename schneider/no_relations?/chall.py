from Crypto.Util.number import long_to_bytes,bytes_to_long,isPrime
from sympy import nextprime
import random
flag = b"flag{######you_wish#######}"

def getPrimes(bitsize):
    r = random.getrandbits(bitsize)
    p, q = r, r
    while not isPrime(p):
        p += random.getrandbits(bitsize//4)
    while not isPrime(q):
        q += random.getrandbits(bitsize//8)
    return p, q

def finalPrimes(p):
    _ = p << 2
    r = nextprime(_)
    return r

p,q = getPrimes(512)
r = finalPrimes(p*q)
n = p * q * r
e = 65537
pt = bytes_to_long(flag)
ct = pow(pt,e,n)
print(f"ciphertext:{ct}")
print(f"n:{n}")
print(f"e:{e}")


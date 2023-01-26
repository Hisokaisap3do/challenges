from Crypto.Util.number import *
def check():
    global cts
    M = ZZ^128
    C = VectorSpaces(FiniteField(2))
    t = [u[:128] for u in cts]
    W = M.submodule(t)
    J = C(W).basis_matrix()
    print(J.ncols(), J.nrows())
    if J.nrows() == len(cts):
        if len(cts) == 64:
            return True
        else:
            return False
    else:
        cts.pop()
        return False
    
def submit(res):
    c.sendlineafter('>', '1')
    payload = long_to_bytes(int(res, 2)).hex()
    print(payload, res)
    c.sendlineafter(':', payload)
    print(c.recvline())

def get_ct():
    c.sendlineafter('> ', '2')
    resp = c.recvline().strip()
    return resp[18:].decode()

def convert(ct):
    return ([0]*8192 + list(map(int, bin(bytes_to_long(bytes.fromhex(ct)))[2:])))[-8192:]

from pwn import *
c = remote('34.132.73.130', 8002)
cts = []
while True:
    ct = convert(get_ct())
    assert len(ct) == 8192
    cts.append(ct)
    if check():
        break

def reverse_bit(st):
    st = st.replace('0', '2').replace('1', '0').replace('2', '1')
    return st

ct = cts[1]
res = ''
for i in tqdm(range(0, len(ct), 128)):
    tmp = ct[i:i+128]  
    M = ZZ^128
    C = VectorSpaces(FiniteField(2))
    t = [u[:128] for u in cts] + [tmp]
    W = M.submodule(t)
    J = C(W).basis_matrix()
    if J.nrows() == 64:
        res += '0'
    else:
        res += '1'
print(res)
submit(res)
submit(reverse_bit(res))

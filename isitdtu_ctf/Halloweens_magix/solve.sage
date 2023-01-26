from struct import pack, unpack


def bytes2matrix(b):
    return [list(map(lambda x: x, list(b[i:i+4]))) for i in range(0, len(b), 4)]


def matrix2bytes(m):
    return b''.join(map(lambda x: b''.join(map(lambda y: pack('!H', y), x)), m))


def m2b(m):
    return bytes([j for i in m for j in i])

def b2m(b):
    T = [unpack("!H", b[i:i+2])[0] for i in range(0, len(b), 2)]
    M = [T[i:i+4] for i in range(0, len(T), 4)]
    return matrix(M)


def main():
    enc = open("flag.png.enc", "rb").read()
    out = open("solve.png", 'wb')

    P = matrix(bytes2matrix(b'\x89PNG\r\n\x1a\n\x00\x00\x00\rIHDR'))
    C = b2m(enc[:32])
    key = P.solve_right(C)

    for i in range(0, len(enc), 16):
        C = b2m(enc[i:i+16])
        out.write(m2b(C * key^-1))


if __name__ == '__main__':
    main()
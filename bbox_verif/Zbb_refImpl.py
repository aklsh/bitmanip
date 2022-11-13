'''
    Python Implementation Functions of RV bitmanip Zbb instructions
    Author: Arjun Menon Vadakkeveedu (ee18b104)
'''

import numpy as np

# Zbb:
def impl_andn(rs1, rs2, XLEN):
    result = rs1 & ~(rs2)
    return result

def impl_orn(rs1, rs2, XLEN):
    result = rs1 | ~(rs2)
    return result

def impl_xnor(rs1, rs2, XLEN):
    result = ~(rs1 ^ rs2)
    return result

def impl_clz(rs1, rs2, XLEN):
    if (rs1 == 0):
        result = XLEN
    else:
        result = XLEN - len(bin(rs1).split('b')[1])
    return result

def impl_clzw(rs1, rs2, XLEN):
    rs1w = np.uint32(rs1)
    if (rs1w == 0):
        result = 32
    else:
        result = 32 - len(bin(rs1w).split('b')[1])
    return result

def impl_ctz(rs1, rs2, XLEN):
    if (rs1 == 0):
        result = XLEN
    else:
        result = len(bin(rs1).split('1')[-1])
    return result

def impl_ctzw(rs1, rs2, XLEN):
    rs1w = np.uint32(rs1)
    if (rs1w == 0):
        result = 32
    else:
        result = len(bin(rs1).split('1')[-1])
    return result

def impl_cpop(rs1, rs2, XLEN):
    result = bin(rs1).count('1')
    return result

def impl_cpopw(rs1, rs2, XLEN):
    rs1w = np.uint32(rs1)
    result = bin(rs1w).count('1')
    return result

def impl_max(rs1, rs2, XLEN):
    if (XLEN == 32):
        if (np.int32(rs1) > np.int32(rs2)):
            result = rs1
        else:
            result = rs2
    else:
        # sys.maxsize = (1 << 63) => int64 results in overflow error when the int is negative (bit 63 = 1)
        sign_rs1 = (rs1 >> 63) & 1
        sign_rs2 = (rs2 >> 63) & 1
        rs1_63 = rs1 & ~(1<<63)
        rs2_63 = rs2 & ~(1<<63)
        if (sign_rs1 and sign_rs2):
            if (rs1_63 > rs2_63):
                result = rs1
            else:
                result = rs2
        elif (sign_rs1 and not(sign_rs2)):
            result = rs2
        elif (not(sign_rs1) and sign_rs2):
            result = rs1
        else:
            result = max(rs1, rs2)
    return result

def impl_maxu(rs1, rs2, XLEN):
    if (XLEN == 32):
        if (np.uint32(rs1) > np.uint32(rs2)):
            result = rs1
        else:
            result = rs2
    else:
        if (np.uint64(rs1) > np.uint64(rs2)):
            result = rs1
        else:
            result = rs2
    return result

def impl_min(rs1, rs2, XLEN):
    if (XLEN == 32):
        if (np.int32(rs1) < np.int32(rs2)):
            result = rs1
        else:
            result = rs2
    else:
        # sys.maxsize = (1 << 63) => int64 results in overflow error when the int is negative (bit 63 = 1)
        sign_rs1 = (rs1 >> 63) & 1
        sign_rs2 = (rs2 >> 63) & 1
        rs1_63 = rs1 & ~(1<<63)
        rs2_63 = rs2 & ~(1<<63)
        if (sign_rs1 and sign_rs2):
            if (rs1_63 < rs2_63):
                result = rs1
            else:
                result = rs2
        elif (sign_rs1 and not(sign_rs2)):
            result = rs1
        elif (not(sign_rs1) and sign_rs2):
            result = rs2
        else:
            result = min(rs1, rs2)
    return result

def impl_minu(rs1, rs2, XLEN):
    if (XLEN == 32):
        if (np.uint32(rs1) < np.uint32(rs2)):
            result = rs1
        else:
            result = rs2
    else:
        if (np.uint64(rs1) < np.uint64(rs2)):
            result = rs1
        else:
            result = rs2
    return result

def impl_sextb(rs1, rs2, XLEN):
    rs1_bin = bin(rs1).split('b')[1]
    rs1Byte_bin = rs1_bin[-8:]
    if (rs1Byte_bin[0] == '1'):
        res_bin = '0b'+'1'*(XLEN - 8) + rs1Byte_bin
    else:
        res_bin = '0b'+'0'*(XLEN - 8) + rs1Byte_bin
    result = int(res_bin, base= 2)
    return result

def impl_sexth(rs1, rs2, XLEN):
    rs1_bin = bin(rs1).split('b')[1]
    rs1HW_bin = rs1_bin[-16:]
    if (rs1HW_bin[0] == '1'):
        res_bin = '0b'+'1'*(XLEN - 16) + rs1HW_bin
    else:
        res_bin = '0b'+'0'*(XLEN - 16) + rs1HW_bin
    result = int(res_bin, base= 2)
    return result

def impl_zexth(rs1, rs2, XLEN):
    result = rs1 & (0xFFFF)
    return result

def impl_rol(rs1, rs2, XLEN):
    if (XLEN == 32):
        shamt = rs2 & 0x1F
        result = (rs1 << shamt) | (rs1 >> (XLEN - shamt))
        result = np.uint32(result)
    else:
        shamt = rs2 & 0x3F
        result = (rs1 << shamt) | (rs1 >> (XLEN - shamt))
    return result

def impl_rolw(rs1, rs2, XLEN):
    rs1w = np.uint32(rs1)
    shamt = rs2 & 0x1F
    # typecast to int32 takes care of sign extension
    result = np.int32((rs1w << shamt) | (rs1w >> (32 - shamt)))
    return result

def impl_ror(rs1, rs2, XLEN):
    if (XLEN == 32):
        shamt = rs2 & 0x1F
        result = (rs1 >> shamt) | (rs1 << (XLEN - shamt))
        result = np.uint32(result)
    else:
        shamt = rs2 & 0x3F
        result = (rs1 >> shamt) | (rs1 << (XLEN - shamt))
    return result

def impl_rori(rs1, rs2, XLEN):
    # shamt = instr[24:20] / instr[25:20]; instr routed in as rs2
    shamt = rs2 >> 20
    if (XLEN == 32):
        shamt = shamt & 0x1F
        result = (rs1 >> shamt) | (rs1 << (XLEN - shamt))
        result = np.uint32(result)
    else:
        shamt = shamt & 0x3F
        result = (rs1 >> shamt) | (rs1 << (XLEN - shamt))
    return result

def impl_roriw(rs1, rs2, XLEN):
    rs1w = np.uint32(rs1)
    shamt = rs2 >> 20
    shamt = shamt & 0x1F
    result = np.int32((rs1w >> shamt) | (rs1w << (32 - shamt)))
    return result

def impl_rorw(rs1, rs2, XLEN):
    rs1w = np.uint32(rs1)
    shamt = rs2 & 0x1F
    # typecast to int32 takes care of sign extension
    result = np.int32((rs1w >> shamt) | (rs1w << (32 - shamt)))
    return result

def impl_orcb(rs1, rs2, XLEN):
    result = 0
    for i in range(0, XLEN, 8):
        currByte = (rs1 >> i) & (0xFF)
        if (currByte != 0):
            result = result | (0xFF) << i
    return result

def impl_rev8(rs1, rs2, XLEN):
    result = 0
    for i in range(0, XLEN, 8):
        currByte = (rs1 >> i) & (0xFF)
        result = (result << 8) | currByte
    return result

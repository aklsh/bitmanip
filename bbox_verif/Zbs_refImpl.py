
'''
    Python Implementation Functions of RV bitmanip Zbs instructions
    Author: Bala Dhinesh (EE19B011)
'''

import numpy as np

# Zbs:
def impl_bclr(rs1, rs2, XLEN):
    if (XLEN == 32):
        index = rs2 & 0x1F
    else:
        index = rs2 & 0x3F
    result = rs1 & ~(1 << index)
    return result

def impl_bclri(rs1, rs2, XLEN):
    index = rs2 >> 20
    if (XLEN == 32):
        index = index & 0x1F
    else:
        index = index & 0x3F
    result = rs1 & ~(1 << index)
    return result

def impl_bext(rs1, rs2, XLEN):
    if (XLEN == 32):
        index = rs2 & 0x1F
    else:
        index = rs2 & 0x3F
    result = (rs1 >> index) & 1
    return result

def impl_bexti(rs1, rs2, XLEN):
    index = rs2 >> 20
    if (XLEN == 32):
        index = index & 0x1F
    else:
        index = index & 0x3F
    result = (rs1 >> index) & 1
    return result

def impl_binv(rs1, rs2, XLEN):
    if (XLEN == 32):
        index = rs2 & 0x1F
    else:
        index = rs2 & 0x3F
    result = rs1 ^ (1 << index)
    return result

def impl_binvi(rs1, rs2, XLEN):
    index = rs2 >> 20
    if (XLEN == 32):
        index = index & 0x1F
    else:
        index = index & 0x3F
    result = rs1 ^ (1 << index)
    return result

def impl_bset(rs1, rs2, XLEN):
    if (XLEN == 32):
        index = rs2 & 0x1F
    else:
        index = rs2 & 0x3F
    result = rs1 | (1 << index)
    return result

def impl_bseti(rs1, rs2, XLEN):
    index = rs2 >> 20
    if (XLEN == 32):
        index = index & 0x1F
    else:
        index = index & 0x3F
    result = rs1 | (1 << index)
    return result

'''
    Python Implementation Functions of RV bitmanip Zbc instructions
    Author: Akilesh Kannan (ee18b122)
'''

import numpy as np

# Zbc:
def impl_clmul(rs1, rs2, XLEN):
    result = 0
    for i in range(XLEN):
        predicate = (rs2 >> i) & 1
        if (predicate):
            result = result ^ (rs1 << i)
    return result

def impl_clmulh(rs1, rs2, XLEN):
    result = 0
    for i in range(XLEN):
        predicate = (rs2 >> i) & 1
        if (predicate):
            result = result ^ (rs1 >> (XLEN - i))
    return result

def impl_clmulr(rs1, rs2, XLEN):
    result = 0
    for i in range(XLEN):
        predicate = (rs2 >> i) & 1
        if (predicate):
            result = result ^ (rs1 >> (XLEN - i - 1))
    return result


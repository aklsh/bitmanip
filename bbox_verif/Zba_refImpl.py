'''
    Python Implementation Functions of RV bitmanip Zba instructions
    Author: Arjun Menon Vadakkeveedu (ee18b104)
'''

import numpy as np

# Zba:
def impl_adduw(rs1, rs2, XLEN):
    # RV64 only
    result = np.uint32(rs1) + rs2
    return result

def impl_sh1add(rs1, rs2, XLEN):
    if (XLEN == 32):
        result = np.int32(np.int32(rs1 << 1) + np.int32(rs2))
    else:
        result = (rs1 << 1) + rs2
    return result

def impl_sh1adduw(rs1, rs2, XLEN):
    result = int(np.uint32(rs1) << 1) + rs2
    return result

def impl_sh2add(rs1, rs2, XLEN):
    if (XLEN == 32):
        result = np.int32(np.int32(rs1 << 2) + np.int32(rs2))
    else:
        result = (rs1 << 2) + rs2
    return result

def impl_sh2adduw(rs1, rs2, XLEN):
    result = int(np.uint32(rs1) << 2) + rs2
    return result

def impl_sh3add(rs1, rs2, XLEN):
    if (XLEN == 32):
        result = np.int32(np.int32(rs1 << 3) + np.int32(rs2))
    else:
        result = (rs1 << 3) + rs2
    return result

def impl_sh3adduw(rs1, rs2, XLEN):
    result = int(np.uint32(rs1) << 3) + rs2
    return result

def impl_slliuw(rs1, rs2, XLEN):
    shamt = rs2 & 0x3F
    result = int(np.uint32(rs1) << shamt)
    return result

#See LICENSE.iitm for license details
'''

Author   : Santhosh Pavan
Email id : santhosh@mindgrovetech.in
Details  : This file consists reference model which is used in verifying the bbox design (DUT).

--------------------------------------------------------------------------------------------------
'''
'''
TODO:
Task Description: Add logic for all instructions. One instruction is implemented as an example. 
                  Note - The value of instr (ANDN) is a temp value, it needed to be changed according to spec.

Note - if instr has single operand, take rs1 as an operand
'''
import numpy as np
def bbox_rm(instr, rs1, rs2, XLEN):
    
    if instr == 1:
        res = rs1 & ~rs2
        valid = '1'

    ## logic for all other instr starts 
    elif instr == 2:
        res = rs1 & ~(1 << (rs2 & 0x1F)) if (XLEN == 32) else rs1 & ~(1 << (rs2 & 0x3F))
        valid = '1'
    elif instr == 3:
        res = (rs1 >> (rs2 & 0x1F)) & 1 if (XLEN == 32) else (rs1 >> (rs2 & 0x3F)) & 1
        valid = '1'
    elif instr == 4:
        res = (rs1 ^ (1 << (rs2 & 0x1F))) if (XLEN == 32) else (rs1 ^ (1 << (rs2 & 0x3F)))
        valid = '1'
    elif instr == 5:
        res = rs1 | (1 << (rs2 & 0x1F)) & 1 if (XLEN == 32) else rs1 | (1 << (rs2 & 0x3F))
        valid = '1'
    elif instr == 22:
        res = np.int32(np.int32(rs1 << 1) + np.int32(rs2)) if (XLEN == 32) else (rs1 << 1) + rs2
        valid = '1'
    elif instr == 23:
        res = np.int32(np.int32(rs1 << 2) + np.int32(rs2)) if XLEN == 32 else (rs1 << 2) + rs2
        valid = '1'
    elif instr == 24:
        res = np.int32(np.int32(rs1 << 3) + np.int32(rs2)) if XLEN == 32 else (rs1 << 3) + rs2
        valid = '1'
    elif instr == 26:
        res = rs1 & ~(1 << ((rs2 >> 20) & 0x1F)) if (XLEN == 32) else rs1 & ~(1 << ((rs2 >> 20) & 0x3F))
        valid = '1'
    elif instr == 27:
        res = (rs1 >> ((rs2 >> 20) & 0x1F)) & 1 if (XLEN == 32) else (rs1 >> ((rs2 >> 20) & 0x3F)) & 1
        valid = '1'
    elif instr == 28:
        res = (rs1 ^ (1 << ((rs2 >> 20) & 0x1F))) & 1 if (XLEN == 32) else (rs1 ^ (1 << ((rs2 >> 20) & 0x3F)))
        valid = '1'
    elif instr == 29:
        res = rs1 | (1 << ((rs2 >> 20) & 0x1F)) & 1 if (XLEN == 32) else rs1 | (1 << ((rs2 >> 20) & 0x3F))
        valid = '1'
    elif instr == 33:
        res = np.uint32(rs1) + rs2
        valid = '1'
    elif instr == 40:
        res = int(np.uint32(rs1) << 1) + rs2
        valid = '1'
    elif instr == 41:
        res = int(np.uint32(rs1) << 2) + rs2
        valid = '1'
    elif instr == 42:
        res = int(np.uint32(rs1) << 3) + rs2
        valid = '1'
    elif instr == 43:
        res = int(np.uint32(rs1) << rs2 & 0x3F)
        valid = '1'
    else:
        res = 0
        valid = '0'

    if XLEN == 32:
        result = '{:032b}'.format(res)
    elif XLEN == 64:
        result = '{:064b}'.format(res)

    return valid+result


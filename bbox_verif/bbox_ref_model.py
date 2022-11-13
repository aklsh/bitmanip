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

from Zba_refImpl import *
from Zbb_refImpl import *
from Zbc_refImpl import *
from Zbs_refImpl import *

#Reference model
def bbox_rm(instr_name, rs1, rs2, XLEN, instr):
	'''
		Python implementation of instruction decoder 
		- use str name associated with instr for case matching
		- impl functions use common function arguments (I/O interface), imm sent in rs2 field if applicable
	'''
	# Zba:
	if instr_name == 'ADDUW':
		res = impl_adduw(rs1, rs2, XLEN)
		valid = '1'
	elif instr_name == 'SH1ADD':
		res = impl_sh1add(rs1, rs2, XLEN)
		valid = '1'
	elif instr_name == 'SH1ADDUW':
		res = impl_sh1adduw(rs1, rs2, XLEN)
		valid = '1'
	elif instr_name == 'SH2ADD':
		res = impl_sh2add(rs1, rs2, XLEN)
		valid = '1'
	elif instr_name == 'SH2ADDUW':
		res = impl_sh2adduw(rs1, rs2, XLEN)
		valid = '1'
	elif instr_name == 'SH3ADD':
		res = impl_sh3add(rs1, rs2, XLEN)
		valid = '1'
	elif instr_name == 'SH3ADDUW':
		res = impl_sh3adduw(rs1, rs2, XLEN)
		valid = '1'
	elif instr_name == 'SLLIUW':
		res = impl_slliuw(rs1, rs2, XLEN)
		valid = '1'
    # Zbb:
	elif instr_name == 'ANDN':
		res = impl_andn(rs1, rs2, XLEN)
		valid = '1'
	elif instr_name == 'ORN':
		res = impl_orn(rs1, rs2, XLEN)
		valid = '1'
	elif instr_name == 'XNOR':
		res = impl_xnor(rs1, rs2, XLEN)
		valid = '1'
	elif instr_name == 'CLZ':
		res = impl_clz(rs1, rs2, XLEN)
		valid = '1'
	elif instr_name == 'CLZW':
		res = impl_clzw(rs1, rs2, XLEN)
		valid = '1'
	elif instr_name == 'CTZ':
		res = impl_ctz(rs1, rs2, XLEN)
		valid = '1'
	elif instr_name == 'CTZW':
		res = impl_ctzw(rs1, rs2, XLEN)
		valid = '1'
	elif instr_name == 'CPOP':
		res = impl_cpop(rs1, rs2, XLEN)
		valid = '1'
	elif instr_name == 'CPOPW':
		res = impl_cpopw(rs1, rs2, XLEN)
		valid = '1'
	elif instr_name == 'MAX':
		res = impl_max(rs1, rs2, XLEN)
		valid = '1'
	elif instr_name == 'MAXU':
		res = impl_maxu(rs1, rs2, XLEN)
		valid = '1'
	elif instr_name == 'MIN':
		res = impl_min(rs1, rs2, XLEN)
		valid = '1'
	elif instr_name == 'MINU':
		res = impl_minu(rs1, rs2, XLEN)
		valid = '1'
	elif instr_name == 'SEXTB':
		res = impl_sextb(rs1, rs2, XLEN)
		valid = '1'
	elif instr_name == 'SEXTH':
		res = impl_sexth(rs1, rs2, XLEN)
		valid = '1'
	elif instr_name == 'ZEXTH':
		res = impl_zexth(rs1, rs2, XLEN)
		valid = '1'
	elif instr_name == 'ROL':
		res = impl_rol(rs1, rs2, XLEN)
		valid = '1'
	elif instr_name == 'ROLW':
		res = impl_rolw(rs1, rs2, XLEN)
		valid = '1'
	elif instr_name == 'ROR':
		res = impl_ror(rs1, rs2, XLEN)
		valid = '1'
	elif instr_name == 'RORI':
		rs2 = instr
		res = impl_rori(rs1, rs2, XLEN)
		valid = '1'
	elif instr_name == 'RORIW':
		rs2 = instr
		res = impl_roriw(rs1, rs2, XLEN)
		valid = '1'
	elif instr_name == 'RORW':
		res = impl_rorw(rs1, rs2, XLEN)
		valid = '1'
	elif instr_name == 'ORCB':
		res = impl_orcb(rs1, rs2, XLEN)
		valid = '1'
	elif instr_name == 'REV8':
		res = impl_rev8(rs1, rs2, XLEN)
		valid = '1'
	# Zbc:
	elif instr_name == 'CLMUL':
		res = impl_clmul(rs1, rs2, XLEN)
		valid = '1'
	elif instr_name == 'CLMULH':
		res = impl_clmulh(rs1, rs2, XLEN)
		valid = '1'
	elif instr_name == 'CLMULR':
		res = impl_clmulr(rs1, rs2, XLEN)
		valid = '1'
	# Zbs:
	elif instr_name == 'BCLR':
		res = impl_bclr(rs1, rs2, XLEN)
		valid = '1'
	elif instr_name == 'BCLRI':
		rs2 = instr
		res = impl_bclri(rs1, rs2, XLEN)
		valid = '1'
	elif instr_name == 'BEXT':
		res = impl_bext(rs1, rs2, XLEN)
		valid = '1'
	elif instr_name == 'BEXTI':
		rs2 = instr
		res = impl_bexti(rs1, rs2, XLEN)
		valid = '1'
	elif instr_name == 'BINV':
		res = impl_binv(rs1, rs2, XLEN)
		valid = '1'
	elif instr_name == 'BINVI':
		rs2 = instr
		res = impl_binvi(rs1, rs2, XLEN)
		valid = '1'
	elif instr_name == 'BSET':
		res = impl_bset(rs1, rs2, XLEN)
		valid = '1'
	elif instr_name == 'BSETI':
		rs2 = instr
		res = impl_bseti(rs1, rs2, XLEN)
		valid = '1'
	## logic for all other instr ends
	else:
		res = 0
		valid = '0'

	if XLEN == 32:
		result = '{:032b}'.format(res % (1<<32))
	elif XLEN == 64:
		result = '{:064b}'.format(res % (1<<64))

	return valid+result


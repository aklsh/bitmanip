/* doc: func: Function to implement ANDN instruction
 * Takes ones complement of second argument and ANDs with first argument
 */
function Bit#(XLEN) fn_andn(Bit#(XLEN) rs1, Bit#(XLEN) rs2);
  return rs1 & ~rs2;
endfunction

/* doc: func: Function to implement ORN instruction
 * Takes ones complement of second argument and ORs with first argument
 */
function Bit#(XLEN) fn_orn(Bit#(XLEN) rs1, Bit#(XLEN) rs2);
  return rs1 | ~rs2;
endfunction

/* doc: func: Function to implement XNOR instruction
 * Returns eXclusive-Not-OR of both arguments
 */
function Bit#(XLEN) fn_xnor(Bit#(XLEN) rs1, Bit#(XLEN) rs2);
  return rs1 ~^ rs2;
endfunction

/* doc: func: Function to implement CLZ instruction
 * Returns number of leading zeros (before first set bit) in the input, from MSB
 */
function UInt#(XLEN) fn_clz(Bit#(XLEN) rs1);
  // zero extend for type compatibility
  return zeroExtend(countZerosMSB(rs1));
endfunction

`ifdef RV64
/* doc: func: Function to implement CLZW instruction
 * Returns number of leading zeros in the least significant word of input
 * Note - only present in RV64B ISA
 */
function UInt#(XLEN) fn_clzw(Bit#(XLEN) rs1);
  Bit#(XLEN_WORD) rs1_lsw = truncate(rs1);
  // zero extend for type compatibility
  return zeroExtend(countZerosMSB(rs1_lsw));
endfunction
`endif

/* doc: func: Function to implement CTZ instruction
 * Returns number of trailing zeros (after last set bit) in the input, from MSB
 */
function UInt#(XLEN) fn_ctz(Bit#(XLEN) rs1);
  // zero extend for type compatibility
  return zeroExtend(countZerosLSB(rs1));
endfunction

`ifdef RV64
/* doc: func: Function to implement CTZW instruction
 * Returns number of trailing zeros in the least significant word of input
 * Note - only present in RV64B ISA
 */
function UInt#(XLEN) fn_ctzw(Bit#(XLEN) rs1);
  Bit#(XLEN_WORD) rs1_lsw = truncate(rs1);
  // zero extend for type compatibility
  return zeroExtend(countZerosLSB(rs1_lsw));
endfunction
`endif

/* doc: func: Function to implement CPOP instruction
 * Returns number of set bits in the input
 */
function UInt#(XLEN) fn_cpop(Bit#(XLEN) rs1);
  return zeroExtend(countOnes(rs1));
endfunction

`ifdef RV64
/* doc: func: Function to implement CPOPW instruction
 * Returns number of set bits in the least significant word of input
 * Note - only present in RV64B ISA
 */
function UInt#(XLEN) fn_cpopw(Bit#(XLEN) rs1);
  Bit#(XLEN_WORD) rs1_lsw = truncate(rs1);
  return zeroExtend(countOnes(rs1_lsw));
endfunction
`endif

/* doc: func: Function to implement MAX instruction
 * Returns the maximum value (signed) among both inputs
 */
function Int#(XLEN) fn_max(Int#(XLEN) rs1, Int#(XLEN) rs2);
  return (rs1 > rs2) ? rs1:rs2;
endfunction

/* doc: func: Function to implement MAXU instruction
 * Returns the maximum value (unsigned) among both inputs
 */
function UInt#(XLEN) fn_maxu(UInt#(XLEN) rs1, UInt#(XLEN) rs2);
  return (rs1 > rs2) ? rs1:rs2;
endfunction

/* doc: func: Function to implement MIN instruction
 * Returns the minimum value (signed) among both inputs
 */
function Int#(XLEN) fn_min(Int#(XLEN) rs1, Int#(XLEN) rs2);
  return (rs1 < rs2) ? rs1:rs2;
endfunction

/* doc: func: Function to implement MINU instruction
 * Returns the minimum value (unsigned) among both inputs
 */
function UInt#(XLEN) fn_minu(UInt#(XLEN) rs1, UInt#(XLEN) rs2);
  return (rs1 < rs2) ? rs1:rs2;
endfunction

/* doc: func: Function to implement ORCB instruction
 * For each byte in the input, if there's at least one set bit in it, the corresponding byte
 * in the output is set to 0xFF. Else, it is set to 0x00.
 */
function Bit#(XLEN) fn_orcb(Bit#(XLEN) rs1);
  Bit#(XLEN) orcbOut = 0;
  Byte currByte;
  UInt#(4) numOnes;

  for(Integer i = 0; i < valueOf(XLEN); i = i+8) begin
    currByte = rs1[i+7:i];
    numOnes = countOnes(currByte);
    if(numOnes > 0)
      orcbOut[i+7:i] = 8'hFF;
    else
      orcbOut[i+7:i] = 8'h00;
  end

  return orcbOut;
endfunction

/* doc: func: Function to implement REV8 instruction
 * Reverse the order of bytes in the input and return the resultant value
 */
function Bit#(XLEN) fn_rev8(Bit#(XLEN) rs1);
  Bit#(XLEN) revOut = 0;
  Byte inByte;

  for(Integer i = 0, Integer j = valueOf(XLEN)-1; i < valueOf(XLEN); i = i+8, j = j-8) begin
    // j is going higher -> lower, so order is j:j-7
    // i is going lower -> higher, so order is i+7:i
    inByte = rs1[j:j-7];
    revOut[i+7:i] = inByte;
  end

  return revOut;
endfunction

/* doc: func: Function to implement ROL instruction
 * Rotate (circular shift) left the input rs1 by the value represented by the least significant
 * log2(XLEN) bits in rs2
 */
function Bit#(XLEN) fn_rol(Bit#(XLEN) rs1, Bit#(XLEN) rs2);
  UInt#(SHAMTLEN) shamt = unpack(rs2[valueOf(SHAMTLEN)-1:0]);
  return (rs1 << shamt) | (rs1 >> (fromInteger(valueOf(XLEN)-1)-(shamt-1)));
endfunction

`ifdef RV64
/* doc: func: Function to implement ROLW instruction
 * Rotate (circular shift) left the input rs1 by the value represented by the least significant
 * 5 bits in rs2
 */
function Bit#(XLEN) fn_rolw(Bit#(XLEN) rs1, Bit#(XLEN) rs2);
  UInt#(SHAMTLEN_WORD) shamt = unpack(rs2[valueOf(SHAMTLEN_WORD)-1:0]);
  Bit#(XLEN_WORD) rs1_lsw = truncate(rs1);
  return signExtend((rs1_lsw << shamt) | (rs1_lsw >> (fromInteger(valueOf(XLEN_WORD)-1)-(shamt-1))));
endfunction
`endif

/* doc: func: Function to implement ROR instruction
 * Rotate (circular shift) right the input rs1 by the value represented by the least significant
 * log2(XLEN) bits in rs2
 */
function Bit#(XLEN) fn_ror(Bit#(XLEN) rs1, Bit#(XLEN) rs2);
  UInt#(SHAMTLEN) shamt = unpack(rs2[valueOf(SHAMTLEN)-1:0]);
  return (rs1 >> shamt) | (rs1 << (fromInteger(valueOf(XLEN)-1)-(shamt-1)));
endfunction

`ifdef RV64
/* doc: func: Function to implement RORW instruction
 * Rotate (circular shift) right the input rs1 by the value represented by the least significant
 * 5 bits in rs2
 */
function Bit#(XLEN) fn_rorw(Bit#(XLEN) rs1, Bit#(XLEN) rs2);
  UInt#(SHAMTLEN_WORD) shamt = unpack(rs2[valueOf(SHAMTLEN_WORD)-1:0]);
  Bit#(XLEN_WORD) rs1_lsw = truncate(rs1);
  return signExtend((rs1_lsw >> shamt) | (rs1_lsw << (fromInteger(valueOf(XLEN_WORD)-1)-(shamt-1))));
endfunction
`endif

/* doc: func: Function to implement RORI instruction
 * Rotate (circular shift) right the input rs1 by the value present in shamt
 */
function Bit#(XLEN) fn_rori(Bit#(XLEN) rs1, UInt#(SHAMTLEN) shamt);
  return (rs1 >> shamt) | (rs1 << (fromInteger(valueOf(XLEN)-1)-(shamt-1)));
endfunction

`ifdef RV64
/* doc: func: Function to implement RORIW instruction
 * Rotate (circular shift) right the least significant word of input rs1 by the value present in shamt
 * The result is sign-extended to XLEN width
 */
function Bit#(XLEN) fn_roriw(Bit#(XLEN) rs1, UInt#(SHAMTLEN_WORD) shamt);
  Bit#(XLEN_WORD) rs1_lsw = truncate(rs1);
  return signExtend((rs1_lsw >> shamt) | (rs1_lsw << (fromInteger(valueOf(XLEN_WORD)-1)-(shamt-1))));
endfunction
`endif

/* doc: func: Function to implement SEXT.B instruction
 * Sign extend the least significant byte in input argument
 */
function Bit#(XLEN) fn_sextb(Bit#(XLEN) rs1);
  return signExtend(rs1[7:0]);
endfunction

/* doc: func: Function to implement SEXT.H instruction
 * Sign extend the least significant half-word in input argument
 */
function Bit#(XLEN) fn_sexth(Bit#(XLEN) rs1);
  return signExtend(rs1[15:0]);
endfunction

/* doc: func: Function to implement ZEXT.H instruction
 * Zero extend the least significant half-word in input argument
 */
function Bit#(XLEN) fn_zexth(Bit#(XLEN) rs1);
  return zeroExtend(rs1[15:0]);
endfunction

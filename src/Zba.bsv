/* doc: func: Function to implement ADDUW instruction
 * Unsigned register rs1 by zero extending it and add to register rs2
 */
function Bit#(XLEN) fn_adduw(Bit#(XLEN) rs1, Bit#(XLEN) rs2);
  Bit#(XLEN) rs1_sext = zeroExtend(rs1[31:0]);
  return rs1_sext + rs2;
endfunction

/* doc: func: Function to implement SH1ADD instruction
 * Shifts register rs1 to the left by 1 bit and add it to register rs2
 */
function Bit#(XLEN) fn_sh1add(Bit#(XLEN) rs1, Bit#(XLEN) rs2);
  return (rs1 << 1) + rs2;
endfunction

/* doc: func: Function to implement SH1ADDUW instruction
 * Unsigned register rs1 by zero extending it and shifting it left by 1 bit and add to register rs2
 */
function Bit#(XLEN) fn_sh1adduw(Bit#(XLEN) rs1, Bit#(XLEN) rs2);
  Bit#(XLEN) rs1_sext = zeroExtend(rs1[31:0]);
  return (rs1_sext << 1) + rs2;
endfunction

/* doc: func: Function to implement SH2ADD instruction
 * Shifts register rs1 to the left by 2 bits and add it to register rs2
 */
function Bit#(XLEN) fn_sh2add(Bit#(XLEN) rs1, Bit#(XLEN) rs2);
  return (rs1 << 2) + rs2;
endfunction

/* doc: func: Function to implement SH2ADDUW instruction
 * Unsigned register rs1 by zero extending it and shifting it left by 2 bits and add to register rs2
 */
function Bit#(XLEN) fn_sh2adduw(Bit#(XLEN) rs1, Bit#(XLEN) rs2);
  Bit#(XLEN) rs1_sext = zeroExtend(rs1[31:0]);
  return (rs1_sext << 2) + rs2;
endfunction

/* doc: func: Function to implement SH3ADD instruction
 * Shifts register rs1 to the left by 3 bits and add it to register rs2
 */
function Bit#(XLEN) fn_sh3add(Bit#(XLEN) rs1, Bit#(XLEN) rs2);
  return (rs1 << 3) + rs2;
endfunction

/* doc: func: Function to implement SH3ADDUW instruction
 * Unsigned register rs1 by zero extending it and shifting it left by 3 bits and add to register rs2
 */
function Bit#(XLEN) fn_sh3adduw(Bit#(XLEN) rs1, Bit#(XLEN) rs2);
  Bit#(XLEN) rs1_sext = zeroExtend(rs1[31:0]);
  return (rs1_sext << 3) + rs2;
endfunction

/* doc: func: Function to implement SLLIUW instruction
 * Takes the least-significant word of rs1, zero-extends it, and shifts it left by the immediate
 */
function Bit#(XLEN) fn_slliuw(Bit#(XLEN) rs1, Bit#(XLEN) rs2);  
  UInt#(SHAMTLEN) shamt = unpack(rs2[valueOf(SHAMTLEN)-1:0]);
  Bit#(XLEN) rs1_sext = zeroExtend(rs1[31:0]);
  return (rs1_sext << shamt);
endfunction
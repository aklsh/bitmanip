/* doc: func: Function to implement BCLR instruction
 * Returns rs1 with a single bit cleared at rs2 by truncating only the lower log2(XLEN) bits of rs2.
 */
function Bit#(XLEN) fn_bclr(Bit#(XLEN) rs1, Bit#(XLEN) rs2);
  UInt#(SHAMTLEN) shamt = unpack(truncate(rs2));
  return rs1 & ~(1 << shamt);
endfunction

/* doc: func: Function to implement BCLRI instruction
 * Returns rs1 with a single bit cleared at shamt by truncating only the lower log2(XLEN) bits of shamt.
 */
function Bit#(XLEN) fn_bclri(Bit#(XLEN) rs1, UInt#(SHAMTLEN) shamt);
  return rs1 & ~(1 << shamt);
endfunction

/* doc: func: Function to implement BEXT instruction
 * Returns only a single bit extracted from rs1 at rs2 by truncating only the lower log2(XLEN) bits of rs2.
 */
function Bit#(XLEN) fn_bext(Bit#(XLEN) rs1, Bit#(XLEN) rs2);
  UInt#(SHAMTLEN) shamt = unpack(truncate(rs2));
  return (rs1 >> shamt) & 1;
endfunction

/* doc: func: Function to implement BEXTI instruction
 * Returns only a single bit extracted from rs1 at shamt by truncating only the lower log2(XLEN) bits of shamt.
 */
function Bit#(XLEN) fn_bexti(Bit#(XLEN) rs1, UInt#(SHAMTLEN) shamt);
  return (rs1 >> shamt) & 1;
endfunction

/* doc: func: Function to implement BINV instruction
 * Returns rs1 with a single bit inverted at rs2 by truncating only the lower log2(XLEN) bits of rs2.
 */
function Bit#(XLEN) fn_binv(Bit#(XLEN) rs1, Bit#(XLEN) rs2);
  UInt#(SHAMTLEN) shamt = unpack(truncate(rs2));
  return rs1 ^ (1 << shamt);
endfunction

/* doc: func: Function to implement BINVI instruction
 * Returns rs1 with a single bit inverted at shamt by truncating only the lower log2(XLEN) bits of shamt.
 */
function Bit#(XLEN) fn_binvi(Bit#(XLEN) rs1, UInt#(SHAMTLEN) shamt);
  return rs1 ^ (1 << shamt);
endfunction

/* doc: func: Function to implement BSET instruction
 * Returns rs1 with a single bit set at rs2 by truncating only the lower log2(XLEN) bits of rs2.
 */
function Bit#(XLEN) fn_bset(Bit#(XLEN) rs1, Bit#(XLEN) rs2);
  UInt#(SHAMTLEN) shamt = unpack(truncate(rs2));
  return rs1 | (1 << shamt);
endfunction

/* doc: func: Function to implement BSETI instruction
 * Returns rs1 with a single bit set at shamt by truncating only the lower log2(XLEN) bits of rs2.
 */
function Bit#(XLEN) fn_bseti(Bit#(XLEN) rs1, UInt#(SHAMTLEN) shamt);
  return rs1 | (1 << shamt);
endfunction

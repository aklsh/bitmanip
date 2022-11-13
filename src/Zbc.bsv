/* doc: func: Function to implement CLMUL instruction
 * Returns the lower half of the carry less multiplication of two XLEN inputs rs1 and rs2.
 */
function Bit#(XLEN) fn_clmul(Bit#(XLEN) rs1, Bit#(XLEN) rs2);
    Bit#(XLEN) clproduct = 0;
    for (Integer i = 0; i < valueOf(XLEN); i = i+1) begin
        // for-loop unrolled in HW, since it is called from within a rule (always block equivalent)
        Bit#(1) predicate = ((rs2 >> i) & 1)[0];
        if (unpack(predicate))
            clproduct = clproduct ^ (rs1 << i);
        else
            // completing else statement to avoid synth issues, if any 
            clproduct = clproduct;
    end
    return clproduct;
endfunction

/* doc: func: Function to implement CLMULH instruction
 * Returns the upper half of the carry less multiplication of two XLEN inputs rs1 and rs2.
 */
function Bit#(XLEN) fn_clmulh(Bit#(XLEN) rs1, Bit#(XLEN) rs2);
    Bit#(XLEN) clproduct = 0;
    for (Integer i = 0; i < valueOf(XLEN); i = i+1) begin
        Bit#(1) predicate = ((rs2 >> i) & 1)[0];
        if (unpack(predicate))
            clproduct = clproduct ^ (rs1 >> (valueOf(XLEN) - i));
        else
            clproduct = clproduct;
    end
    return clproduct;
endfunction

/* doc: func: Function to implement CLMULR instruction
 * Returns the value from bit index 2*XLEN to 2*XLEN-1 of the carry less multiplication of two XLEN inputs rs1 and rs2.
 */
function Bit#(XLEN) fn_clmulr(Bit#(XLEN) rs1, Bit#(XLEN) rs2);
    Bit#(XLEN) clproduct = 0;
    for (Integer i = 0; i < valueOf(XLEN); i = i+1) begin
        Bit#(1) predicate = ((rs2 >> i) & 1)[0];
        if (unpack(predicate))
            clproduct = clproduct ^ (rs1 >> (valueOf(XLEN) - i - 1));
        else
            clproduct = clproduct;
    end
    return clproduct;
endfunction
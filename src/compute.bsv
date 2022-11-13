//See LICENSE.iitm for license details
/*

Author : Mouna Krishna
Email id : mounakrishna@mindgrovetech.in
Details: The top function which calls the required function depending 
         on the instruction.

--------------------------------------------------------------------------------------------------
*/

/****** Imports *******/
`include "bbox.defines"
import bbox_types :: *;
`include "Zba.bsv"
`include "Zbb.bsv"
//`include "Zbc.bsv"
`include "Zbs.bsv"
/*********************/


/*doc: function: The top function where depending on the instruction the 
  required function is called, get the result and return it.
  The input argument and return type should not be changed. 
  Other than this, all the other code can be changed as per needs.

  As an example the instruction ANDN of the Zbb group has been implemented.
  NOTE: The value of ANDN in bbox.defines is a temp value, it needed to be 
  changed according to spec.
  The complete Zbb group and all the other groups is expected to be implemented 
  and verified.
*/
function BBoxOutput fn_compute(BBoxInput inp);
  Bit#(XLEN) result;
  Bool valid;
  case(inp.instr) matches
    // Zba:
    `SH1ADD: begin
      result = fn_sh1add(inp.rs1, inp.rs2);
      valid = True;
    end
    `SH2ADD: begin
      result = fn_sh2add(inp.rs1, inp.rs2);
      valid = True;
    end
    `SH3ADD: begin
      result = fn_sh3add(inp.rs1, inp.rs2);
      valid = True;
    end

    // Zbb:
    `ANDN: begin
      result = fn_andn(inp.rs1, inp.rs2);
      valid = True;
    end

    // Zbc:
    
    // Zbs:
    `BCLR: begin
      result = fn_bclr(inp.rs1, inp.rs2);
      valid = True;
    end
    `BCLRI: begin
      `ifdef RV32
        UInt#(SHAMTLEN) shamt = unpack(inp.instr[24:20]);
      `else
        UInt#(SHAMTLEN) shamt = unpack(inp.instr[25:20]);
      `endif
      result = fn_bclri(inp.rs1, shamt);
      valid = True;
    end
    `BEXT: begin
      result = fn_bext(inp.rs1, inp.rs2);
      valid = True;
    end
    `BEXTI: begin
      `ifdef RV32
        UInt#(SHAMTLEN) shamt = unpack(inp.instr[24:20]);
      `else
        UInt#(SHAMTLEN) shamt = unpack(inp.instr[25:20]);
      `endif
      result = fn_bexti(inp.rs1, shamt);
      valid = True;
    end
    `BINV: begin
      result = fn_binv(inp.rs1, inp.rs2);
      valid = True;
    end
    `BINVI: begin
      `ifdef RV32
        UInt#(SHAMTLEN) shamt = unpack(inp.instr[24:20]);
      `else
        UInt#(SHAMTLEN) shamt = unpack(inp.instr[25:20]);
      `endif
      result = fn_binvi(inp.rs1, shamt);
      valid = True;
    end
    `BSET: begin
      result = fn_bset(inp.rs1, inp.rs2);
      valid = True;
    end
    `BSETI: begin
      `ifdef RV32
        UInt#(SHAMTLEN) shamt = unpack(inp.instr[24:20]);
      `else
        UInt#(SHAMTLEN) shamt = unpack(inp.instr[25:20]);
      `endif
      result = fn_bseti(inp.rs1, shamt);
      valid = True;
    end
`ifdef RV64
    // Zba:
    `ADDUW: begin
      result = fn_adduw(inp.rs1, inp.rs2);
      valid = True;
    end
    `SH1ADDUW: begin
      result = fn_sh1adduw(inp.rs1, inp.rs2);
      valid = True;
    end
    `SH2ADDUW: begin
      result = fn_sh2adduw(inp.rs1, inp.rs2);
      valid = True;
    end
    `SH3ADDUW: begin
      result = fn_sh3adduw(inp.rs1, inp.rs2);
      valid = True;
    end
    `SLLIUW: begin
      result = fn_slliuw(inp.rs1, inp.rs2);
      valid = True;
    end
`endif
    default: begin
      result = 0;
      valid = False;
    end
  endcase
  return BBoxOutput{valid: valid, data: result};
endfunction

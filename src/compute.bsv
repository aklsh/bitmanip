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
  required function is called, get the result and return it. */
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
    `ORN: begin
      result = fn_orn(inp.rs1, inp.rs2);
      valid = True;
    end
    `XNOR: begin
      result = fn_xnor(inp.rs1, inp.rs2);
      valid = True;
    end
    `CLZ: begin
      result = pack(fn_clz(inp.rs1));
      valid = True;
    end
    `CTZ: begin
      result = pack(fn_ctz(inp.rs1));
      valid = True;
    end
    `CPOP: begin
      result = pack(fn_cpop(inp.rs1));
      valid = True;
    end
    `MAX: begin
      result = pack(fn_max(unpack(inp.rs1), unpack(inp.rs2)));
      valid = True;
    end
    `MAXU: begin
      result = pack(fn_maxu(unpack(inp.rs1), unpack(inp.rs2)));
      valid = True;
    end
    `MIN: begin
      result = pack(fn_min(unpack(inp.rs1), unpack(inp.rs2)));
      valid = True;
    end
    `MINU: begin
      result = pack(fn_minu(unpack(inp.rs1), unpack(inp.rs2)));
      valid = True;
    end
    `ORCB: begin
      result = fn_orcb(inp.rs1);
      valid = True;
    end
    `REV8: begin
      result = fn_rev8(inp.rs1);
      valid = True;
    end
    `ROL: begin
      result = fn_rol(inp.rs1, inp.rs2);
      valid = True;
    end
    `ROR: begin
      result = fn_ror(inp.rs1, inp.rs2);
      valid = True;
    end
    `RORI: begin
      `ifdef RV32
        UInt#(SHAMTLEN) shamt = unpack(inp.instr[24:20]);
      `else
        UInt#(SHAMTLEN) shamt = unpack(inp.instr[25:20]);
      `endif
      result = fn_rori(inp.rs1, shamt);
      valid = True;
    end
    `SEXTB: begin
      result = fn_sextb(inp.rs1);
      valid = True;
    end
    `SEXTH: begin
      result = fn_sexth(inp.rs1);
      valid = True;
    end
    `ZEXTH: begin
      result = fn_zexth(inp.rs1);
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
    // Zbb:
    `CLZW: begin
      result = pack(fn_clzw(inp.rs1));
      valid = True;
    end
    `CTZW: begin
      result = pack(fn_ctzw(inp.rs1));
      valid = True;
    end
    `CPOPW: begin
      result = pack(fn_cpopw(inp.rs1));
      valid = True;
    end
    `ROLW: begin
      result = fn_rolw(inp.rs1, inp.rs2);
      valid = True;
    end
    `RORW: begin
      result = fn_rorw(inp.rs1, inp.rs2);
      valid = True;
    end
    `RORIW: begin
      UInt#(SHAMTLEN_WORD) shamt = unpack(inp.instr[24:20]);
      result = fn_roriw(inp.rs1, shamt);
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

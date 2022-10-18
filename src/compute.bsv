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
//`include "Zba.bsv"
`include "Zbb.bsv"
//`include "Zbc.bsv"
//`include "Zbs.bsv"
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
    `ANDN: begin
      result = fn_andn(inp.rs1, inp.rs2);
      valid = True;
    end
    default: begin
      result = 0;
      valid = False;
    end
  endcase
  return BBoxOutput{valid: valid, data: result};
endfunction

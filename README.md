# BitManip Extension project

Students are required to read through the Bit Manipulation Spec by RISC-V and implement it in **Bluespec** and verify it using **cocotb**. The spec pdf is present in docs/bitmanip-1.0.0-38-g865e7a7.pdf .

### The repo structure is as follows:
- bbox.bsv - The top module of the design. Has the interface definition and module definition which calls the BitManip calculation.
- Makefile - Has make commands to generate_verilog and simulate.
- src/ - The directory where the files which the student should edit are present here. The files present are
	- compute.bsv - The top function which selects between the functions implemented for the spec depending on the instruction.
	- bbox.defines - The function which has the macro definition used to select between the instructions.
	- bbox_types.bsv - The structures, enum, bsc macors are defined here.
	- Zbb.bsv - A sample implementation of ANDN instruction is present. It is needed to be completed with all the other required instructions.
- bbox_verif/ - The directory where the scripts required for running the cocotb tests are present. The files present are:
	- test_bbox.py - This file consists cocotb testbench for bbox dut. For more info, check Task description provided in this file.
	- bbox_ref_model.py - This file consists reference model which used in verifying the design (DUT). For more info, check Task description provided in this file.
- docs/ - The directory where the bitmanip spec pdf and instructions for Tool Setup are mentioned.

### Steps to run:
Make sure you have installed all the required tools as mentioned in docs/Tool_setup.pdf and the python environment is activated.

1. To just generate the verilog
```bash
$ make generate_verilog
```
2. To simulate. NOTE: Does both generate_verilog and simulate.
```bash
$ make simulate
```
3. To clean the build.
```bash
$ make clean_build
```

**_NOTE:_** Change BSCDEFINES macro in Makefile to RV64/RV32 according to use.

### More info for Verification

```bash
1. First-time run - $ make simulate
   Subsequent runs - $ make clean_build
   		     $ make simulate
```
```bash
2. To check waveforms, - Once simulation completes, dump.vcd is created in bbox/
    $ gtkwave dump.vcd
```
```bash
3. GTKWave installation -
	$ sudo apt update
	$ sudo apt install gtkwave
```

### Evaluation Criteria:
- Design code (bsv) has to be documented with proper comments and design intent
- Every team member should check-in their code contribution using their own GitLab id for individual evaluation
- Verification code (python) has to be documented with proper comments providing the test case explanation
- A final Report.md should be updated providing the steps to run the tests and the instructions implemented along with test run report.

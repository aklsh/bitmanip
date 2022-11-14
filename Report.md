# RISC-V BitManip ISA Extension

> __Note__
> The version implemented here is `v1.0.0-38-g865e7a7`. The spec pdf is present in docs/bitmanip-1.0.0-38-g865e7a7.pdf.

### The repo structure is as follows:
- `bbox.bsv` - The top module of the design. Has the interface definition and module definition which calls the BitManip calculation.
- `Makefile`
- `src/` - The bluespec design, implementing the BitManip Extension.
	- `compute.bsv` - The top function which selects between the functions implemented for the spec depending on the instruction.
	- `bbox.defines` - Has the macro definitions used to match and select between the instructions.
	- `bbox_types.bsv` - The types, structures, enum, macros used in the design are defined here.
	- `Zba.bsv` - Contains the functions implementing all the instructions (8) that are a part of the `Zba` sub-extension.
    - `Zbb.bsv` - Contains the functions implementing all the instructions (24) that are a part of the `Zbb` sub-extension.
    - `Zbc.bsv` - Contains the functions implementing all the instructions (3) that are a part of the `Zbc` sub-extension.
    - `Zbs.bsv` - Contains the functions implementing all the instructions (8) that are a part of the `Zbs` sub-extension.
- `bbox_verif/` - The directory where the scripts required for running the cocotb tests are present.
	- `test_bbox.py` - This file consists of a cocotb testbench for bbox dut.
	- `bbox_ref_model.py` - This file consists reference model which used in verifying the design (DUT).
    - `instr_fmt.py` - This file is consists a function that randomizes the wildcard bits in each instruction to generate random test vectors for each instruction.
    - `ref_model_impl.py` - This file consists of functions that implement each instruction found in the spec.
- `docs/` - The specification and other miscellaneous docs.

### Steps to run:

> __Note__ Change `BSCDEFINES` macro in Makefile to `RV64` or `RV32` according to use. Also change `base` in [bbox_verif/test_bbox.py](bbox_verif/test_bbox.py) to `RV64` or `RV32`.

> __Warning__ Install python package requirements before simulation: `pip install -r requirements.txt`

1. To just generate the verilog: `make generate_verilog`
2. To simulate: `make sim`
3. To generate verilog and simulate: `make simulate`
4. To clean the build: `make clean_build`

### Design choices
- All reference python implementations in [bbox_verif/ref_model_impl.py](bbox_verif/ref_model_impl.py) have same function prototype to be uniform. If there is no `rs2` requirement in the instruction, the corresponding data - `instr` or `shamt` is passed to the function via `rs2`.
- The verification testbench generates 10 random test cases for each instruction on each run, to make the testbench easily catch corner cases (if any).
    - This is done in [bbox_verif/instr_fmt.py](bbox_verif/instr_fmt.py).

### Work split-up

#### Bluespec Design
| `Zba` | `Zbb` | `Zbc` | `Zbs` |
|:-----:|:-----:|:-----:|:-----:|
| [@BalaDhinesh](https://github.com/BalaDhinesh) | [@aklsh](https://github.com/aklsh) | [@arjunmenonv](https://github.com/arjunmenonv) | [@BalaDhinesh](https://github.com/BalaDhinesh)|

#### cocotb Testbench
| `Zba` | `Zbb` | `Zbc` | `Zbs` |
|:-----:|:-----:|:-----:|:-----:|
| [@arjunmenonv](https://github.com/arjunmenonv) | [@arjunmenonv](https://github.com/arjunmenonv) | [@aklsh](https://github.com/aklsh) | [@BalaDhinesh](https://github.com/BalaDhinesh)|


### Results

#### `RV64`

| **TEST**         | **STATUS** | **SIM TIME (ns)** | **REAL TIME (ns)** | **RATIO (ns/s)** |
|:-----------------|:----------:|------------------:|-------------------:|-----------------:|
| test_bbox.TB_001 |    PASS    |             30.00 |               0.01 |          2912.47 |
| test_bbox.TB_002 |    PASS    |             31.00 |               0.01 |          3355.90 |
| test_bbox.TB_003 |    PASS    |             31.00 |               0.01 |          3644.48 |
| test_bbox.TB_004 |    PASS    |             31.00 |               0.01 |          3705.34 |
| test_bbox.TB_005 |    PASS    |             31.00 |               0.01 |          3686.74 |
| test_bbox.TB_006 |    PASS    |             31.00 |               0.01 |          3619.32 |
| test_bbox.TB_007 |    PASS    |             31.00 |               0.01 |          3625.47 |
| test_bbox.TB_008 |    PASS    |             31.00 |               0.01 |          3628.61 |
| test_bbox.TB_009 |    PASS    |             31.00 |               0.01 |          3849.93 |
| test_bbox.TB_010 |    PASS    |             31.00 |               0.01 |          3851.99 |
| test_bbox.TB_011 |    PASS    |             31.00 |               0.01 |          3963.17 |
| test_bbox.TB_012 |    PASS    |             31.00 |               0.01 |          3998.27 |
| test_bbox.TB_013 |    PASS    |             31.00 |               0.01 |          4007.01 |
| test_bbox.TB_014 |    PASS    |             31.00 |               0.01 |          3984.42 |
| test_bbox.TB_015 |    PASS    |             31.00 |               0.01 |          3924.53 |
| test_bbox.TB_016 |    PASS    |             31.00 |               0.01 |          4066.41 |
| test_bbox.TB_017 |    PASS    |             31.00 |               0.01 |          4031.11 |
| test_bbox.TB_018 |    PASS    |             31.00 |               0.01 |          4031.99 |
| test_bbox.TB_019 |    PASS    |             31.00 |               0.01 |          3820.52 |
| test_bbox.TB_020 |    PASS    |             31.00 |               0.01 |          4155.83 |
| test_bbox.TB_021 |    PASS    |             31.00 |               0.01 |          4139.43 |
| test_bbox.TB_022 |    PASS    |             31.00 |               0.01 |          3975.04 |
| test_bbox.TB_023 |    PASS    |             31.00 |               0.01 |          4049.82 |
| test_bbox.TB_024 |    PASS    |             31.00 |               0.01 |          3953.05 |
| test_bbox.TB_025 |    PASS    |             31.00 |               0.01 |          4056.52 |
| test_bbox.TB_026 |    PASS    |             31.00 |               0.01 |          3966.55 |
| test_bbox.TB_027 |    PASS    |             31.00 |               0.01 |          4040.63 |
| test_bbox.TB_028 |    PASS    |             31.00 |               0.01 |          3999.50 |
| test_bbox.TB_029 |    PASS    |             31.00 |               0.01 |          3996.05 |
| test_bbox.TB_030 |    PASS    |             31.00 |               0.01 |          4151.05 |
| test_bbox.TB_031 |    PASS    |             31.00 |               0.01 |          4027.99 |
| test_bbox.TB_032 |    PASS    |             31.00 |               0.01 |          4118.45 |
| test_bbox.TB_033 |    PASS    |             31.00 |               0.01 |          3945.49 |
| test_bbox.TB_034 |    PASS    |             31.00 |               0.01 |          4051.34 |
| test_bbox.TB_035 |    PASS    |             31.00 |               0.01 |          4145.23 |
| test_bbox.TB_036 |    PASS    |             31.00 |               0.01 |          4017.04 |
| test_bbox.TB_037 |    PASS    |             31.00 |               0.01 |          3857.47 |
| test_bbox.TB_038 |    PASS    |             31.00 |               0.01 |          3951.37 |
| test_bbox.TB_039 |    PASS    |             31.00 |               0.01 |          3910.96 |
| test_bbox.TB_040 |    PASS    |             31.00 |               0.01 |          3923.47 |
| test_bbox.TB_041 |    PASS    |             31.00 |               0.01 |          3887.22 |
| test_bbox.TB_042 |    PASS    |             31.00 |               0.01 |          3997.04 |
| test_bbox.TB_043 |    PASS    |             31.00 |               0.01 |          3985.52 |
| **TESTS=43 PASS=43 FAIL=0 SKIP=0**|     |      **1332.04** |              **0.54** |          **2451.35** |

#### `RV32`

| **TEST**         | **STATUS** | **SIM TIME (ns)** | **REAL TIME (ns)** | **RATIO (ns/s)** |
|:-----------------|:----------:|------------------:|-------------------:|-----------------:|
| test_bbox.TB_001 |    PASS    |             30.00 |               0.01 |          2171.79 |
| test_bbox.TB_002 |    PASS    |             31.00 |               0.01 |          2551.51 |
| test_bbox.TB_003 |    PASS    |             31.00 |               0.01 |          2582.01 |
| test_bbox.TB_004 |    PASS    |             31.00 |               0.01 |          2572.92 |
| test_bbox.TB_005 |    PASS    |             31.00 |               0.01 |          2539.80 |
| test_bbox.TB_006 |    PASS    |             31.00 |               0.01 |          2581.24 |
| test_bbox.TB_007 |    PASS    |             31.00 |               0.01 |          2588.49 |
| test_bbox.TB_008 |    PASS    |             31.00 |               0.01 |          2436.98 |
| test_bbox.TB_009 |    PASS    |             31.00 |               0.01 |          2613.04 |
| test_bbox.TB_010 |    PASS    |             31.00 |               0.01 |          2612.26 |
| test_bbox.TB_011 |    PASS    |             31.00 |               0.01 |          2622.37 |
| test_bbox.TB_012 |    PASS    |             31.00 |               0.01 |          2593.34 |
| test_bbox.TB_013 |    PASS    |             31.00 |               0.01 |          2608.80 |
| test_bbox.TB_014 |    PASS    |             31.00 |               0.01 |          2511.64 |
| test_bbox.TB_015 |    PASS    |             31.00 |               0.01 |          2628.31 |
| test_bbox.TB_016 |    PASS    |             31.00 |               0.01 |          2673.54 |
| test_bbox.TB_017 |    PASS    |             31.00 |               0.01 |          2630.27 |
| test_bbox.TB_018 |    PASS    |             31.00 |               0.01 |          2569.61 |
| test_bbox.TB_019 |    PASS    |             31.00 |               0.01 |          2610.52 |
| test_bbox.TB_020 |    PASS    |             31.00 |               0.01 |          2687.08 |
| test_bbox.TB_021 |    PASS    |             31.00 |               0.01 |          2651.57 |
| test_bbox.TB_022 |    PASS    |             31.00 |               0.01 |          2532.53 |
| test_bbox.TB_023 |    PASS    |             31.00 |               0.01 |          2581.40 |
| test_bbox.TB_024 |    PASS    |             31.00 |               0.01 |          2555.22 |
| test_bbox.TB_025 |    PASS    |             31.00 |               0.01 |          2517.62 |
| test_bbox.TB_026 |    PASS    |             31.00 |               0.01 |          2632.40 |
| test_bbox.TB_027 |    PASS    |             31.00 |               0.01 |          2597.85 |
| test_bbox.TB_028 |    PASS    |             31.00 |               0.01 |          2624.54 |
| test_bbox.TB_029 |    PASS    |             31.00 |               0.01 |          2590.40 |
| test_bbox.TB_030 |    PASS    |             31.00 |               0.01 |          2593.39 |
| test_bbox.TB_031 |    PASS    |             31.00 |               0.01 |          2531.54 |
| test_bbox.TB_032 |    PASS    |             31.00 |               0.01 |          2659.65 |
| **TESTS=32 PASS=32 FAIL=0 SKIP=0**|     |      **991.03** |              **0.64** |          **1567.53** |

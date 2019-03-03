-makelib ies/xil_defaultlib -sv \
  "D:/Vivado2017/Vivado/2017.1/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \
-endlib
-makelib ies/xpm \
  "D:/Vivado2017/Vivado/2017.1/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib ies/blk_mem_gen_v8_3_6 \
  "../../../../../CPU_A/CPU_A.srcs/sources_1/bd/ROM/ipshared/4158/simulation/blk_mem_gen_v8_3.v" \
-endlib
-makelib ies/xil_defaultlib \
  "../../../bd/ROM/ip/ROM_blk_mem_gen_0_0/sim/ROM_blk_mem_gen_0_0.v" \
-endlib
-makelib ies/xlconstant_v1_1_3 \
  "../../../../../CPU_A/CPU_A.srcs/sources_1/bd/ROM/ipshared/45df/hdl/xlconstant_v1_1_vl_rfs.v" \
-endlib
-makelib ies/xil_defaultlib \
  "../../../bd/ROM/ip/ROM_xlconstant_0_0/sim/ROM_xlconstant_0_0.v" \
  "../../../bd/ROM/hdl/ROM.v" \
-endlib
-makelib ies/xil_defaultlib \
  glbl.v
-endlib


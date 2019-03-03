vlib work
vlib msim

vlib msim/xil_defaultlib
vlib msim/xpm
vlib msim/blk_mem_gen_v8_3_6
vlib msim/xlconstant_v1_1_3

vmap xil_defaultlib msim/xil_defaultlib
vmap xpm msim/xpm
vmap blk_mem_gen_v8_3_6 msim/blk_mem_gen_v8_3_6
vmap xlconstant_v1_1_3 msim/xlconstant_v1_1_3

vlog -work xil_defaultlib -64 -sv \
"D:/Vivado2017/Vivado/2017.1/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -64 -93 \
"D:/Vivado2017/Vivado/2017.1/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work blk_mem_gen_v8_3_6 -64 \
"../../../../../CPU_A/CPU_A.srcs/sources_1/bd/ROM/ipshared/4158/simulation/blk_mem_gen_v8_3.v" \

vlog -work xil_defaultlib -64 \
"../../../bd/ROM/ip/ROM_blk_mem_gen_0_0/sim/ROM_blk_mem_gen_0_0.v" \

vlog -work xlconstant_v1_1_3 -64 \
"../../../../../CPU_A/CPU_A.srcs/sources_1/bd/ROM/ipshared/45df/hdl/xlconstant_v1_1_vl_rfs.v" \

vlog -work xil_defaultlib -64 \
"../../../bd/ROM/ip/ROM_xlconstant_0_0/sim/ROM_xlconstant_0_0.v" \
"../../../bd/ROM/hdl/ROM.v" \

vlog -work xil_defaultlib \
"glbl.v"


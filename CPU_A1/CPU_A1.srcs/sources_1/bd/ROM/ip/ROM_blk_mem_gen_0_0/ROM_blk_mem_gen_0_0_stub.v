// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.1 (win64) Build 1846317 Fri Apr 14 18:55:03 MDT 2017
// Date        : Thu Sep 14 15:30:40 2017
// Host        : weiyx-PC running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               E:/VivadoProjects/Ex1/ROM/ROM.srcs/sources_1/bd/ROM/ip/ROM_blk_mem_gen_0_0/ROM_blk_mem_gen_0_0_stub.v
// Design      : ROM_blk_mem_gen_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "blk_mem_gen_v8_3_6,Vivado 2017.1" *)
module ROM_blk_mem_gen_0_0(clka, ena, addra, douta)
/* synthesis syn_black_box black_box_pad_pin="clka,ena,addra[7:0],douta[15:0]" */;
  input clka;
  input ena;
  input [7:0]addra;
  output [15:0]douta;
endmodule

// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.1 (win64) Build 1846317 Fri Apr 14 18:55:03 MDT 2017
// Date        : Thu Sep 14 15:28:52 2017
// Host        : weiyx-PC running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               e:/VivadoProjects/Ex1/ROM/ROM.srcs/sources_1/bd/ROM/ip/ROM_xlconstant_0_0/ROM_xlconstant_0_0_stub.v
// Design      : ROM_xlconstant_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "xlconstant_v1_1_3_xlconstant,Vivado 2017.1" *)
module ROM_xlconstant_0_0(dout)
/* synthesis syn_black_box black_box_pad_pin="dout[0:0]" */;
  output [0:0]dout;
endmodule

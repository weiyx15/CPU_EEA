//Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2017.1 (win64) Build 1846317 Fri Apr 14 18:55:03 MDT 2017
//Date        : Sun Sep 24 16:43:25 2017
//Host        : weiyx-PC running 64-bit major release  (build 9200)
//Command     : generate_target ROM.bd
//Design      : ROM
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "ROM,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=ROM,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=2,numReposBlks=2,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=0,numPkgbdBlks=0,bdsource=USER,synth_mode=OOC_per_IP}" *) (* HW_HANDOFF = "ROM.hwdef" *) 
module ROM
   (address,
    clock,
    q);
  input [7:0]address;
  input clock;
  output [15:0]q;

  wire [7:0]address_1;
  wire [15:0]blk_mem_gen_0_douta;
  wire clock_1;
  wire [0:0]xlconstant_0_dout;

  assign address_1 = address[7:0];
  assign clock_1 = clock;
  assign q[15:0] = blk_mem_gen_0_douta;
  ROM_blk_mem_gen_0_0 blk_mem_gen_0
       (.addra(address_1),
        .clka(clock_1),
        .douta(blk_mem_gen_0_douta),
        .ena(xlconstant_0_dout));
  ROM_xlconstant_0_0 xlconstant_0
       (.dout(xlconstant_0_dout));
endmodule

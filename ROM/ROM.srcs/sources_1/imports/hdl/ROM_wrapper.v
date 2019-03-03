//Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2017.1 (win64) Build 1846317 Fri Apr 14 18:55:03 MDT 2017
//Date        : Thu Sep 14 15:11:18 2017
//Host        : weiyx-PC running 64-bit major release  (build 9200)
//Command     : generate_target ROM_wrapper.bd
//Design      : ROM_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module ROM_wrapper
   (address,
    clock,
    q);
  input [7:0]address;
  input clock;
  output [15:0]q;

  wire [7:0]address;
  wire clock;
  wire [15:0]q;

  ROM ROM_i
       (.address(address),
        .clock(clock),
        .q(q));
endmodule

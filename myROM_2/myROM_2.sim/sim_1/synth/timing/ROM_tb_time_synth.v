// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.1 (win64) Build 1846317 Fri Apr 14 18:55:03 MDT 2017
// Date        : Sun Sep 24 17:23:07 2017
// Host        : weiyx-PC running 64-bit major release  (build 9200)
// Command     : write_verilog -mode timesim -nolib -sdf_anno true -force -file
//               E:/VivadoProjects/Ex1/myROM_2/myROM_2.sim/sim_1/synth/timing/ROM_tb_time_synth.v
// Design      : ROM_2
// Purpose     : This verilog netlist is a timing simulation representation of the design and should not be modified or
//               synthesized. Please ensure that this netlist is used with the corresponding SDF file.
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps
`define XIL_TIMING

(* NotValidForBitStream *)
module ROM_2
   (addr,
    CLK,
    data);
  input [7:0]addr;
  input CLK;
  output [15:0]data;

  wire CLK;
  wire CLK_IBUF;
  wire CLK_IBUF_BUFG;
  wire [7:0]addr;
  wire [7:0]addr_IBUF;
  wire [15:0]data;
  wire \data[0]_i_1_n_0 ;
  wire \data[10]_i_1_n_0 ;
  wire \data[11]_i_1_n_0 ;
  wire \data[12]_i_1_n_0 ;
  wire \data[13]_i_1_n_0 ;
  wire \data[14]_i_1_n_0 ;
  wire \data[15]_i_1_n_0 ;
  wire \data[15]_i_2_n_0 ;
  wire \data[1]_i_1_n_0 ;
  wire \data[3]_i_1_n_0 ;
  wire \data[5]_i_1_n_0 ;
  wire \data[6]_i_1_n_0 ;
  wire \data[7]_i_1_n_0 ;
  wire \data[8]_i_1_n_0 ;
  wire [15:0]data_OBUF;

initial begin
 $sdf_annotate("ROM_tb_time_synth.sdf",,,,"tool_control");
end
  BUFG CLK_IBUF_BUFG_inst
       (.I(CLK_IBUF),
        .O(CLK_IBUF_BUFG));
  IBUF CLK_IBUF_inst
       (.I(CLK),
        .O(CLK_IBUF));
  IBUF \addr_IBUF[0]_inst 
       (.I(addr[0]),
        .O(addr_IBUF[0]));
  IBUF \addr_IBUF[1]_inst 
       (.I(addr[1]),
        .O(addr_IBUF[1]));
  IBUF \addr_IBUF[2]_inst 
       (.I(addr[2]),
        .O(addr_IBUF[2]));
  IBUF \addr_IBUF[3]_inst 
       (.I(addr[3]),
        .O(addr_IBUF[3]));
  IBUF \addr_IBUF[4]_inst 
       (.I(addr[4]),
        .O(addr_IBUF[4]));
  IBUF \addr_IBUF[5]_inst 
       (.I(addr[5]),
        .O(addr_IBUF[5]));
  IBUF \addr_IBUF[6]_inst 
       (.I(addr[6]),
        .O(addr_IBUF[6]));
  IBUF \addr_IBUF[7]_inst 
       (.I(addr[7]),
        .O(addr_IBUF[7]));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT4 #(
    .INIT(16'h0016)) 
    \data[0]_i_1 
       (.I0(addr_IBUF[0]),
        .I1(addr_IBUF[2]),
        .I2(addr_IBUF[3]),
        .I3(addr_IBUF[1]),
        .O(\data[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT4 #(
    .INIT(16'h683A)) 
    \data[10]_i_1 
       (.I0(addr_IBUF[1]),
        .I1(addr_IBUF[3]),
        .I2(addr_IBUF[2]),
        .I3(addr_IBUF[0]),
        .O(\data[10]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT4 #(
    .INIT(16'h7848)) 
    \data[11]_i_1 
       (.I0(addr_IBUF[2]),
        .I1(addr_IBUF[1]),
        .I2(addr_IBUF[3]),
        .I3(addr_IBUF[0]),
        .O(\data[11]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT4 #(
    .INIT(16'h0038)) 
    \data[12]_i_1 
       (.I0(addr_IBUF[2]),
        .I1(addr_IBUF[0]),
        .I2(addr_IBUF[3]),
        .I3(addr_IBUF[1]),
        .O(\data[12]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT4 #(
    .INIT(16'h005E)) 
    \data[13]_i_1 
       (.I0(addr_IBUF[0]),
        .I1(addr_IBUF[2]),
        .I2(addr_IBUF[3]),
        .I3(addr_IBUF[1]),
        .O(\data[13]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT4 #(
    .INIT(16'h0830)) 
    \data[14]_i_1 
       (.I0(addr_IBUF[2]),
        .I1(addr_IBUF[1]),
        .I2(addr_IBUF[3]),
        .I3(addr_IBUF[0]),
        .O(\data[14]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \data[15]_i_1 
       (.I0(addr_IBUF[6]),
        .I1(addr_IBUF[7]),
        .I2(addr_IBUF[5]),
        .I3(addr_IBUF[4]),
        .O(\data[15]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT4 #(
    .INIT(16'h6D3B)) 
    \data[15]_i_2 
       (.I0(addr_IBUF[1]),
        .I1(addr_IBUF[3]),
        .I2(addr_IBUF[2]),
        .I3(addr_IBUF[0]),
        .O(\data[15]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT4 #(
    .INIT(16'h0010)) 
    \data[1]_i_1 
       (.I0(addr_IBUF[0]),
        .I1(addr_IBUF[2]),
        .I2(addr_IBUF[3]),
        .I3(addr_IBUF[1]),
        .O(\data[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT4 #(
    .INIT(16'h2114)) 
    \data[3]_i_1 
       (.I0(addr_IBUF[1]),
        .I1(addr_IBUF[3]),
        .I2(addr_IBUF[2]),
        .I3(addr_IBUF[0]),
        .O(\data[3]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT4 #(
    .INIT(16'h0014)) 
    \data[5]_i_1 
       (.I0(addr_IBUF[3]),
        .I1(addr_IBUF[2]),
        .I2(addr_IBUF[0]),
        .I3(addr_IBUF[1]),
        .O(\data[5]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT4 #(
    .INIT(16'h0004)) 
    \data[6]_i_1 
       (.I0(addr_IBUF[3]),
        .I1(addr_IBUF[0]),
        .I2(addr_IBUF[2]),
        .I3(addr_IBUF[1]),
        .O(\data[6]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h0040)) 
    \data[7]_i_1 
       (.I0(addr_IBUF[3]),
        .I1(addr_IBUF[0]),
        .I2(addr_IBUF[2]),
        .I3(addr_IBUF[1]),
        .O(\data[7]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT4 #(
    .INIT(16'h47A2)) 
    \data[8]_i_1 
       (.I0(addr_IBUF[1]),
        .I1(addr_IBUF[0]),
        .I2(addr_IBUF[3]),
        .I3(addr_IBUF[2]),
        .O(\data[8]_i_1_n_0 ));
  OBUF \data_OBUF[0]_inst 
       (.I(data_OBUF[0]),
        .O(data[0]));
  OBUF \data_OBUF[10]_inst 
       (.I(data_OBUF[10]),
        .O(data[10]));
  OBUF \data_OBUF[11]_inst 
       (.I(data_OBUF[9]),
        .O(data[11]));
  OBUF \data_OBUF[12]_inst 
       (.I(data_OBUF[12]),
        .O(data[12]));
  OBUF \data_OBUF[13]_inst 
       (.I(data_OBUF[13]),
        .O(data[13]));
  OBUF \data_OBUF[14]_inst 
       (.I(data_OBUF[14]),
        .O(data[14]));
  OBUF \data_OBUF[15]_inst 
       (.I(data_OBUF[15]),
        .O(data[15]));
  OBUF \data_OBUF[1]_inst 
       (.I(data_OBUF[1]),
        .O(data[1]));
  OBUF \data_OBUF[2]_inst 
       (.I(data_OBUF[2]),
        .O(data[2]));
  OBUF \data_OBUF[3]_inst 
       (.I(data_OBUF[3]),
        .O(data[3]));
  OBUF \data_OBUF[4]_inst 
       (.I(data_OBUF[4]),
        .O(data[4]));
  OBUF \data_OBUF[5]_inst 
       (.I(data_OBUF[2]),
        .O(data[5]));
  OBUF \data_OBUF[6]_inst 
       (.I(data_OBUF[4]),
        .O(data[6]));
  OBUF \data_OBUF[7]_inst 
       (.I(data_OBUF[7]),
        .O(data[7]));
  OBUF \data_OBUF[8]_inst 
       (.I(data_OBUF[8]),
        .O(data[8]));
  OBUF \data_OBUF[9]_inst 
       (.I(data_OBUF[9]),
        .O(data[9]));
  FDRE #(
    .INIT(1'b0)) 
    \data_reg[0] 
       (.C(CLK_IBUF_BUFG),
        .CE(1'b1),
        .D(\data[0]_i_1_n_0 ),
        .Q(data_OBUF[0]),
        .R(\data[15]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \data_reg[10] 
       (.C(CLK_IBUF_BUFG),
        .CE(1'b1),
        .D(\data[10]_i_1_n_0 ),
        .Q(data_OBUF[10]),
        .R(\data[15]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \data_reg[11] 
       (.C(CLK_IBUF_BUFG),
        .CE(1'b1),
        .D(\data[11]_i_1_n_0 ),
        .Q(data_OBUF[9]),
        .R(\data[15]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \data_reg[12] 
       (.C(CLK_IBUF_BUFG),
        .CE(1'b1),
        .D(\data[12]_i_1_n_0 ),
        .Q(data_OBUF[12]),
        .R(\data[15]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \data_reg[13] 
       (.C(CLK_IBUF_BUFG),
        .CE(1'b1),
        .D(\data[13]_i_1_n_0 ),
        .Q(data_OBUF[13]),
        .R(\data[15]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \data_reg[14] 
       (.C(CLK_IBUF_BUFG),
        .CE(1'b1),
        .D(\data[14]_i_1_n_0 ),
        .Q(data_OBUF[14]),
        .R(\data[15]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \data_reg[15] 
       (.C(CLK_IBUF_BUFG),
        .CE(1'b1),
        .D(\data[15]_i_2_n_0 ),
        .Q(data_OBUF[15]),
        .R(\data[15]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \data_reg[1] 
       (.C(CLK_IBUF_BUFG),
        .CE(1'b1),
        .D(\data[1]_i_1_n_0 ),
        .Q(data_OBUF[1]),
        .R(\data[15]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \data_reg[3] 
       (.C(CLK_IBUF_BUFG),
        .CE(1'b1),
        .D(\data[3]_i_1_n_0 ),
        .Q(data_OBUF[3]),
        .R(\data[15]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \data_reg[5] 
       (.C(CLK_IBUF_BUFG),
        .CE(1'b1),
        .D(\data[5]_i_1_n_0 ),
        .Q(data_OBUF[2]),
        .R(\data[15]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \data_reg[6] 
       (.C(CLK_IBUF_BUFG),
        .CE(1'b1),
        .D(\data[6]_i_1_n_0 ),
        .Q(data_OBUF[4]),
        .R(\data[15]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \data_reg[7] 
       (.C(CLK_IBUF_BUFG),
        .CE(1'b1),
        .D(\data[7]_i_1_n_0 ),
        .Q(data_OBUF[7]),
        .R(\data[15]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \data_reg[8] 
       (.C(CLK_IBUF_BUFG),
        .CE(1'b1),
        .D(\data[8]_i_1_n_0 ),
        .Q(data_OBUF[8]),
        .R(\data[15]_i_1_n_0 ));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif

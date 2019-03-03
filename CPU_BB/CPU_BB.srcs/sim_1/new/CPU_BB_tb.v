`timescale 1ns / 1ns


module CPU_BB_tb;
reg CLK,RESET;

wire myFlag;                    //���Ҽ��������16'h31C0
assign myFlag = (q==16'h31c0)? 1'b1:1'b0;

initial begin
    CLK = 1'b0;
    RESET = 1'b1;
    #2 RESET = 1'b0;
end

wire rst;
assign rst = ~RESET;

always #1 CLK = ~CLK;

wire [7:0] S,data_b;
wire zero,carry_out;

wire JUMP,BRANCH,ALUSRCB,WRITEMEM,WRITEREG,MEMTOREG,REGDES,WRFLAG;
wire [2:0] ALUC;

wire [1:0] N1,N2,ND;
wire [7:0] DI,Q1,Q2;

wire [15:0] q;

wire [7:0] PC;
wire [7:0] imm;

wire [7:0] ramQ;

wire [7:0] Flagin,Flagout;

wire [7:0] addr,Din,Dout,IO0,IO1,IO2,IO3,IO4,IO5,IO6,IO7;
wire RE,WE,io_read,io_write;
assign Flagin = {6'b000_000, zero, carry_out};
assign data_b = ALUSRCB? imm:Q2;
assign imm = q[7:0];
assign DI = MEMTOREG? ramQ:S;
assign N1 = q[11:10];
assign N2 = q[9:8];
assign ND = REGDES? q[7:6]:q[9:8];

ALU myALU(ALUC,Q1,data_b,Flagout[0],zero,carry_out,S);                             // carry_in��carry_out
ctrlunit myCtrlunit
(q[15:12],zero,JUMP,BRANCH,ALUSRCB,WRITEMEM,WRITEREG,MEMTOREG,REGDES,WRFLAG,ALUC);
Register myRegister(N1,N2,ND,DI,CLK,WRITEREG,rst,Q1,Q2);
ROM_2 myROM_2(PC,CLK,q);
PC myPC(BRANCH,JUMP,rst,imm,CLK,PC);
//    RAM myRAM(S,Q2,WRITEMEM,CLK,rst,ramQ);
FLAG myFLAG(Flagin,CLK,rst,WRFLAG,Flagout);
IO_2 myIO_2(S,Q2,RE,WRITEMEM,Dout,io_read,io_write,IO0,IO1,IO2,IO3,IO4,IO5,IO6,IO7);

endmodule

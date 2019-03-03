`timescale 1ns / 1ps

module CPU_A_top(
    input CLK,RESET,carry_in
    );
    
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
    
    assign data_b = ALUSRCB? imm:Q2;
    assign imm = q[7:0];
    assign DI = MEMTOREG? ramQ:S;
    assign N1 = q[11:10];
    assign N2 = q[9:8];
    assign ND = REGDES? q[7:6]:q[9:8];
    
    ALU myALU(ALUC,Q1,data_b,carry_in,zero,carry_out,S);
    ctrlunit myCtrlunit
    (q[15:12],zero,JUMP,BRANCH,ALUSRCB,WRITEMEM,WRITEREG,MEMTOREG,REGDES,WRFLAG,ALUC);
    Register myRegister(N1,N2,ND,DI,CLK,WRITEREG,RESET,Q1,Q2);
    ROM_2 myROM_2(PC,CLK,q);
    PC myPC(BRANCH,JUMP,RESET,imm,CLK,PC);
    RAM myRAM(S,Q2,WRITEMEM,CLK,RESET,ramQ);
    
endmodule

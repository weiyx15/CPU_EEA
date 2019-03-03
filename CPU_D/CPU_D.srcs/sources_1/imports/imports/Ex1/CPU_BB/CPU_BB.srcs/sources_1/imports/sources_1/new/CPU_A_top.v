`timescale 1ns / 1ps

module CPU_A_top(
    input CLK,RESET,
    input [1:0] choose,     //波特率选择拨码
    output [7:0] duan,
    output [3:0] wei,
    input V1,V2,V3,V4,
    output LED_1,LED_ADD,LED_SUB,LED_AND,LED_OR,LED_SLT,LED_EQ,
    output rx,idle,
    output H1,H2,H3,H4
    );
    
    
    //运算符编码参数
    parameter NO_OP = 3'b000;
    parameter PLUS  = 3'b001;
    parameter MINUS = 3'b010;
    parameter AND   = 3'b011;
    parameter OR    = 3'b100;
    parameter CMP   = 3'b101;
    parameter EQ    = 3'b110;
    
    wire rst;                   // 板子上RESET按键是高电平有效
    assign rst = ~RESET;        // 代码里reset是低电平有效
    
    wire [7:0] S,data_b;
    wire zero,carry_out;
    
    wire JUMP,BRANCH,ALUSRCB,WRITEMEM,WRITEREG,MEMTOREG,REGDES,WRFLAG;
    wire [2:0] ALUC;
    
    wire [1:0] N1,N2,ND;
    wire [7:0] DI,Q1,Q2;
    
    wire [15:0] q;
    
    wire [7:0] PC;
    wire [7:0] imm;
    
    wire [7:0] ramQ,outQ,outIO;
    
    wire [7:0] Flagin,Flagout;
    
    wire [7:0] addr,Din,Dout,IO0,IO1,IO2,IO3,IO4,IO5,IO6,IO7;
    wire io_read,io_write;
    
    wire CLK_seg, CLK_CPU, CLK_keyboard;
    
    wire finish;
    
    wire [7:0] data_inH,data_inL;
    

    
    assign Flagin = {6'b000_000, zero, carry_out};
    assign data_b = ALUSRCB? imm:Q2;
    assign imm = q[7:0];
    assign DI = MEMTOREG? ramQ:S;
    assign N1 = q[11:10];
    assign N2 = q[9:8];
    assign ND = REGDES? q[7:6]:q[9:8];
    assign ramQ = (S>=0&&S<8)? outIO:outQ;
    
    assign LED_ADD = (IO7==PLUS&&IO2==1)? 1:0;
    assign LED_SUB = (IO7==MINUS&&IO2==1)? 1:0;
    assign LED_AND = (IO7==AND&&IO2==1)? 1:0;
    assign LED_OR = (IO7==OR&&IO2==1)? 1:0;
    assign LED_SLT = (IO7==CMP&&IO2==1)? 1:0;
    assign LED_EQ = (IO2==3)? 1:0;
    
    
    serial_ctrl mySerail_ctrl(choose,IO2[1:0],CLK,IO3,IO4,IO5,IO6,data_inL,data_inH,IO7,LED_1,rx,idle);
    ALU myALU(ALUC,Q1,data_b,Flagout[0],zero,carry_out,S);                             // carry_in连carry_out
    ctrlunit myCtrlunit
    (q[15:12],zero,JUMP,BRANCH,ALUSRCB,WRITEMEM,WRITEREG,MEMTOREG,REGDES,WRFLAG,ALUC);
    Register myRegister(N1,N2,ND,DI,CLK_CPU,WRITEREG,rst,Q1,Q2);
    ROM_2 myROM_2(PC,CLK_CPU,q);
    PC myPC(BRANCH,JUMP,rst,imm,CLK_CPU,PC);
    RAM myRAM(S,Q2,WRITEMEM,CLK_CPU,rst,outQ);
    FLAG myFLAG(Flagin,CLK_CPU,rst,WRFLAG,Flagout);
    divider myDivider(CLK,CLK_seg,CLK_CPU,CLK_keyboard);
    IO_2 myIO_2(S,Q2,MEMTOREG,WRITEMEM,outIO,io_read,io_write,IO0,IO1,IO2,IO3,IO4,IO5,IO6,IO7);
    seg1 mySeg1(CLK_seg,CLK_CPU,io_write,S,IO1,IO0,data_inH,data_inL,LED_1,wei,duan);
    key_scan_top myKey_scan_top
    (WRITEMEM,S,CLK_keyboard,RESET,V1,V2,V3,V4,H1,H2,H3,H4,IO2[1:0],IO3,IO4,IO5,IO6,IO7,finish);
    
endmodule

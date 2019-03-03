`timescale 1ns / 1ps

module Register(
input [1:0] N1,         //读通道1 的寄存器号
input [1:0] N2,         //读通道2 的寄存器号
input [1:0] ND,         //写通道的寄存器号
input [7:0] DI,         //写通道的输入数据
input CLK,              //时钟脉冲信号，上升沿有效
input REG_WE,           //写允许，为1 时，在CLK 上升沿，将数据DI 写入ND 指定的寄存器；为"0"时，禁止对寄存器阵列进行写操作
input RST,              //异步复位信号，清空所有寄存器的内容

output [7:0] Q1,     //输出N1[1..0]指定寄存器的内容
output [7:0] Q2      //输出N2[1..0]指定寄存器的内容
    );
    
reg [7:0] R[3:0];  //4 个8 位寄存器（分别称为R0、R1、R2、R3，对应的二进制编号分别为00、01、10、11)
integer i;
    
always @(posedge CLK or negedge RST)
if(!RST)
    for(i=0;i<4;i=i+1)
        R[i]<=8'b00;
else
    if(REG_WE)
        R[ND]<=DI;

assign Q1=R[N1];
assign Q2=R[N2];
    


endmodule

`timescale 1ns / 1ps

module FLAG(
input[7:0] Flagin,          //写入标志寄存器的数据，如Carry、Zero等信息,每个标志占1位，共2位，其他6位暂时无用。
input Clk,                  //写时钟脉冲信号，上升沿时，将Flagin上的数据写入Flagout中
input Reset,                //异步复位信号，对标志寄存器内容清零flagout[7..0]=0
input WRFLAG,               //ControlUnit给出的控制写控制信号，为1 时表示需要向标志寄存器写入数据。
//当指令为ADD、SUB、ADDI、ADDC、SUBC 时需要写标志寄存器, 为1，否则为0
output reg [7:0] Flagout   //标志寄存器的数据
  );
  
always @(posedge Clk or negedge Reset)
if(!Reset)
    Flagout<=8'h00;
else
    if(WRFLAG)
        Flagout<=Flagin;
    
endmodule

`timescale 1ns / 1ps
//将ALU分时计算的结果进行处理
//1. 16进制转10进制
//2. 负数转原码


module result_process(
input [7:0] data_H,data_L,
//input carry_out,            // 若data_H[7:4] = 4'hf，结果是负数
//input [2:0] CS,             // 若data_H[7:4] = 4'hf，结果是负数

output [15:0] data_seg,     //输出给数码管显示的BCD码
output LED_1                //接小灯L1，LED_1 = 1表示结果为负
    );
    
    wire [15:0] data_tmp;
    
    assign LED_1 = (data_H[7:4]==4'hf)? 1'b1:1'b0;
    assign data_tmp = LED_1? (~{data_H,data_L}+1):{data_H,data_L};
    
    Binary2BCD myBinary2BCD(data_tmp[11:0],data_seg);
    
endmodule

`timescale 1ns / 1ps


module PC(
    input BRANCH,                   //分支跳转控制信号
    input JUMP,                     //直接跳转控制信号
    input RESET,                    //复位信号
    input [7:0] imm,                //指令中的立即数
    input CLK,                      //时钟信号
    output reg [7:0] PC             //PC 程序指针地址
    );
    
    always @(posedge CLK or negedge RESET)
        if(!RESET)
            PC <= 0;
        else
            if(JUMP)
                PC <= imm;
            else if(BRANCH)
                PC <= imm+PC+1;
            else
                PC <= PC+1;
                
    
endmodule

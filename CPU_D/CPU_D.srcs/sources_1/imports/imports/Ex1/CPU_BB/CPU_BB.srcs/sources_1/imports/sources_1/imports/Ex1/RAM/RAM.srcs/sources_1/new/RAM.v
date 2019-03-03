`timescale 1ns / 1ps

module RAM(
input [7:0] address,            //需要进行读/写操作RAM 单元的地址
input [7:0] data,               //待写入RAM 中的数据
input wren,                     //写允许信号，为1 时写；为0 则读
input clock,                    //时钟脉冲信号，上升沿将数据写入或读出
input aclr,                     //异步复位信号，对q[7..0]进行清0

output reg [7:0] q              //输出address [7..0]指定的RAM 单元的内容
    );

// 0~7给IO，RAM从8开始    
reg [7:0] unit[255:8];
integer i;
initial fork
    for(i=8;i<256;i=i+1)
        unit[i]=8'b0;
join
            
always @(negedge clock or negedge aclr)
if(!aclr)
    q<=8'h00;
else
    if(wren&&address>=8&&address<256)
        unit[address]<=data;
    else if(address>=8&&address<256)
        q<=unit[address];

endmodule

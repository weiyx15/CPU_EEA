`timescale 1ns / 1ps

module IO(
input [7:0] addr,           //地址输入信号
input [7:0] Din,            //写入I/O 端口中的数据信号
input RE,                   //读控制信号, 高电平有效
input WE,                   //写控制信号，高电平有效

output reg [7:0] Dout,     //读I/O 端口时输出的数据信号
output io_read,             //I/O 端口读控制信号，高电平有效，读0x00~0x07 存储单元时有效
output io_write,            //I/O 端口写控制信号，高电平有效，写0x00~0x07 存储单元时有效

inout [7:0] IO0,IO1,IO2,IO3,IO4,IO5,IO6,IO7        //双向I/O 端口0~端口7 的数据信号

    );

reg [7:0] ram[7:0];             //IO0~7的映像寄存器
//integer i;

assign io_read=RE;
assign io_write=WE;

always @(addr,Din,RE,WE)
    if(WE) begin
        ram[addr]=Din;
    end
    else if(RE) begin
        case (addr)
            0: Dout=IO0; 
            1: Dout=IO1;
            2: Dout=IO2;
            3: Dout=IO3;
            4: Dout=IO4;
            5: Dout=IO5;
            6: Dout=IO6;
            7: Dout=IO7;
            default: Dout=8'h00;
        endcase            
    end
        
assign IO0=RE?ram[0]:8'bz;
assign IO1=RE?ram[1]:8'bz;
assign IO2=RE?ram[2]:8'bz;
assign IO3=RE?ram[3]:8'bz;
assign IO4=RE?ram[4]:8'bz;
assign IO5=RE?ram[5]:8'bz;
assign IO6=RE?ram[6]:8'bz;
assign IO7=RE?ram[7]:8'bz;
            
endmodule

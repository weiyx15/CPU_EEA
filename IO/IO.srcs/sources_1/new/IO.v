`timescale 1ns / 1ps

module IO(
input [7:0] addr,           //��ַ�����ź�
input [7:0] Din,            //д��I/O �˿��е������ź�
input RE,                   //�������ź�, �ߵ�ƽ��Ч
input WE,                   //д�����źţ��ߵ�ƽ��Ч

output reg [7:0] Dout,     //��I/O �˿�ʱ����������ź�
output io_read,             //I/O �˿ڶ������źţ��ߵ�ƽ��Ч����0x00~0x07 �洢��Ԫʱ��Ч
output io_write,            //I/O �˿�д�����źţ��ߵ�ƽ��Ч��д0x00~0x07 �洢��Ԫʱ��Ч

inout [7:0] IO0,IO1,IO2,IO3,IO4,IO5,IO6,IO7        //˫��I/O �˿�0~�˿�7 �������ź�

    );

reg [7:0] ram[7:0];             //IO0~7��ӳ��Ĵ���
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

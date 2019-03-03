`timescale 1ns / 1ps

module IO_2(
input [7:0] addr,           //��ַ�����ź�
input [7:0] Din,            //д��I/O �˿��е������ź�
input RE,                   //�������ź�, �ߵ�ƽ��Ч
input WE,                   //д�����źţ��ߵ�ƽ��Ч

output reg [7:0] Dout,     //��I/O �˿�ʱ����������ź�
output io_read,             //I/O �˿ڶ������źţ��ߵ�ƽ��Ч����0x00~0x07 �洢��Ԫʱ��Ч
output io_write,            //I/O �˿�д�����źţ��ߵ�ƽ��Ч��д0x00~0x07 �洢��Ԫʱ��Ч

inout [7:0] IO0,IO1,IO2,IO3,IO4,IO5,IO6,IO7        //˫��I/O �˿�0~�˿�7 �������ź�
    );
    
    reg [7:0] W[7:0];          //IO�˿�ӳ�������ͱ���
    
    assign io_read = ((addr==0)||(addr==1)||(addr==2)||(addr==3)||(addr==4)||(addr==5)||(addr==6)||(addr==7))? RE:0;
    assign io_write = ((addr==0)||(addr==1)||(addr==2)||(addr==3)||(addr==4)||(addr==5)||(addr==6)||(addr==7))? WE:0;
    
    assign IO0 = (io_write==1&&addr==0)? W[0]:8'bz;
    assign IO1 = (io_write==1&&addr==1)? W[1]:8'bz;
    assign IO2 = (io_write==1&&addr==2)? W[2]:8'bz;
    assign IO3 = (io_write==1&&addr==3)? W[3]:8'bz;
    assign IO4 = (io_write==1&&addr==4)? W[4]:8'bz;
    assign IO5 = (io_write==1&&addr==5)? W[5]:8'bz;
    assign IO6 = (io_write==1&&addr==6)? W[6]:8'bz;
    assign IO7 = (io_write==1&&addr==7)? W[7]:8'bz;
 
    
    
//    assign IO0 = (addr==0)? W[0]:8'bz;
//    assign IO1 = (addr==1)? W[1]:8'bz;
//    assign IO2 = (addr==2)? W[2]:8'bz;
//    assign IO3 = (addr==3)? W[3]:8'bz;
//    assign IO4 = (addr==4)? W[4]:8'bz;
//    assign IO5 = (addr==5)? W[5]:8'bz;
//    assign IO6 = (addr==6)? W[6]:8'bz;
//    assign IO7 = (addr==7)? W[7]:8'bz;
    
//    assign W[0] = io_read? IO0:Din;
//    assign W[1] = io_read? IO1:Din;
//    assign W[2] = io_read? IO2:Din;
//    assign W[3] = io_read? IO3:Din;
//    assign W[4] = io_read? IO4:Din;
//    assign W[5] = io_read? IO5:Din;
//    assign W[6] = io_read? IO6:Din;
//    assign W[7] = io_read? IO7:Din;
    always @(io_write)
        if(io_write)
            if(W[addr]!=Din)
                W[addr] <= Din;
//        else if(io_read) begin
//            W[0] <= IO0;
//            W[1] <= IO1;
//            W[2] <= IO2;
//            W[3] <= IO3;
//            W[4] <= IO4;
//            W[5] <= IO5;
//            W[6] <= IO6;
//            W[7] <= IO7;
//        end
    
    always @(io_read)
        if(io_read)
            case(addr)
                0: Dout = IO0;
                1: Dout = IO1;
                2: Dout = IO2;
                3: Dout = IO3;
                4: Dout = IO4;
                5: Dout = IO5;
                6: Dout = IO6;
                7: Dout = IO7;
                
                default: Dout = Dout;
            endcase
                
    
    
endmodule

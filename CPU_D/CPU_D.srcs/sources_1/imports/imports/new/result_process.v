`timescale 1ns / 1ps
//��ALU��ʱ����Ľ�����д���
//1. 16����ת10����
//2. ����תԭ��


module result_process(
input [7:0] data_H,data_L,
//input carry_out,            // ��data_H[7:4] = 4'hf������Ǹ���
//input [2:0] CS,             // ��data_H[7:4] = 4'hf������Ǹ���

output [15:0] data_seg,     //������������ʾ��BCD��
output LED_1                //��С��L1��LED_1 = 1��ʾ���Ϊ��
    );
    
    wire [15:0] data_tmp;
    
    assign LED_1 = (data_H[7:4]==4'hf)? 1'b1:1'b0;
    assign data_tmp = LED_1? (~{data_H,data_L}+1):{data_H,data_L};
    
    Binary2BCD myBinary2BCD(data_tmp[11:0],data_seg);
    
endmodule

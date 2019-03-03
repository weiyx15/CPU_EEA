`timescale 1ns / 1ps

module RAM(
input [7:0] address,            //��Ҫ���ж�/д����RAM ��Ԫ�ĵ�ַ
input [7:0] data,               //��д��RAM �е�����
input wren,                     //д�����źţ�Ϊ1 ʱд��Ϊ0 ���
input clock,                    //ʱ�������źţ������ؽ�����д������
input aclr,                     //�첽��λ�źţ���q[7..0]������0

output reg [7:0] q              //���address [7..0]ָ����RAM ��Ԫ������
    );
    
reg [7:0] unit[255:0];
    
always @(posedge clock or negedge aclr)
if(!aclr)
    q<=8'h00;
else
    if(wren)
        unit[address]<=data;
    else
        q<=unit[address];

endmodule

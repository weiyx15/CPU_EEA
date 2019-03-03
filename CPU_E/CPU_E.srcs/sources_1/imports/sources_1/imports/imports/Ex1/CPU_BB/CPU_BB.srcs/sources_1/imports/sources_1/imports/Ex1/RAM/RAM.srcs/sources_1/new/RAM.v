`timescale 1ns / 1ps

module RAM(
input [7:0] address,            //��Ҫ���ж�/д����RAM ��Ԫ�ĵ�ַ
input [7:0] data,               //��д��RAM �е�����
input wren,                     //д�����źţ�Ϊ1 ʱд��Ϊ0 ���
input clock,                    //ʱ�������źţ������ؽ�����д������
input aclr,                     //�첽��λ�źţ���q[7..0]������0

output reg [7:0] q              //���address [7..0]ָ����RAM ��Ԫ������
    );

// 0~7��IO��RAM��8��ʼ    
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

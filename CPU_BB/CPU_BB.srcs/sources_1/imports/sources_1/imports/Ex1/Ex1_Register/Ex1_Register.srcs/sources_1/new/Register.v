`timescale 1ns / 1ps

module Register(
input [1:0] N1,         //��ͨ��1 �ļĴ�����
input [1:0] N2,         //��ͨ��2 �ļĴ�����
input [1:0] ND,         //дͨ���ļĴ�����
input [7:0] DI,         //дͨ������������
input CLK,              //ʱ�������źţ���������Ч
input REG_WE,           //д����Ϊ1 ʱ����CLK �����أ�������DI д��ND ָ���ļĴ�����Ϊ"0"ʱ����ֹ�ԼĴ������н���д����
input RST,              //�첽��λ�źţ�������мĴ���������

output [7:0] Q1,     //���N1[1..0]ָ���Ĵ���������
output [7:0] Q2      //���N2[1..0]ָ���Ĵ���������
    );
    
reg [7:0] R[3:0];  //4 ��8 λ�Ĵ������ֱ��ΪR0��R1��R2��R3����Ӧ�Ķ����Ʊ�ŷֱ�Ϊ00��01��10��11)
integer i;
    
always @(posedge CLK or negedge RST)
if(!RST)
    for(i=0;i<4;i=i+1)
        R[i]<=8'b00;
else
    if(REG_WE)
        R[ND]<=DI;

assign Q1=R[N1];
assign Q2=R[N2];
    


endmodule

`timescale 1ns / 1ps


module PC(
    input BRANCH,                   //��֧��ת�����ź�
    input JUMP,                     //ֱ����ת�����ź�
    input RESET,                    //��λ�ź�
    input [7:0] imm,                //ָ���е�������
    input CLK,                      //ʱ���ź�
    output reg [7:0] PC             //PC ����ָ���ַ
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

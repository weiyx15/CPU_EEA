`timescale 1ns / 1ps
//���ֻ����͵������ϵ����ַ����ֻ�


module receive_top(
    input [2:0] key,    //����������������
    input clk,          //clk_baud
    input IN,               //FPGA��������������
    input rst,             //���������������
    input enable,           //��������ʹ��
    //�������ʾ
    output [3:0] wei,             
    output [7:0] duan,
    //��������
    output rdsig,           //�����źţ�E19��
    output rdsig_all,       //��λ���������źţ�U16��
    //��������
    output tx,
    output idle             //ϵͳ�Ƿ�ռ���ź�(U19)
    );
    wire clk_sample,clk_baud,clk_seg;
    wire [23:0] command;
    
    
    MultiDeliver myMultiDeliver(
    .key(key),
    .clk(clk_baud),
    .en2(enable),
    .tx(tx),
    .idle(idle)
    );

    
    MultiReceive myMultiReceive(
    .clk(clk_sample),
    .rst(rst),
    .IN(IN),
    .command(command),
    .rdsig(rdsig),
    .rdsig_all(rdsig_all)
    );
    
    seg mySeg(
    .CLK_seg(clk_seg),
    .data_inH(command[23:16]),
    .data_inL(command[7:0]),
    .seg_sel(wei),
    .data_out(duan)
    );
    
    
    serial_divider mySerialDivider(
    .clk(clk),
    .rst(rst),
    .clk_sample(clk_sample),
    .clk_seg(clk_seg),
    .clk_baud(clk_baud)
    );
    
endmodule

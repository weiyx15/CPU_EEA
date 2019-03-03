`timescale 1ns / 1ps
//���ֻ����͵������ϵ����ַ����ֻ�


module serial_top(
    input [14:0] key1,    //����������������
    input [26:0] key2,  //����������������
    input LED_1,
    input clk_baud,          
    input enable1,enable2,           //��������ʹ��
    //��������
    output rx,
    output idle             //ϵͳ�Ƿ�ռ���ź�(U19)
    );
    
    
    MultiDeliver myMultiDeliver(
    .key1(key1),
    .key2(key2),
    .LED_1(LED_1),
    .clk(clk_baud),
    .en2_1(enable1),
    .en2_2(enable2),
    .tx(rx),
    .idle(idle)
    );
    
    
endmodule

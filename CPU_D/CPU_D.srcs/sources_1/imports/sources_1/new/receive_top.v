`timescale 1ns / 1ps
//将手机发送到蓝牙上的数字发回手机


module serial_top(
    input [14:0] key1,    //蓝牙发送数据输入
    input [26:0] key2,  //蓝牙发送数据输入
    input LED_1,
    input clk_baud,          
    input enable1,enable2,           //蓝牙发送使能
    //蓝牙发送
    output rx,
    output idle             //系统是否占用信号(U19)
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

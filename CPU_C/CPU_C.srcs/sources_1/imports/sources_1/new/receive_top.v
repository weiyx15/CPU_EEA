`timescale 1ns / 1ps
//将手机发送到蓝牙上的数字发回手机


module receive_top(
    input [2:0] key,    //蓝牙发送数据输入
    input clk,          //clk_baud
    input IN,               //FPGA从蓝牙读入数据
    input rst,             //蓝牙接受数据清空
    input enable,           //蓝牙发送使能
    //数码管显示
    output [3:0] wei,             
    output [7:0] duan,
    //蓝牙接收
    output rdsig,           //握手信号（E19）
    output rdsig_all,       //多位接收握手信号（U16）
    //蓝牙发送
    output tx,
    output idle             //系统是否占用信号(U19)
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

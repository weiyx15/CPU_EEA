`timescale 1ns / 1ps

//EDA3音乐计算器：键盘识别标标准接口电路
module key_scan_top(
    input io_write,
    input [7:0] addr,
    
    input CLK,                      //50Hz键盘扫描时钟
    input RESET,                    //FPGA板上的T5按键，高电平有效
    input V1,V2,V3,V4,              //对应col[3:0]，列线电平输入
    output H1,H2,H3,H4,             //对应row[3:0]，行线扫描电平输出
    inout [1:0] STATE,                  //用于汇编指令控制的状态信号
    inout [7:0] SRCL,                 //第一个数据SRC的高8位
    inout [7:0] SRCH,                 //第一个数据SRC的低8位
    inout [7:0] DSTL,                 //第二个数据DST的高8位
    inout [7:0] DSTH,                 //第二个数据DST的低8位
    inout [7:0] ALU_OP,               //运算符编码
    output finish                     //表示接收到"="
    

    );
    
    wire [7:0] srch,srcl,dsth,dstl,alu_op;
    wire [1:0] state;
    assign STATE = (io_write&&addr==2)? 8'bz:state;
    assign SRCL = (io_write&&addr==3)? 8'bz:srcl;
    assign SRCH = (io_write&&addr==4)? 8'bz:srch;
    assign DSTL = (io_write&&addr==5)? 8'bz:dstl;
    assign DSTH = (io_write&&addr==6)? 8'bz:dsth;
    assign ALU_OP = (io_write&&addr==7)? 8'bz:alu_op;
    
    //运算符编码参数
    parameter NO_OP = 3'b000;
    parameter PLUS  = 3'b001;
    parameter MINUS = 3'b010;
    parameter AND   = 3'b011;
    parameter OR    = 3'b100;
    parameter CMP   = 3'b101;
    
    
    wire key_pressed_flag;
    wire [3:0] val;  

    
    //例化子模块    
    keyboard_ myKeyboard_(
    .clk(CLK),
    .rst(RESET),
    .col({V4,V3,V2,V1}),
    .row({H4,H3,H2,H1}),
    .val(val),
    .key_pressed_flag(key_pressed_flag)
    );
    
    keyboardRead myKeyboardRead(
    .clk(CLK),         
    .rst(RESET),          
    .val(val),       
    .key_pressed_flag(key_pressed_flag),
    .SRCH(srch),
    .SRCL(srcl),
    .DSTH(dsth),
    .DSTL(dstl),
    .ALU_OP(alu_op),
    .finish(finish),
    .state(state)
    );
    
//    keyboardRead myKeyboardRead(
//    .clk(CLK),         
//    .rst(RESET),          
//    .val(val),       
//    .key_pressed_flag(key_pressed_flag),
//    .SRCH(SRCH),
//    .SRCL(SRCL),
//    .DSTH(DSTH),
//    .DSTL(DSTL),
//    .ALU_OP(ALU_OP),
//    .finish(finish)
//    );
    
    
endmodule

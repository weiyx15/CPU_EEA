`timescale 1ns / 1ps

//EDA3���ּ�����������ʶ����׼�ӿڵ�·
module key_scan_top(
    input io_write,
    input [7:0] addr,
    
    input CLK,                      //50Hz����ɨ��ʱ��
    input RESET,                    //FPGA���ϵ�T5�������ߵ�ƽ��Ч
    input V1,V2,V3,V4,              //��Ӧcol[3:0]�����ߵ�ƽ����
    output H1,H2,H3,H4,             //��Ӧrow[3:0]������ɨ���ƽ���
    inout [1:0] STATE,                  //���ڻ��ָ����Ƶ�״̬�ź�
    inout [7:0] SRCL,                 //��һ������SRC�ĸ�8λ
    inout [7:0] SRCH,                 //��һ������SRC�ĵ�8λ
    inout [7:0] DSTL,                 //�ڶ�������DST�ĸ�8λ
    inout [7:0] DSTH,                 //�ڶ�������DST�ĵ�8λ
    inout [7:0] ALU_OP,               //���������
    output finish                     //��ʾ���յ�"="
    

    );
    
    wire [7:0] srch,srcl,dsth,dstl,alu_op;
    wire [1:0] state;
    assign STATE = (io_write&&addr==2)? 8'bz:state;
    assign SRCL = (io_write&&addr==3)? 8'bz:srcl;
    assign SRCH = (io_write&&addr==4)? 8'bz:srch;
    assign DSTL = (io_write&&addr==5)? 8'bz:dstl;
    assign DSTH = (io_write&&addr==6)? 8'bz:dsth;
    assign ALU_OP = (io_write&&addr==7)? 8'bz:alu_op;
    
    //������������
    parameter NO_OP = 3'b000;
    parameter PLUS  = 3'b001;
    parameter MINUS = 3'b010;
    parameter AND   = 3'b011;
    parameter OR    = 3'b100;
    parameter CMP   = 3'b101;
    
    
    wire key_pressed_flag;
    wire [3:0] val;  

    
    //������ģ��    
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

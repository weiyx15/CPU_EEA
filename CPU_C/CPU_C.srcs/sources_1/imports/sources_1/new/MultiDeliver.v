`timescale 1ns / 1ps
//将多位数据从FPGA发送到手机

module MultiDeliver(
    input [2:0] key,            //输入的数据
    input clk,                  //clk_baud
    input en2,                  //多位发送的使能信号
    output tx,              //串行数据输出
    output idle
    );
    
    reg [7:0] data_sent;
    wire [11:0] data_sent1; //BCD码
    wire [23:0] data_sent2; //ASCII码
    reg [7:0] datain;
    reg enable;             //每个信号的发送使能 
    initial enable=0;
    integer cnt;                            //计数，发送了多少个信号
    reg en2_buf,en2_rise,en2_rise1,en2_rise2;
    //取en2的上升沿
    always @ (posedge clk) begin
        en2_buf<=en2;
        en2_rise<=en2&(~en2_buf);
        en2_rise1<=en2_rise;
        en2_rise2<=en2_rise1;
    end
    
    reg idle_buf,idle_fall,idle_fall1,idle_fall2;
    //取idle的下降沿，idle_fall低电平有效
    always @ (posedge clk) begin
        idle_buf<=idle;
        idle_fall<=idle|(~idle_buf);
        idle_fall1<=idle_fall;
        idle_fall2<=idle_fall1;
    end

    always @ (posedge clk)
        if(en2_rise) begin
            datain<=data_sent2[7:0];
            enable<=1;
            cnt<=0;
        end
        else if(en2_rise2)
            enable<=0;
        else if(~idle_fall&&cnt==0) begin   //每次用上次的线路占用信号的下降沿触发下一次的使能
            enable<=1;
            datain<=data_sent2[15:8];
            cnt<=1;
        end
        else if(~idle_fall2)            //每次用上次的线路占用信号的下降沿触发下一次的使能
            enable<=0;
        else if(~idle_fall&&cnt==1) begin
            enable<=1;
            datain<=data_sent2[23:16];
            cnt<=2;
        end
        else if(~idle_fall2)
            enable<=0;
        else
            enable<=enable;
            
        
        
   //拨码输入转码
    always @ (key)
        data_sent=key[2]*100+key[1]*10+key[0];
    
    Binary2BCD myBinary2BCD(
    .binary({4'h0,data_sent}),
    .BCD(data_sent1)
    );
    
    BCDtoASCII U0(
    .in(data_sent1[3:0]),
    .out(data_sent2[7:0])
    );
    
    BCDtoASCII U1(
    .in(data_sent1[7:4]),
    .out(data_sent2[15:8])
    );
    
    BCDtoASCII U2(
    .in(data_sent1[11:8]),
    .out(data_sent2[23:16])
    );
    
    deliver V0(
    .clk(clk),
    .datain(datain),
    .enable(enable),
    .idle(idle),
    .tx(tx)
    );
   
    
endmodule

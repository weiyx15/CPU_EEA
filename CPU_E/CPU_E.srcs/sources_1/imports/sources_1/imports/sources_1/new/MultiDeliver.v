`timescale 1ns / 1ps
//将多位数据从FPGA发送到手机

module MultiDeliver(
    input [14:0] key1,            //输入的数据
    input [30:0] key2,           //输入的数据
    input LED_1,
    input clk,                  //clk_baud
    input en2_1,                  //多位发送的使能信号
    input en2_2,
    output tx,              //串行数据输出
    output idle
    );
    
    //运算符编码参数
    parameter NO_OP = 3'b000;
    parameter PLUS  = 3'b001;
    parameter MINUS = 3'b010;
    parameter AND   = 3'b011;
    parameter OR    = 3'b100;
    parameter CMP   = 3'b101;
    parameter EQ    = 3'b110;
    
    reg [7:0] op_sent,op_sent2;
    always @(key1,key2) begin
        case(key1[2:0])
            PLUS:op_sent = 43;
            MINUS:op_sent = 45;
            AND:op_sent = 38;
            OR:op_sent = 124;
            CMP: op_sent = 63;
            EQ: op_sent = 61;
        endcase
        case(key2[18:16])
            PLUS:op_sent2 = 43;
            MINUS:op_sent2 = 45;
            AND:op_sent2 = 38;
            OR:op_sent2 = 124;
            CMP: op_sent2 = 63;
            EQ: op_sent2 = 61;
        endcase
    end

    wire [15:0] data_sent1,data_sent201,data_sent211; //BCD码
    assign data_sent211 = key2[15:0];
    wire [31:0] data_sent2,data_sent202,data_sent212; //ASCII码
    reg [7:0] datain;
    reg enable;             //每个信号的发送使能 
    initial enable=0;
    integer cnt;                            //计数，发送了多少个信号
    reg en2_1_buf,en2_1_rise,en2_1_rise1,en2_1_rise2;
    //取en2_1的上升沿
    always @ (posedge clk) begin
        en2_1_buf<=en2_1;
        en2_1_rise<=en2_1&(~en2_1_buf);
        en2_1_rise1<=en2_1_rise;
        en2_1_rise2<=en2_1_rise1;
    end
    reg en2_2_buf,en2_2_rise,en2_2_rise1,en2_2_rise2;
    //取en2_1的上升沿
    always @ (posedge clk) begin
        en2_2_buf<=en2_2;
        en2_2_rise<=en2_2&(~en2_2_buf);
        en2_2_rise1<=en2_2_rise;
        en2_2_rise2<=en2_2_rise1;
    end
    
    reg idle_buf,idle_fall,idle_fall1,idle_fall2;
    //取idle的下降沿，idle_fall低电平有效
    always @ (posedge clk) begin
        idle_buf<=idle;
        idle_fall<=idle|(~idle_buf);
        idle_fall1<=idle_fall;
        idle_fall2<=idle_fall1;
    end

    always @ (posedge clk) begin

        if(en2_2_rise) begin
            datain<=data_sent2[31:24];
            enable<=1;
            cnt<=0;
        end
        else if(en2_2_rise2)
            enable<=0;
        else if(~idle_fall&&cnt==0) begin   //每次用上次的线路占用信号的下降沿触发下一次的使能
            enable<=1;
            datain<=data_sent2[23:16];
            cnt<=1;
        end
        else if(~idle_fall2)            //每次用上次的线路占用信号的下降沿触发下一次的使能
            enable<=0;
        else if(~idle_fall&&cnt==1) begin
            enable<=1;
            datain<=data_sent2[15:8];
            cnt<=2;
        end
        else if(~idle_fall2)
            enable<=0;
        else if(~idle_fall&&cnt==2) begin
            enable<=1;
            datain<=data_sent2[7:0];
            cnt<=3;
        end
        else if(~idle_fall2)
            enable<=0;
        else if(~idle_fall&&cnt==3) begin
            enable<=1;
            datain<=op_sent;
            cnt<=4;
        end
        else if(~idle_fall2)
            enable<=0;
    else if(~idle_fall&&cnt==4) begin
        datain<=data_sent202[31:24];
        enable<=1;
        cnt<=5;
    end
    else if(~idle_fall2)
        enable<=0;
    else if(~idle_fall&&cnt==5) begin   //每次用上次的线路占用信号的下降沿触发下一次的使能
        enable<=1;
        datain<=data_sent202[23:16];
        cnt<=6;
    end
    else if(~idle_fall2)            //每次用上次的线路占用信号的下降沿触发下一次的使能
        enable<=0;
    else if(~idle_fall&&cnt==6) begin
        enable<=1;
        datain<=data_sent202[15:8];
        cnt<=7;
    end
    else if(~idle_fall2)
        enable<=0;
    else if(~idle_fall&&cnt==7) begin
        enable<=1;
        datain<=data_sent202[7:0];
        cnt<=8;
    end
    else if(~idle_fall2)
        enable<=0;
    else if(~idle_fall&&cnt==8) begin
        enable<=1;
        datain<=op_sent2;
        cnt<=9;
    end
    else if(~idle_fall2)
        enable<=0;
     else if(~idle_fall&&cnt==9) begin
           enable<=1;
           if(LED_1==1)
                datain<=45;         //"-"
            else
                datain<=32;        //" "
           cnt<=10;
       end
       else if(~idle_fall2)
           enable<=0;
    else if(~idle_fall&&cnt==10) begin   //每次用上次的线路占用信号的下降沿触发下一次的使能
        enable<=1;
        datain<=data_sent212[31:24];
        cnt<=11;
    end
    else if(~idle_fall2)            //每次用上次的线路占用信号的下降沿触发下一次的使能
        enable<=0;
    else if(~idle_fall&&cnt==11) begin
        enable<=1;
        datain<=data_sent212[23:16];
        cnt<=12;
    end
    else if(~idle_fall2)
        enable<=0;
    else if(~idle_fall&&cnt==12) begin
        enable<=1;
        datain<=data_sent212[15:8];
        cnt<=13;
    end
    else if(~idle_fall2)
        enable<=0;
     else if(~idle_fall&&cnt==13) begin
           enable<=1;
           datain<=data_sent212[7:0];
           cnt<=14;
       end
    else if(~idle_fall2)
        enable<=0;
   else if(~idle_fall&&cnt==14) begin
          enable<=1;
          datain<=10;               //"\n"
          cnt<=15;
      end
      else if(~idle_fall2)
          enable<=0;
    else
        enable<=enable;
    end
            
        
    
    Binary2BCD BB0(
    .binary(key1[14:3]),
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
    
    BCDtoASCII U3(
    .in(data_sent1[15:12]),
    .out(data_sent2[31:24])
    );
    
    Binary2BCD BB1(
    .binary(key2[30:19]),
    .BCD(data_sent201)
    );
    
    BCDtoASCII U200(
    .in(data_sent201[3:0]),
    .out(data_sent202[7:0])
    );
    
    BCDtoASCII U201(
    .in(data_sent201[7:4]),
    .out(data_sent202[15:8])
    );
    
    BCDtoASCII U202(
    .in(data_sent201[11:8]),
    .out(data_sent202[23:16])
    );
    
    BCDtoASCII U203(
    .in(data_sent201[15:12]),
    .out(data_sent202[31:24])
    );
       
    
    BCDtoASCII U210(
    .in(data_sent211[3:0]),
    .out(data_sent212[7:0])
    );
    
    BCDtoASCII U211(
    .in(data_sent211[7:4]),
    .out(data_sent212[15:8])
    );
    
    BCDtoASCII U212(
    .in(data_sent211[11:8]),
    .out(data_sent212[23:16])
    );
    
    BCDtoASCII U213(
    .in(data_sent211[15:12]),
    .out(data_sent212[31:24])
    );
    
    deliver V0(
    .clk(clk),
    .datain(datain),
    .enable(enable),
    .idle(idle),
    .tx(tx)
    );
   
    
endmodule

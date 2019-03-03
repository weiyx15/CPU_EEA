`timescale 1ns / 1ps
module serial_ctrl(
    input [1:0] choose,
    input [1:0] state,
    input CLK,
    input [7:0] IO3,IO4,IO5,IO6,data_inL,data_inH,IO7,
    input LED_1,
    output rx,idle
    );
    //ÔËËã·û±àÂë²ÎÊı
    parameter NO_OP = 3'b000;
    parameter PLUS  = 3'b001;
    parameter MINUS = 3'b010;
    parameter AND   = 3'b011;
    parameter OR    = 3'b100;
    parameter CMP   = 3'b101;
    parameter EQ    = 3'b110;
    
    wire clk_baud,enable1,enable2;
    reg [14:0] key1;
    reg [26:0] key2;
    reg en1,en2,en3;
    reg ena,enb,enc;
    
    serial_divider SD0(choose,CLK,clk_baud);
    
    initial en1 <= 0;
    always @ (posedge clk_baud)
        if(state==2) begin
            en1 <= 1;
            key1 <= {IO4[3:0],IO3,IO7[2:0]};
        end
        else if(state==3) begin
            ena <= 1;
            key2 <= {IO6[3:0],IO5,EQ,data_inH[3:0],data_inL};
        end
        else begin
            en1 <= 0;
            ena <= 0;
        end
        
    always@(posedge clk_baud) begin
        en2 <= en1;
        en3 <= en2;
     end
     
     always@(posedge clk_baud) begin
         enb <= ena;
         enc <= enb;
      end
     
     assign enable1 = en1&(~en3);
     assign enable2 = ena&(~enc);
     
     serial_top SP0(key1,key2,LED_1,clk_baud,enable1,enable2,rx,idle);
            
    
endmodule

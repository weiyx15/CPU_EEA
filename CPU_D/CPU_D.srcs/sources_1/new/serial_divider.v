//波特率发生器模块serial_divider
module serial_divider(
    input [1:0] choose,
    input clk,
    output reg clk_baud         //发送数据波特率时钟：100MHz/115.2k
    );
    
    

  parameter    BAUD1   = 10417;         //9600
  parameter    BAUD2   = 20834;         //4800
  parameter    BAUD3   = 41667;         //2400
  integer count_baud;
  integer BAUD;
  always @(choose)
    case(choose)
        2'b01: BAUD = BAUD2;
        2'b10: BAUD = BAUD3;
        default: BAUD = BAUD1;
    endcase
  
          
      always @ (posedge clk)
            if(count_baud<BAUD/2-1)
                begin
                    count_baud<=count_baud+1'b1;
                end
            else
                begin
                    count_baud<=1'b0;
                    clk_baud<=~clk_baud;
                end
                
             
   
endmodule

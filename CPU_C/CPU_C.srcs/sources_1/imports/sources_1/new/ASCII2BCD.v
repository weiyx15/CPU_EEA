//BCD×ªASCIIÂëÄ£¿éBCDtoASCII
module ASCII2BCD(in,out);
input [7:0]in;
output reg [3:0]out;

always@(in)
            case(in)
              8'b00110000: out<=4'b0000;
              8'b00110001: out<=4'b0001;
              8'b00110010: out<=4'b0010;
              8'b00110011: out<=4'b0011;
              8'b00110100: out<=4'b0100;
              8'b00110101: out<=4'b0101;
              8'b00110110: out<=4'b0110;
              8'b00110111: out<=4'b0111;
              8'b00111000: out<=4'b1000;
              8'b00111001: out<=4'b1001;
              default:out<=4'b0000;
            endcase    


endmodule
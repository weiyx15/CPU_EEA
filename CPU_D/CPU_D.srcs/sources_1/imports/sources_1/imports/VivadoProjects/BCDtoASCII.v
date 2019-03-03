//BCDתASCII��ģ��BCDtoASCII���������ʼλ�ͽ���λ
module BCDtoASCII(in,out);
input [3:0]in;
output [7:0]out;

reg [7:0] out;
always@(in)
      case(in)
        4'b0001: out<=8'b00110001;
        4'b0010: out<=8'b00110010;
        4'b0011: out<=8'b00110011;
        4'b0100: out<=8'b00110100;
        4'b0101: out<=8'b00110101;
        4'b0110: out<=8'b00110110;
        4'b0111: out<=8'b00110111;
        4'b1000: out<=8'b00111000;
        4'b1001: out<=8'b00111001;
        4'b1111: out<=8'b01000101;
        default:out<=8'b00110000;
      endcase
      


endmodule
module ROM_2(
input [7:0] addr,
input CLK,
output reg [15:0] data);


always@(*) begin
	case(addr)	
	    // 赋初值 R0=0，R1=1，R2=2，R3=3
	    8'h00:data<=16'h9501;
	    8'h01:data<=16'h9a02;
	    8'h02:data<=16'h9f03;
	    // 实验要求的7条指令
        8'h03:data<=16'h2240;//
	    8'h04:data<=16'h59c0;//
	    8'h05:data<=16'h8920;//
        8'h06:data<=16'hdb04;//
        8'h0b:data<=16'hbb22;//
        8'h0c:data<=16'hc626;//	    
        8'h0d:data<=16'h7000;//
	    default:data<=16'h0000;	
	endcase
end

endmodule
module ROM_2(
input [7:0] addr,
input CLK,
output reg [15:0] data);


always@(*) begin
	case(addr)	//Address Must Be Word Aligned.
        0:data<=16'h2240;//
	    1:data<=16'h59c0;//
	    2:data<=16'h8920;//
        4:data<=16'hdb04;//
        5:data<=16'hbb22;//
        6:data<=16'hc626;//	    
        7:data<=16'h7000;//
	    default:data<=16'h0000;	
	endcase
end

endmodule
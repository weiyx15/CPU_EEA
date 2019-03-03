module ROM_2(
input [7:0] addr,
input CLK,
output reg [15:0] data);


always@(*) begin
	case(addr)	//Address Must Be Word Aligned.
        8'h00:data<=16'hF104;// BERW R1 R0 0x04 (PC=PC+1)
	    8'h01:data<=16'hF100;// BERW R1 R0 0x00 (PC=PC+5)
	    default:data<=16'h0000;	
	endcase
end

endmodule
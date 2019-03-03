module lpm_rom(
input [7:0] addr,
input CLK,
output reg [15:0] q);


reg [15:0] data;
always@(*) begin
	case(addr)	//Address Must Be Word Aligned.
        0:data<=16'h8000;//
	    1:data<=16'hA07D;//
	    2:data<=16'h8500;//
        4:data<=16'hA52D;//
        5:data<=16'h3180;//
        6:data<=16'h8F00;//	    
        7:data<=16'hCE08;//
        8:data<=16'h7000;//  	   
	   
	endcase
end
always @(posedge CLK) begin
    q<=data;
end



endmodule


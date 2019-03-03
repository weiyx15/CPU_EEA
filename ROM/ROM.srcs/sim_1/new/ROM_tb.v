`timescale 1ns / 1ns

module ROM_tb;
reg [7:0] address;
reg clock;
wire [15:0] q;

ROM_wrapper U0(
.address(address),
.clock(clock),
.q(q)
);

initial clock=1'b1;
always #1 clock=~clock;

initial begin
    address=0;
    repeat(5) #10 address=address+1;
end

endmodule

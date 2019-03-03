`timescale 1ns / 1ns

module ROM_tb;
reg [7:0] address;
reg clock;
wire [15:0] q;

lpm_rom U0(
.addr(address),
.CLK(clock),
.q(q)
);

initial clock=1'b1;
always #1 clock=~clock;

initial begin
    address=0;
    repeat(5) #10 address=address+1;
end

endmodule

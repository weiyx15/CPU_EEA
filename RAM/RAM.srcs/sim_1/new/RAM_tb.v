`timescale 1ns / 1ns

module RAM_tb;
reg [7:0] address,data;
reg wren,clock,aclr;
wire [7:0] q;

RAM U0(
.address(address),
.data(data),
.wren(wren),
.clock(clock),
.aclr(aclr),
.q(q)
);

always #1 clock=~clock;

initial clock=1'b1;

initial begin
aclr=1'b0;
#2 aclr=1'b1;
#700 aclr=1'b0;
#2 aclr=1'b1;
end

initial begin
address=8'h00;
repeat(255) #2 address=address+1;
repeat(255) #2 address=address-1;
end

initial begin
data=8'h00;
repeat(255) #2 data=data+1;
end

initial begin
wren=1'b1;
#512 wren=1'b0;
end

endmodule

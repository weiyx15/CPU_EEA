`timescale 1ns / 1ns

module ROM_tb;
reg [7:0] addr;
reg CLK;
wire [15:0] data;

ROM_2 U0(
.addr(addr),
.CLK(CLK),
.data(data)
);

initial CLK=1'b1;
always #1 CLK=~CLK;

initial begin
    addr=0;
    repeat(5) #2 addr=addr+1;
end

endmodule

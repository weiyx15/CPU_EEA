`timescale 1ns / 1ps

module FLAG_tb;
reg [7:0] Flagin;
reg Clk,Reset;
wire [7:0] Flagout;

FLAG U0(
.Flagin(Flagin),
.Clk(Clk),
.Reset(Reset),
.Flagout(Flagout)
);

initial begin
    Reset=1'b0;
    #2 Reset=1'b1;
    #10 Reset=1'b0;
end

initial Clk=1'b1;
always #1 Clk=~Clk;

initial begin
Flagin=2'b01;
#5 Flagin=2'b10;
end

endmodule

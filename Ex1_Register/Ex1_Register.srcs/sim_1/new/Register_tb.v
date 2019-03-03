`timescale 1ns/1ns

module Register_tb;
reg [1:0] N1,N2,ND;
reg [7:0] DI;
reg CLK,REG_WE,RST;

wire [7:0] Q1,Q2;

Register U0(
.N1(N1),
.N2(N2),
.ND(ND),
.DI(DI),
.CLK(CLK),
.REG_WE(REG_WE),
.RST(RST),
.Q1(Q1),
.Q2(Q2)
);

always #1 CLK=~CLK;

initial begin
RST=1'b0;#2 RST=1'b1; #20 RST=1'b0; #2 RST=1'b1;
end

initial CLK=1'b0;

initial begin
REG_WE=1'b0; #4 REG_WE=1'b1; #18 REG_WE=1'b0;
end

initial begin
N1=2'b00;N2=2'b11;
end

initial begin
ND=2'b00; #9 ND=2'b11;
end

initial begin
DI=8'hAA; #11 DI=8'hBB;
end

endmodule

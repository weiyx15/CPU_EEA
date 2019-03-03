`timescale 1ns / 1ns

module PC_tb;
reg BRANCH,JUMP,RESET,CLK;
reg [7:0] imm;
wire [7:0] PC;

PC U0(BRANCH,JUMP,RESET,imm,CLK,PC);

always #1 CLK=~CLK;

initial begin
    CLK=1;
    RESET=0;
    BRANCH=0;
    JUMP=0;
    imm=87;
    #2 RESET=1;
    #10 JUMP=1;
    #2 JUMP=0;
    #10 BRANCH=1; imm=2;
    #2 BRANCH=0;
end

endmodule

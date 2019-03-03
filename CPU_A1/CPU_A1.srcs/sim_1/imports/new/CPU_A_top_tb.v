`timescale 1ns / 1ns

module CPU_A_top_tb;
reg CLK,RESET,carry_in;

CPU_A_top myCPU_A_top(CLK,RESET,carry_in);

always #1 CLK=~CLK;

initial begin
    CLK=1;
    RESET=0;
    carry_in=1;
    #0.2 RESET=1;
end

endmodule

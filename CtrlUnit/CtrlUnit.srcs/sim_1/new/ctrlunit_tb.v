`include "E:/VivadoProjects/Ex1/CtrlUnit/CtrlUnit.srcs/sources_1/new/OP_define.v"
`timescale 1ns / 1ns

module ctrlunit_tb;
reg [3:0] OP;
reg ZERO;
wire JUMP,BRANCH,ALUSRCB,WRITEMEM,WRITEREG,MEMTOREG,REGDES,WRFLAG;
wire [2:0] ALUC;

ctrlunit U0(OP,ZERO,JUMP,BRANCH,ALUSRCB,WRITEMEM,WRITEREG,MEMTOREG,REGDES,WRFLAG,ALUC);

initial begin
    ZERO = 0;
    forever #1 ZERO = ~ZERO;
end

initial begin
    OP = 0;
    forever begin
        #2 OP = OP+1;
        if(OP==4'b1111) OP = 4'b0000;
    end
end

endmodule

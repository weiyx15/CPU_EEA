`include "E:\VivadoProjects\Ex1\CPU_B\CPU_B.srcs\sources_1\imports\sources_1\imports\Ex1\CtrlUnit\CtrlUnit.srcs\sources_1\new\OP_define.v"
`timescale 1ns / 1ps

module ctrlunit(
    input [3:0] OP,
    input ZERO,
    output JUMP,BRANCH,ALUSRCB,WRITEMEM,WRITEREG,MEMTOREG,REGDES,WRFLAG,
    output reg [2:0] ALUC
    );
    
    assign JUMP = ((OP==`JMP)||(OP==`BERW&&ZERO==1))?1:0;
    assign BRANCH = ((OP==`BEQ&&ZERO==1)||(OP==`BNE&&ZERO==0))?1:0;
    assign ALUSRCB = ((OP==`ADDI)||(OP==`ANDI)||(OP==`ORI)||(OP==`LW)||(OP==`SW)||(OP==`BERW))?1:0;
    assign WRITEMEM = ((OP==`SW)||(OP==`BERW&&ZERO==1))?1:0;
    assign WRITEREG = ((OP==`AND)||(OP==`OR)||(OP==`SUB)||(OP==`ADD)||(OP==`ADDC)||(OP==`SUBC)
            ||(OP==`SLT)||(OP==`LW)||(OP==`ADDI)||(OP==`ANDI)||(OP==`ORI)||(OP==`BERW&&ZERO==0))?1:0;
    assign MEMTOREG = ((OP==`LW)||(OP==`BERW&&ZERO==0))?1:0;
    assign REGDES = ((OP==`AND)||(OP==`OR)||(OP==`ADD)||(OP==`SUB)||(OP==`ADDC)||(OP==`SUBC)
            ||(OP==`SLT))?1:0;
    assign WRFLAG = ((OP==`ADD)||(OP==`SUB)||(OP==`ADDI)||(OP==`ADDC)||(OP==`SUBC))?1:0;
    
    always @(OP)
        case(OP)
            `SLT: ALUC = `ALU_COMP;
            `OR: ALUC = `ALU_OR;
            `ORI: ALUC = `ALU_OR;
            `ADD: ALUC = `ALU_ADD;
            `ADDI: ALUC = `ALU_ADD;
            `LW: ALUC = `ALU_ADD;
            `SW: ALUC = `ALU_ADD;
            `SUB: ALUC = `ALU_SUB;
            `BEQ: ALUC = `ALU_SUB;
            `BNE: ALUC = `ALU_SUB;
            `AND: ALUC = `ALU_AND;
            `ANDI: ALUC = `ALU_AND;
            `SUBC: ALUC = `ALU_SUBC;
            `ADDC: ALUC = `ALU_ADDC;
            `BERW: ALUC = `ALU_ADD;
            default: ALUC = 3'b111;         // 3'b111 ��ʾ�յ�ALU�����
        endcase
 
endmodule

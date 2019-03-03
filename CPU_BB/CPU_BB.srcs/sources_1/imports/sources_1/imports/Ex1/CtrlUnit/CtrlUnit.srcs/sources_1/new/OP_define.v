// Instruction OP: Control Unit input
`define AND     4'b0000
`define OR      4'b0001
`define ADD     4'b0010
`define SUB     4'b0011
`define SLT     4'b0100
`define SUBC    4'b0101
`define ADDC    4'b0110
`define JMP     4'b0111
`define ANDI    4'b1000
`define ORI     4'b1001
`define ADDI    4'b1010
`define LW      4'b1011
`define SW      4'b1100
`define BEQ     4'b1101
`define BNE     4'b1110
`define BERW    4'b1111

// ALU OP: Control Unit output
`define ALU_AND 3'b000          
`define ALU_OR  3'b001          
`define ALU_ADD 3'b010          //ADD without carry_in
`define ALU_SUB 3'b011          //SUB without carry_in
`define ALU_ADDC  3'b100          //ADD with carry_in
`define ALU_SUBC  3'b101          //SUB with carry_in
`define ALU_COMP  3'b110
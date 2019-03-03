`timescale 1ns / 1ps

//采用补码表示运算结果
module ALU(
input [2:0] CS,
input [7:0] data_a,data_b,
input carry_in,
output reg zero,carry_out,
output reg[7:0] S
    );
    reg [8:0]tempS,tempa,tempb;

    always@(CS,data_a,data_b,carry_in)
    case (CS)
    //AND
    3'b000: begin S=data_a & data_b;carry_out=1'b0;end
    //OR
    3'b001: begin S=data_a | data_b;carry_out=1'b0;end
    //ADD without carry_in
    3'b010:begin 
              tempa={1'b0,data_a};tempb={1'b0,data_b};
              tempS=tempa+tempb;
              S=tempS[7:0];
              carry_out=tempS[8];
              end
    //SUBTRACT without carry_in
    3'b011:begin 
              tempa={1'b0,data_a};tempb={1'b0,~data_b}+1'b1;
              tempS=tempa+tempb;
              S=tempS[7:0];
              carry_out=tempS[8];
              end
    //ADD with carry_in
    3'b100:begin 
              tempa={1'b0,data_a};tempb={1'b0,data_b};
              tempS=tempa+tempb+carry_in;
              S=tempS[7:0];
              carry_out=tempS[8];
              end
    //SUBTRACT with carry_in
    3'b101:begin 
              tempa={1'b0,data_a};tempb={1'b0,~data_b};
              tempS=tempa+tempb+carry_in;
              S=tempS[7:0];
              carry_out=tempS[8];
              end
    //COMP
    3'b110:begin 
              S=(data_a<data_b)?1'b1:1'b0;
              carry_out=0;                                      //define "carry_out" in COMP operation is 0
              end
    endcase
    
    always@(S)
    if(S==8'b00000000)
        zero<=1'b1;
    else
        zero<=1'b0;
endmodule

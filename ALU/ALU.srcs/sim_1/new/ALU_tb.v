`timescale 1ns / 1ns

module ALU_tb;
wire zero,carry_out;
wire [7:0]S;
reg [7:0] data_a,data_b;
reg [2:0] CS;
reg carry_in;

parameter delay=1<<17;              //256*256*2

ALU U1(.zero(zero),.carry_out(carry_out),.S(S),.data_a(data_a),.data_b(data_b),.CS(CS),.carry_in(carry_in));

initial begin
CS=3'b000;
repeat(6) #delay CS=CS+1;
end

initial
repeat(7) begin
    data_a=8'h00;
    repeat(255) begin
        data_b=8'h00;
        repeat(255) #2 data_b=data_b+1;
        #2 data_a=data_a+1;
    end
end

initial carry_in=0;
always #1 carry_in=~carry_in;

endmodule

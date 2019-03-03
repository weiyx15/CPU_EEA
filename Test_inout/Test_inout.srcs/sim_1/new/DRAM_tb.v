`timescale 1ns/1ns

module DRAM_tb;
 
reg [9:0]AddressBus;
reg Read,Write;
 
wire [31:0]DataBus,TestOut;
reg [31:0]TestIn;
 
DRAM dram(DataBus,AddressBus,Read,Write);
 
assign DataBus=(Write==1)?TestIn:32'bz;
assign TestOut=(Read==1)?DataBus:32'bz;
 
initial
begin
    Write=1'b0;Read=1'b0;AddressBus=1'b0;TestIn=1'b0;
    #100 Write=1'b1;AddressBus=10'd4;TestIn=32'd64;
    #10 Write=1'b0;
    #10 Read=1'b1;AddressBus=10'd8;
    #30 $stop;
end
 
endmodule
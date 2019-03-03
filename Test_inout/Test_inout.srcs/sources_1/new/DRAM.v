`timescale 1ns/1ps

module DRAM(DataBus,AddressBus,ReadRAM,WriteRAM);
inout [31:0]DataBus;
 
input [9:0]AddressBus;
input ReadRAM,WriteRAM;
 
reg [31:0]RAM[0:1023];
integer i;

initial
    for(i=0; i<1024; i=i+1)
        RAM[i] = 32'b0;

 
assign DataBus=(ReadRAM==1)? RAM[AddressBus]:32'bz;
 
always @(WriteRAM or DataBus)
    if(WriteRAM)
        RAM[AddressBus] =DataBus;

endmodule
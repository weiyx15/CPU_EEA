`timescale 1ns / 1ns


module result_process_tb;
reg [15:0] data_in;
wire [15:0] data_reg;
wire LED_1;

result_process myResult_process(data_in[15:8],data_in[7:0],data_reg,LED_1);

initial begin
    data_in = 12'h32b;
    #1 data_in = 16'hfe1f;
end

endmodule

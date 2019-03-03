`timescale 1ns / 1ps

module seg(CLK_seg,CLK_CPU,io_write,addr,data_H,data_L,LED_1,seg_sel,data_out);
input CLK_seg;                      //段选扫描时钟
input CLK_CPU;                      //从前级取数据的时钟
input io_write,addr;                //IO模块的输入信号
input[7:0] data_H;                //高8位数据输入
input[7:0] data_L;                //低8位数据输入
output LED_1;                       //LED_1 = 1表示结果为负数，送至小灯L1显示
output reg[3:0] seg_sel;                //段选信号
output reg[7:0] data_out;               //位选信号





reg [7:0] data_inh, data_inl;           //输入映射寄存器


always @(posedge CLK_CPU) begin
    if(io_write&&addr==1)
        data_inh <= data_H;
    if(io_write&&addr==0)
        data_inl <= data_L;
    end

wire [7:0] data_inH,data_inL;   
result_process myResult_process(data_inh,data_inl,{data_inH,data_inL},LED_1);

reg		[1:0] current_state,next_state;
reg[4:0] data_out_ctrl;                 //段选控制信号


parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10, S3 = 2'b11;
    

always @ (current_state) begin            //输出方程
    case (current_state)
        S0:
        begin
            seg_sel=4'b1110;
            data_out_ctrl<=data_inL[3:0];   //最低位不用灭零
        end
        S1:
        begin
            seg_sel=4'b1101;
            if((data_inH==8'h00||data_inH==8'ha0||data_inH==8'haa||data_inH==8'h0a)&&data_inL[7:4]==4'h0)
                data_out_ctrl=5'b11_111;        //第三高位灭零
            else
                data_out_ctrl=data_inL[7:4];
        end
        S2:
        begin
            seg_sel=4'b1011;
            if(data_inH==8'h00||data_inH==8'ha0)
                data_out_ctrl=5'b11_111;      //第二高位灭零
            else
                data_out_ctrl=data_inH[3:0];
        end
        S3:
        begin
            seg_sel=4'b0111;
            if(data_inH[7:4]==4'h0)
                data_out_ctrl=5'b11_111;         //最高位灭零
            else
                data_out_ctrl=data_inH[7:4];
        end
    endcase
end

always @ (posedge CLK_seg) begin            //状态方程
       current_state <= next_state;
end 

always @ (current_state)                //驱动方程
   begin
        case (current_state)
            S0:
               next_state <= S1;
            S1:
               next_state <= S2;
            S2:
               next_state <= S3;
            S3:
               next_state <= S0;
        endcase
   end


always @(data_out_ctrl)                         //八段译码
case(data_out_ctrl)
   4'h0:data_out=~8'b0011_1111;
   4'h1:data_out=~8'b0000_0110;
   4'h2:data_out=~8'b0101_1011;
   4'h3:data_out=~8'b0100_1111;
   4'h4:data_out=~8'b0110_0110;
   4'h5:data_out=~8'b0110_1101;
   4'h6:data_out=~8'b0111_1101;
   4'h7:data_out=~8'b0000_0111;
   4'h8:data_out=~8'b0111_1111;
   4'h9:data_out=~8'b0110_1111;
   4'ha:data_out=~8'b0111_0111;
   4'hb:data_out=~8'b0111_1100;
   4'hc:data_out=~8'b0011_1001;
   4'hd:data_out=~8'b0101_1110;
   4'he:data_out=~8'b0111_1001;
   4'hf:data_out=~8'b0111_0001;
   default:data_out=8'b1111_1111;           //缺省情况，数码管全灭
endcase

endmodule

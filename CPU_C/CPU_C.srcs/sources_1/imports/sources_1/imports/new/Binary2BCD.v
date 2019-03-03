`timescale 1ns / 1ps
//将12位二进制代码转成4位BCD码

module Binary2BCD(
    input [11:0] binary,
    output reg [15:0] BCD
    );
    
    integer i;                          //循环控制变量
    always @ (binary)
    begin
        BCD=16'h0000;                   //初始化
        for (i=11;i>=0;i=i-1) begin
            //BCD码每一位如果>=5则加3
            if(BCD[15:12]>=5)
                BCD[15:12]=BCD[15:12]+3;
            if(BCD[11:8]>=5)
                BCD[11:8]=BCD[11:8]+3;
            if(BCD[7:4]>=5)
                BCD[7:4]=BCD[7:4]+3;
            if(BCD[3:0]>=5)
                BCD[3:0]=BCD[3:0]+3;
            
            //左移一位
            BCD=BCD<<1;
            BCD[0]=binary[i];
        end
    end
                                
endmodule

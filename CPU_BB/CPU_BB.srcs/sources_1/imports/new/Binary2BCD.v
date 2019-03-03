`timescale 1ns / 1ps
//��12λ�����ƴ���ת��4λBCD��

module Binary2BCD(
    input [11:0] binary,
    output reg [15:0] BCD
    );
    
    integer i;                          //ѭ�����Ʊ���
    always @ (binary)
    begin
        BCD=16'h0000;                   //��ʼ��
        for (i=11;i>=0;i=i-1) begin
            //BCD��ÿһλ���>=5���3
            if(BCD[15:12]>=5)
                BCD[15:12]=BCD[15:12]+3;
            if(BCD[11:8]>=5)
                BCD[11:8]=BCD[11:8]+3;
            if(BCD[7:4]>=5)
                BCD[7:4]=BCD[7:4]+3;
            if(BCD[3:0]>=5)
                BCD[3:0]=BCD[3:0]+3;
            
            //����һλ
            BCD=BCD<<1;
            BCD[0]=binary[i];
        end
    end
                                
endmodule

`timescale 1ns / 1ps

module seg(CLK_seg,data_inH,data_inL,seg_sel,data_out);
input CLK_seg;                      //��ѡɨ��ʱ��
input[7:0] data_inH;                //��8λ��������
input[7:0] data_inL;                //��8λ��������
output reg[3:0] seg_sel;                //��ѡ�ź�
output reg[7:0] data_out;               //λѡ�ź�

reg		[1:0] current_state,next_state;
reg[3:0] data_out_ctrl;                 //��ѡ�����ź�


parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10, S3 = 2'b11;
    

always @ (current_state) begin            //�������
    case (current_state)
        S0:
        begin
            seg_sel=4'b1110;
            data_out_ctrl<=data_inL[3:0];   //���λ��������
        end
        S1:
        begin
            seg_sel=4'b1101;
            data_out_ctrl=data_inL[7:4];
        end
        S2:
        begin
            seg_sel=4'b1011;
            data_out_ctrl=data_inH[3:0];
        end
        S3:
        begin
            seg_sel=4'b0111;
            data_out_ctrl=data_inH[7:4];
        end
    endcase
end

always @ (posedge CLK_seg) begin            //״̬����
       current_state <= next_state;
end 

always @ (current_state)                //��������
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


always @(data_out_ctrl)                         //�˶�����
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
//   4'ha:data_out=~8'b0111_0111;
//   4'hb:data_out=~8'b0111_1100;
//   4'hc:data_out=~8'b0011_1001;
//   4'hd:data_out=~8'b0101_1110;
//   4'he:data_out=~8'b0111_1001;
//   4'hf:data_out=~8'b0111_0001;
   default:data_out=8'b1111_1111;           //ȱʡ����������ȫ��
endcase

endmodule

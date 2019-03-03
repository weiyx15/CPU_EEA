//UART����ģ��deliver
module deliver(
input clk,          //UARTʱ��
input [7:0] datain, //��Ҫ���͵�����
input enable,        //���������������Ч
output reg idle,        //��·״ָ̬ʾ����Ϊ��·æ����Ϊ��·����
output reg tx          //�������ݷ���
);

reg send;
reg enablebuf, enablerise;
reg presult;
reg[7:0] cnt;       //������
parameter paritymode = 1'b0;

//��ⷢ������enable��������
always @(posedge clk) begin
    enablebuf <= enable;
    enablerise <= (~enablebuf) & enable;
end

always @(posedge clk) begin
if (enablerise &&  (~idle))  //������������Ч����·Ϊ����ʱ�������µ����ݷ��ͽ���
    send <= 1'b1;
else if(cnt == 8'd10)      //һ֡���Ϸ��ͽ���
    send <= 1'b0;
end

always @(posedge clk) begin
if(send == 1'b1) begin
    case(cnt)       //������ʼλ
    8'd0:
    begin
        tx <= 1'b0;
        idle <= 1'b1;
        cnt <= cnt + 8'd1;
    end
    8'd1:
    begin
        tx <= datain[0];    //��������0λ
        presult <= datain[0]^paritymode;
        idle <= 1'b1;
        cnt <= cnt + 8'd1;
    end
    8'd2:
    begin
        tx <= datain[1];    //��������1λ
        presult <= datain[1]^presult;
        idle <= 1'b1;
        cnt <= cnt + 8'd1;
    end
    8'd3:
    begin
        tx <= datain[2];    //��������2λ
        presult <= datain[2]^presult;
        idle <= 1'b1;
        cnt <= cnt + 8'd1;
        end
    8'd4:
    begin
        tx <= datain[3];    //��������3λ
        presult <= datain[3]^presult;
        idle <= 1'b1;
        cnt <= cnt + 8'd1;
    end
    8'd5:
    begin
        tx <= datain[4];    //��������4λ
        presult <= datain[4]^presult;
        idle <= 1'b1;
        cnt <= cnt + 8'd1;
    end
    8'd6:
    begin
        tx <= datain[5];    //��������5λ
        presult <= datain[5]^presult;
        idle <= 1'b1;
        cnt <= cnt + 8'd1;
    end
    8'd7:
    begin
        tx <= datain[6];    //��������6λ
        presult <= datain[6]^presult;
        idle <= 1'b1;
        cnt <= cnt + 8'd1;
    end
    8'd8:
    begin
        tx <= datain[7];    //��������7λ
        presult <= datain[7]^presult;
        idle <= 1'b1;
        cnt <= cnt + 8'd1;
    end
    8'd9:
    begin
        tx <= 1'b1;     //����ֹͣλ             
        idle <= 1'b1;
        cnt <= cnt + 8'd1;
    end
    8'd10:
    begin
        tx <= 1'b1;             
        idle <= 1'b0;   //һ֡���Ϸ��ͽ���
    //idle�������źţ������ַ���������Ϻ󣬸����½��ء�
    cnt <= cnt + 8'd1;
    end
    default:
        cnt <= cnt + 8'd1;
    endcase
end
else begin
    tx <= 1'b1;
    cnt <= 8'd0;
    idle <= 1'b0;       //��·��
end
end
endmodule

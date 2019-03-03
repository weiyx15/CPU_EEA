//`timescale 1ns / 1ps
////���ն�λ����


//module MultiReceive(
//    input clk,          //������ʱ��clk_baud������clk_sample
//    input rst,          //��dataout����
//    input IN,           //UART��������
//    output reg[23:0] comand,     //�������������6λBCD��
//    output reg multi_rdsig     //��λ������ϵ������ź�
//    );
    
//    wire [7:0] dataout;         //��λ���յ�1λASCII��
//    wire [3:0] dataoutBCD;      //��λ���յ�1λBCD��
//    wire rdsig;                 //�����ַ����յ������ź�
////    integer cnt;                //����������multi_rdsig����16��ʱ������
    
//    receive V0(
//    .clk(clk),
//    .rst(rst),
//    .IN(IN),
//    .dataout(dataout),
//    .rdsig(rdsig)
//    );
    
//    ASCII2BCD U0(
//    .in(dataout),
//    .out(dataoutBCD)
//    );
    
//    parameter IDLE  =2'b00;     //û���ź�����
//    parameter SAVE  =2'b01;     //����λ�ַ����յ��ַ��Ĵ�
//    parameter FINISH=2'b10;     //�������
    
//    reg [1:0] current_state,next_state;
    
//    reg INbuf,INfall;       //INfall��IN���½���ʱINfall����һ��ʱ�����ڿ�ȵĸߵ�ƽ
//    always @(posedge clk)   //���IN���½���
//    begin
//        INbuf <= IN;
//        INfall <= INbuf & (~IN);
//    end
//    reg rdsig_buf,rdsig_fall;   //rdsig_fall��rdsig���½���ʱrdsig_fall����һ��ʱ�����ڵĸߵ�ƽ
//    always @(posedge clk) begin //���rdsig���½���
//        rdsig_buf<=rdsig;
//        rdsig_fall<=rdsig_buf&(~rdsig);
//    end
    
//    initial current_state=IDLE;
//    initial comand=0;
    
//    //����������
////    always @(posedge clk)
////        if(current_state==IDLE || current_state==SAVE)
////            cnt<=0;
////        else
////            cnt<=cnt+1;             //FINISH״̬���м������Ƶ�15״̬��ת
    
//    //״̬����
//    always @(posedge clk)
//        current_state<=next_state;
    
//    //�������    
//    always @(posedge clk)           //��λ�Ĵ�ÿ��INfallֻ�ܴ�һ�Σ������clk����
//        case(next_state)            //next_state�жϣ����״̬��ת���������ͬһ���źŵ�����
//            IDLE: 
//                multi_rdsig=1'b0;
//            SAVE:
//            if(INfall)
//                comand={dataoutBCD,comand[19:0]};   
//            //���λ��AUTO/KEY��Ȼ��ո���0������Ȼ��IF_PARA��Ȼ��ո����2λ��PARA
//            FINISH:
//                multi_rdsig=1'b1;
//        endcase
        
//    //��������
//    always @(current_state or rdsig)
//        case(current_state)
//            IDLE:
//                if(INfall)
//                    next_state=SAVE;
//                else
//                    next_state=IDLE;
//            SAVE:
//                if((~INfall)&rdsig_fall)
//                    next_state=FINISH;
//                else
//                    next_state=SAVE;
//            FINISH:
//                next_state=IDLE;            //FINISH����һ��ʱ�������Զ�����IDLE
//        endcase
                    
    
//endmodule

`timescale 1ns / 1ps
//���ն�λ����


module MultiReceive(
input clk,          //����ʱ��clk_sample
input rst,          //��dataout����
input IN,           //UART��������
output reg[23:0] command,     //�������������6λBCD��(N=24)��1λBCD��(N=4)
output reg rdsig,       //�������ݽ�����ɵ������ź�
output reg rdsig_all    //��λ����ȫ��������ɵ������ź�
);

initial command=0;

parameter cnt_END=183;    //cnt������cnt_END����λ���ݽ������
//175=11��16-1+8


integer cnt;
reg [7:0] dataout;      //��λ����ASCII������
wire [3:0] dataoutBCD;   //��λ����BCD�����
ASCII2BCD U0(
    .in(dataout),
    .out(dataoutBCD)
    );

reg INbuf, INfall, receive;
reg idle;               //��·�Ƿ�ռ��
always @(posedge clk)   //�����·���½���
begin
    INbuf <= IN;
    INfall <= INbuf & (~IN);
end

always @(posedge clk)
if (INfall && (~idle))  //��⵽��·���½��ز���ԭ����·Ϊ���У������������ݽ���
        receive <= 1'b1;
else if(cnt == cnt_END)  //�����������
        receive <= 1'b0;


always @(posedge clk or posedge rst)
if(rst)
    command<=0;
else begin
    if(receive == 1'b1)
    begin
        case (cnt)
            8'd0:
            begin
                command<=0;//��һ�ν���cnt=0״̬���������㣬֮���ѭ����cnt=8��ʼ������ִ������
                rdsig_all<=1'b0;
                idle <= 1'b1;
                cnt <= cnt + 8'd1;
                rdsig <= 1'b0;
            end
            8'd24:  //���յ�0λ����
            begin
                rdsig_all<=1'b0;
                idle <= 1'b1;
                dataout[0] <= IN;
                cnt <= cnt + 8'd1;
                rdsig <= 1'b0;
            end
            8'd40: //���յ�1λ����
            begin
                rdsig_all<=1'b0;
                idle <= 1'b1;
                dataout[1] <= IN;
                cnt <= cnt + 8'd1;
                rdsig <= 1'b0;
            end
            8'd56: //���յ�2λ����
            begin
                rdsig_all<=1'b0;
                idle <= 1'b1;
                dataout[2] <= IN;
                cnt <= cnt + 8'd1;
                rdsig <= 1'b0;
                end
            8'd72: //���յ�3λ����
            begin
                rdsig_all<=1'b0;
                idle <= 1'b1;
                dataout[3] <= IN;
                cnt <= cnt + 8'd1;
                rdsig <= 1'b0;
            end
            8'd88: //���յ�4λ����
            begin
                rdsig_all<=1'b0;
                idle <= 1'b1;
                dataout[4] <= IN;
                cnt <= cnt + 8'd1;
                rdsig <= 1'b0;
            end
            8'd104: //���յ�5λ����
            begin
                rdsig_all<=1'b0;
                idle <= 1'b1;
                dataout[5] <= IN;
                cnt <= cnt + 8'd1;
                rdsig <= 1'b0;
            end
            8'd120:     //���յ�6λ����
            begin
                rdsig_all<=1'b0;
                idle <= 1'b1;
                dataout[6] <= IN;
                cnt <= cnt + 8'd1;
                rdsig <= 1'b0;
            end
            8'd136:     //���յ�7λ����
            begin
                rdsig_all<=1'b0;
                idle <= 1'b1;
                dataout[7] <= IN;
                cnt <= cnt + 8'd1;
                rdsig <= 1'b1;//rdsig����"�����ź�",�����ַ���������Ϻ󣬸����½��ء�
            end
            8'd152:     //����ֹͣλ
            begin
                rdsig_all<=1'b0;
                idle <= 1'b1;
                cnt <= cnt + 8'd1;
                rdsig <= 1'b1;
                command<={command[19:0],dataoutBCD};    //��λ�Ĵ�
            end
            8'd168:      //������һ�����ݵ���ʼλ
            begin
                rdsig<=1'b0;
                if(IN==0) begin      //����һ������
                    cnt<=8'd9;

                    idle<=1'b1;
                    rdsig_all<=1'b0;
                end
                else begin                    //����һ������
                    cnt<=cnt+1;
                    idle<=1'b0;
                    rdsig_all<=1'b1;
                end
            end
            default:
                cnt <= cnt + 8'd1;
        endcase
    end
    else begin
        cnt <= 8'd0;
        idle <= 1'b0;
        rdsig <= 1'b0;
        rdsig_all=1'b0;
    end
end

endmodule
`timescale 1ns / 1ps
//���̶�ȡ״̬������ȡkeyboard_.v�ļ�ֵ���丳ֵ����Ӧ�Ķ˿ڼĴ���

module keyboardRead(
    input clk,          //��keyboard_.vʱ����ͬ��ѡȡ50Hz
    input rst,          //���㸴λ�ź�
    input [3:0] val,          //��keyboard_.v��ȡ�İ���ֵ
    input key_pressed_flag,//��key_board_.v��ȡ���жϰ����Ƿ��µ��ź�
    output reg[7:0] SRCH,                 //��һ������SRC�ĸ�8λ
    output reg[7:0] SRCL,                 //��һ������SRC�ĵ�8λ
    output reg[7:0] DSTH,                 //�ڶ�������DST�ĸ�8λ
    output reg[7:0] DSTL,                 //�ڶ�������DST�ĵ�8λ
    output reg[7:0] ALU_OP,               //���������
    output reg finish,                     //���յ��������Ⱥţ���ʼ����
    output reg [1:0] state,                //���ڻ��ָ����Ƶ�״̬�ź�
    output reg disp
    );
    
    //״̬��״̬����
    parameter SRC_S=4'b0000;             //SRCд���ǰ�÷���λ
    parameter SRC_0=4'b0001;             //д��SRC��0~3λ
    parameter SRC_1=4'b0010;             //д��SRC��4~7λ
    parameter SRC_2=4'b0011;             //д��SRC��8~11λ
    parameter DST_S=4'b0100;             //DSTд���ǰ�÷���λ
    parameter DST_0=4'b0101;             //д��DST��0~3λ
    parameter DST_1=4'b0110;             //д��DST��4~7λ
    parameter DST_2=4'b0111;             //д��DST��8~11λ
    parameter FINISH=4'b1000;           //���µȺź��״̬
    parameter SRC_N=4'b1001;            //SRC�Ѿ�����3����������һ����Ч����
    parameter DST_N=4'b1010;            //DST�Ѿ�����3����������һ����Ч����
    parameter CONTINUE=4'b1011;         //����������������������������ֱ�����
    parameter CON_S=4'b1100;            //����CONTINUE״̬�������������������������֮
    
    //������������
    parameter NO_OP = 3'b000;
    parameter PLUS  = 3'b001;
    parameter MINUS = 3'b010;
    parameter AND   = 3'b011;
    parameter OR    = 3'b100;
    parameter CMP   = 3'b101;
    parameter EQ    = 3'b110;
    
    initial ALU_OP=NO_OP;                   //�ϵ�󽫷��ų�ʼ��ΪPLUS
    //״̬����
    reg[3:0] current_state,next_state;
    
    integer tmp;                            //�м���������ڱ�����λ����Ȼ��ָSRCH[3:0]/DSTH[3:0]��SRCL/DSTL
    reg [7:0] tmpOP;                        //����CONTINUE״̬�м�洢�����
    
    //״̬����
    always @ (posedge clk or posedge rst)
    if(rst)
        current_state <= SRC_S;             //������㸴λ�źŰ��£������SRCд���ǰ��״̬
    else if(key_pressed_flag)
        current_state <= next_state;
    else if(current_state==CONTINUE)        //CONTINUE״̬��CON_S״̬��ת�䲻��Ҫ��������
        current_state <= next_state;
        
    //������̣�SRC��DSTֱ���ö����Ʊ�ʾ��
    always @ (posedge clk or posedge rst)
    if (rst) begin
        SRCL=8'h00;
        SRCH=8'h80;                         //�������SRC��ʾ����ʱSRC=0�����ڸ�״̬��LED����
        DSTL=8'h00;
        DSTH=8'h00;
        finish=0;                           //���SRC[7]��SRC��ʾ
        ALU_OP=PLUS;                        //�͸��ϵ�һ������ʱ�����Ϊȱʡֵ"+"
    end
    else
        case(next_state)
            CONTINUE: begin
                state = 3;
                finish=1;
                disp=0;
                if(key_pressed_flag)
                case (val)
                    4'hA: tmpOP= PLUS;
                    4'hB: tmpOP= MINUS;
                    4'hC: tmpOP= AND;
                    4'hD: tmpOP= OR;
                    4'hE: tmpOP= CMP;
                    4'hF: tmpOP= EQ;
                    default: tmpOP= NO_OP;       
                endcase
            end
            CON_S: begin
                state = 1;
                finish=0;
                ALU_OP=tmpOP;
                if(key_pressed_flag)
                    case (val)
                        4'hA: ALU_OP= PLUS;
                        4'hB: ALU_OP= MINUS;
                        4'hC: ALU_OP= AND;
                        4'hD: ALU_OP= OR;
                        4'hE: ALU_OP= CMP;
                        4'hF: ALU_OP= EQ;
                        default: ALU_OP= NO_OP;       
                    endcase
            end
            FINISH: begin
                state = 3;
                disp=1;
                finish= 1;
                DSTH[7]=0;
                SRCH[7]=0;
                end
            SRC_S: begin
                state = 1;
                disp=0;
                finish=0;                       
                if(key_pressed_flag) 
                case (val)
                    4'hA: ALU_OP= PLUS;
                    4'hB: ALU_OP= MINUS;
                    4'hC: ALU_OP= AND;
                    4'hD: ALU_OP= OR;
                    4'hE: ALU_OP= CMP;
                    4'hF: ALU_OP= EQ;
                    default: ALU_OP=NO_OP;       
                endcase
            end
            SRC_0: begin
                state = 0;
                disp=0;
                if(key_pressed_flag) begin
                    SRCL={4'h0,val};
                    SRCH=8'b0000_0000;                  
                end
                DSTH[7]=1'b0;                       //ͬʱ��DST���λ�����ʾ����д��DST
                finish=0;                           //��һ�ּ�����̣����ý����ʾ����SRC��ʾ
           end
            SRC_1: begin
                state = 0;
                //SRCL={SRCL[3:0],val};             //-----------BCD�뷽ʽ---------
                if(key_pressed_flag)
                    SRCL=SRCL[3:0]*10+val;              //-----------�����Ʒ�ʽ--------
                end
            SRC_2: begin
           state = 0;
           if(key_pressed_flag) begin
                tmp=SRCL*10+val;                            //tmp��ʱ��λ����洢����255�Ƚϣ������Ƿ�Ҫ��SRCH[3:0]/DSTH[3:0]��λ
                if(tmp>255) begin
                    SRCL=tmp[7:0];
                    SRCH[3:0]=(tmp-SRCL)>>8; 
                end
                else
                    SRCL=tmp;
                end
            end
            DST_S: begin
                    state = 1;
                    disp=0;
                    finish=0;
                    if(key_pressed_flag)
                    case (val)
                        4'hA: ALU_OP= PLUS;
                        4'hB: ALU_OP= MINUS;
                        4'hC: ALU_OP= AND;
                        4'hD: ALU_OP= OR;
                        4'hE: ALU_OP= CMP;
                        4'hF: ALU_OP= EQ;
                        default: ALU_OP= NO_OP;      //ȱʡ״̬��������ͳ�ʼ״̬һ�����ǼӺ�
                    endcase
            end
            DST_0: begin
                state = 2;
                disp=0;
                if(key_pressed_flag) begin
                    DSTL={4'h0,val};
                    DSTH=8'b0000_0000;                  
                    SRCH[7]=1'b0;                       //ͬʱ��SRCH���λ�����ʾ����д��SRC
                end
           end
            DST_1: begin
                state = 2;
                  if(key_pressed_flag)
                    DSTL=DSTL[3:0]*10+val;              //-----------�����Ʒ�ʽ--------
                end
              DST_2: begin
              state = 2;
              if(key_pressed_flag) begin             //����Ѿ�����3�����Ͳ���������
                  tmp=DSTL*10+val;                            //tmp��ʱ��λ����洢����255�Ƚϣ������Ƿ�Ҫ��SRCH[3:0]/DSTH[3:0]��λ
                  if(tmp>255) begin
                      DSTL=tmp[7:0];
                      DSTH[3:0]=(tmp-DSTL)>>8;
                  end
                  else
                      DSTL=tmp;
              end
          end
          SRC_N:
            state = 0;
          DST_N:
            state = 2;
            default;
        endcase
    
    //��������
    always @ (current_state or val)
        case(current_state)
            CONTINUE:
                next_state=CON_S;           //������û�����롢����ʲô����ת��CON_S״̬
            CON_S:
                if(val==4'h0 || val==4'h1 || val==4'h2 || val==4'h3 || val==4'h4 || val==4'h5 || val==4'h6 || val==4'h7 || val==4'h8 || val==4'h9)
                    next_state=DST_0;
                else
                    next_state=CON_S;
            FINISH:
                if(val==4'h0 || val==4'h1 || val==4'h2 || val==4'h3 || val==4'h4 || val==4'h5 || val==4'h6 || val==4'h7 || val==4'h8 || val==4'h9)
                    next_state=SRC_0;       //FINISHʱ����������֣���������ľ���SRC
                else if(val==4'hF)
                    next_state=FINISH;
                else                        //FINISHʱ���������ţ���������ľ���DST
                    next_state=DST_S;
            SRC_S:
                if(val==4'h0 || val==4'h1 || val==4'h2 || val==4'h3 || val==4'h4 || val==4'h5 || val==4'h6 || val==4'h7 || val==4'h8 || val==4'h9)
                    next_state=SRC_0;
                else
                    next_state=SRC_S;
            SRC_0:
                if(val==4'hA || val==4'hB || val==4'hC || val==4'hD || val==4'hE)
                    next_state=DST_S;           //���������������ڶ�����������׼��
                else if(val==4'hF)
                    next_state=FINISH;           //����"="����ʼ����
                else
                    next_state=SRC_1;
             SRC_1:
                   if(val==4'hA || val==4'hB || val==4'hC || val==4'hD || val==4'hE)
                       next_state=DST_S;           //���������������ڶ�����������׼��
                   else if(val==4'hF)
                       next_state=FINISH;           //����"="����ʼ����
                   else
                       next_state=SRC_2;
            SRC_2:
                  if(val==4'hA || val==4'hB || val==4'hC || val==4'hD || val==4'hE)
                      next_state=DST_S;           //���������������ڶ�����������׼��
                  else if(val==4'hF)
                      next_state=FINISH;           //����"="����ʼ����
                  else
                      next_state=SRC_N;
              SRC_N:
                if(val==4'hA || val==4'hB || val==4'hC || val==4'hD || val==4'hE)
                    next_state=DST_S;           //���������������ڶ�����������׼��
                else if(val==4'hF)
                    next_state=FINISH;           //����"="����ʼ����
                else
                    next_state=SRC_N;
              DST_S:
                  if(val==4'h0 || val==4'h1 || val==4'h2 || val==4'h3 || val==4'h4 || val==4'h5 || val==4'h6 || val==4'h7 || val==4'h8 || val==4'h9)
                      next_state=DST_0;
                  else
                      next_state=DST_S;
              DST_0:
                  if(val==4'hA || val==4'hB || val==4'hC || val==4'hD || val==4'hE)
                      next_state=CONTINUE;           //�����������ֱ�Ӽ���
                  else if(val==4'hF)
                      next_state=FINISH;           //����"="����ʼ����
                  else
                      next_state=DST_1;
              DST_1:
                  if(val==4'hA || val==4'hB || val==4'hC || val==4'hD || val==4'hE)
                      next_state=CONTINUE;           //�����������ֱ�Ӽ���
                  else if(val==4'hF)
                      next_state=FINISH;           //����"="����ʼ����
                  else
                      next_state=DST_2;
              DST_2:
                    if(val==4'hA || val==4'hB || val==4'hC || val==4'hD || val==4'hE)
                        next_state=CONTINUE;           //�����������ֱ�Ӽ���
                    else if(val==4'hF)
                        next_state=FINISH;           //����"="���ص���ʼ״̬����һ����������׼����
                    else
                        next_state=DST_N;
                DST_N:
                    if(val==4'hA || val==4'hB || val==4'hC || val==4'hD || val==4'hE)
                        next_state=CONTINUE;           //�����������ֱ�Ӽ���
                    else if(val==4'hF)
                        next_state=FINISH;           //����"="����ʼ����
                    else
                        next_state=DST_N;
        endcase
                    
        
endmodule

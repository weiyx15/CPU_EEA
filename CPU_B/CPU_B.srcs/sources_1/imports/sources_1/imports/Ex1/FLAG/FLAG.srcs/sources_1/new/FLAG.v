`timescale 1ns / 1ps

module FLAG(
input[7:0] Flagin,          //д���־�Ĵ��������ݣ���Carry��Zero����Ϣ,ÿ����־ռ1λ����2λ������6λ��ʱ���á�
input Clk,                  //дʱ�������źţ�������ʱ����Flagin�ϵ�����д��Flagout��
input Reset,                //�첽��λ�źţ��Ա�־�Ĵ�����������flagout[7..0]=0
input WRFLAG,               //ControlUnit�����Ŀ���д�����źţ�Ϊ1 ʱ��ʾ��Ҫ���־�Ĵ���д�����ݡ�
//��ָ��ΪADD��SUB��ADDI��ADDC��SUBC ʱ��Ҫд��־�Ĵ���, Ϊ1������Ϊ0
output reg [7:0] Flagout   //��־�Ĵ���������
  );
  
always @(posedge Clk or negedge Reset)
if(!Reset)
    Flagout<=8'h00;
else
    if(WRFLAG)
        Flagout<=Flagin;
    
endmodule

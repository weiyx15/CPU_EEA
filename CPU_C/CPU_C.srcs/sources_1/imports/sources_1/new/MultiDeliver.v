`timescale 1ns / 1ps
//����λ���ݴ�FPGA���͵��ֻ�

module MultiDeliver(
    input [2:0] key,            //���������
    input clk,                  //clk_baud
    input en2,                  //��λ���͵�ʹ���ź�
    output tx,              //�����������
    output idle
    );
    
    reg [7:0] data_sent;
    wire [11:0] data_sent1; //BCD��
    wire [23:0] data_sent2; //ASCII��
    reg [7:0] datain;
    reg enable;             //ÿ���źŵķ���ʹ�� 
    initial enable=0;
    integer cnt;                            //�����������˶��ٸ��ź�
    reg en2_buf,en2_rise,en2_rise1,en2_rise2;
    //ȡen2��������
    always @ (posedge clk) begin
        en2_buf<=en2;
        en2_rise<=en2&(~en2_buf);
        en2_rise1<=en2_rise;
        en2_rise2<=en2_rise1;
    end
    
    reg idle_buf,idle_fall,idle_fall1,idle_fall2;
    //ȡidle���½��أ�idle_fall�͵�ƽ��Ч
    always @ (posedge clk) begin
        idle_buf<=idle;
        idle_fall<=idle|(~idle_buf);
        idle_fall1<=idle_fall;
        idle_fall2<=idle_fall1;
    end

    always @ (posedge clk)
        if(en2_rise) begin
            datain<=data_sent2[7:0];
            enable<=1;
            cnt<=0;
        end
        else if(en2_rise2)
            enable<=0;
        else if(~idle_fall&&cnt==0) begin   //ÿ�����ϴε���·ռ���źŵ��½��ش�����һ�ε�ʹ��
            enable<=1;
            datain<=data_sent2[15:8];
            cnt<=1;
        end
        else if(~idle_fall2)            //ÿ�����ϴε���·ռ���źŵ��½��ش�����һ�ε�ʹ��
            enable<=0;
        else if(~idle_fall&&cnt==1) begin
            enable<=1;
            datain<=data_sent2[23:16];
            cnt<=2;
        end
        else if(~idle_fall2)
            enable<=0;
        else
            enable<=enable;
            
        
        
   //��������ת��
    always @ (key)
        data_sent=key[2]*100+key[1]*10+key[0];
    
    Binary2BCD myBinary2BCD(
    .binary({4'h0,data_sent}),
    .BCD(data_sent1)
    );
    
    BCDtoASCII U0(
    .in(data_sent1[3:0]),
    .out(data_sent2[7:0])
    );
    
    BCDtoASCII U1(
    .in(data_sent1[7:4]),
    .out(data_sent2[15:8])
    );
    
    BCDtoASCII U2(
    .in(data_sent1[11:8]),
    .out(data_sent2[23:16])
    );
    
    deliver V0(
    .clk(clk),
    .datain(datain),
    .enable(enable),
    .idle(idle),
    .tx(tx)
    );
   
    
endmodule

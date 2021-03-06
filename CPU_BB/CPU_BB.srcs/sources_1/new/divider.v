`timescale 1ns / 1ps
//��Ƶ��


module divider(
input CLK,
output reg CLK_seg,
output reg CLK_CPU
    );
    
    integer cnt_seg, cnt_CPU;
    
    always @(posedge CLK)
        if(cnt_seg<200000)              //�����250Hz
            cnt_seg <= cnt_seg+1;
        else  begin
            cnt_seg <= 0;
            CLK_seg <= ~CLK_seg;
        end
    
    always @(posedge CLK)
       if(cnt_CPU<1000)               //CPU
            cnt_CPU <= cnt_CPU+1;
        else begin
            cnt_CPU <= 0;
            CLK_CPU <= ~CLK_CPU;
        end
        
            
    
endmodule

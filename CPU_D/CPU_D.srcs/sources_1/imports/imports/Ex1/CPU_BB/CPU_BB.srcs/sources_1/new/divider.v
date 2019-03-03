`timescale 1ns / 1ps
//·ÖÆµÆ÷


module divider(
input CLK,
output reg CLK_seg,
output reg CLK_CPU,
output reg CLK_keyboard
    );
    
    integer cnt_seg, cnt_CPU,cnt_keyboard;
    
    always @(posedge CLK)
        if(cnt_seg<200000)              //ÊýÂë¹Ü250Hz
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
        
    always @(posedge CLK)
        if(cnt_keyboard<1000000)
            cnt_keyboard <= cnt_keyboard+1;
        else begin
            cnt_keyboard <= 0;
            CLK_keyboard <= ~CLK_keyboard;
        end
        
            
    
endmodule

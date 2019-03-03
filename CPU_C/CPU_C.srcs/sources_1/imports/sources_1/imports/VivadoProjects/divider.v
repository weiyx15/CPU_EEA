//波特率发生器模块divider
module serial_divider(
    input clk,
    input rst,
    output reg clk_sample,      //接收数据采样时钟：100MHz/115.2k/16
    output reg clk_seg,         //250Hz
    output reg clk_baud         //发送数据波特率时钟：100MHz/115.2k
    );
  
  parameter     SEG=400_000;  
  parameter    SAMPLE = 54;
  parameter    BAUD   = 868;
  integer count_sample,count_baud,count_seg;
  //远程控制系统要求波特率为9600位/秒，因此分配系数应为100_000_000/9600/16≈651。
    always @ (posedge clk or posedge rst)
      if( rst)//选通信号，只有当rst为低电平时分频器正常进行分频。
        begin
          count_sample <= 1'b0;
          clk_sample <= 1'b0;
        end
      else      
        if ( count_sample < SAMPLE/2-1)
          begin         
            count_sample <= count_sample + 1'b1;           
          end
        else
          begin       
            count_sample <= 1'b0;
            clk_sample <= ~clk_sample;     
          end
          
      always @ (posedge clk or posedge rst)
        if(rst)
            begin
                count_baud<=1'b0;
                clk_baud<=1'b0;
             end
         else
            if(count_baud<BAUD/2-1)
                begin
                    count_baud<=count_baud+1'b1;
                end
            else
                begin
                    count_baud<=1'b0;
                    clk_baud<=~clk_baud;
                end
                
    always @ (posedge clk or posedge rst)
          if( rst)//选通信号，只有当rst为低电平时分频器正常进行分频。
            begin
              count_seg <= 1'b0;
              clk_seg <= 1'b0;
            end
          else      
            if ( count_seg < SEG/2-1)
              begin         
                count_seg <= count_seg + 1'b1;           
              end
            else
              begin       
                count_seg <= 1'b0;
                clk_seg <= ~clk_seg;     
              end
             
   
endmodule

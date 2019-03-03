`timescale 1ns/1ps
module keyboard_(
  input            clk,
  input            rst,
  input      [3:0] col,                  // 矩阵键盘 行
  output reg [3:0] row,                 // 矩阵键盘 列
  output reg [3:0] val,                 // 键盘值
  output reg key_pressed_flag           //输出键被按下的信号给移位模块，按键一次移一位
);
 
parameter SCAN_ROW0      = 3'b000;  // 扫描第0列 
parameter SCAN_ROW1      = 3'b001;  // 扫描第1列 
parameter SCAN_ROW2      = 3'b010;  // 扫描第2列 
parameter SCAN_ROW3      = 3'b011;  // 扫描第3列 
parameter KEY_PRESSED    = 3'b100;  // 有按键按下
 
reg [5:0] current_state, next_state;
 
always @ (posedge clk, posedge rst)
  if (rst)
    current_state <= SCAN_ROW0;
  else
    current_state <= next_state;
 
always @ (current_state or col)
  case (current_state)
    SCAN_ROW0 :                         // 扫描第0列 
        if (col != 4'h0)
          next_state = KEY_PRESSED;
        else
          next_state = SCAN_ROW1;
    SCAN_ROW1 :                         // 扫描第1列 
        if (col != 4'h0)
          next_state = KEY_PRESSED;
        else
          next_state = SCAN_ROW2;    
    SCAN_ROW2 :                         // 扫描第2列
        if (col != 4'h0)
          next_state = KEY_PRESSED;
        else
          next_state = SCAN_ROW3;
    SCAN_ROW3 :                         // 扫描第3列
        if (col != 4'h0)
          next_state = KEY_PRESSED;
        else
          next_state = SCAN_ROW0;
    KEY_PRESSED :                       // 有按键按下
        if (col != 4'h0)
          next_state = KEY_PRESSED;
        else
          next_state = SCAN_ROW0;                      
  endcase

reg [3:0] col_val, row_val;             // 列值、行值

reg flag1,flag2;                       //中间变量，用于将key_pressed_flag高电平宽度改成一个时钟宽度

initial begin
    flag1=0;
    flag2=0;
end

// 根据次态给寄存器赋值可以解决组合和时序不同步的问题
always @ (posedge clk, posedge rst)
  if (rst)
  begin
    row              <= 4'h0;
    key_pressed_flag <=    0;
  end
  else
    case (next_state)                //Original: next_state
      SCAN_ROW0 :                       // 扫描第0行
      begin
        row <= 4'b0001;
        flag1 <= 0;
        flag2 <= 0;
        key_pressed_flag <= 0;
       end
      SCAN_ROW1 :                       // 扫描第1行
        row <= 4'b0010;
      SCAN_ROW2 :                       // 扫描第2行
        row <= 4'b0100;
      SCAN_ROW3 :                       // 扫描第3行
        row <= 4'b1000;
      KEY_PRESSED :                     // 有按键按下
      begin
        col_val          <= col;        // 锁存列值
        row_val          <= row;        // 锁存行值
        //将key_pressed_flag信号宽度处理为一个时钟宽度
        flag1 <= 1;
        flag2 <= flag1;                 //延迟赋值
        key_pressed_flag <= flag1&(~flag2);
      end
    endcase
 
//计算键盘输出val
always @ (col_val or row_val or key_pressed_flag)
if (key_pressed_flag)
      case ({row_val,col_val})
        8'b0001_0001 : val <= 4'h1;
        8'b0001_0010 : val <= 4'h2;
        8'b0001_0100 : val <= 4'h3;
        8'b0001_1000 : val <= 4'hA;
         
        8'b0010_0001 : val <= 4'h4;
        8'b0010_0010 : val <= 4'h5;
        8'b0010_0100 : val <= 4'h6;
        8'b0010_1000 : val <= 4'hB;
         
        8'b0100_0001 : val <= 4'h7;
        8'b0100_0010 : val <= 4'h8;
        8'b0100_0100 : val <= 4'h9;
        8'b0100_1000 : val <= 4'hC;
         
        8'b1000_0001 : val <= 4'h0; 
        8'b1000_0010 : val <= 4'hF;
        8'b1000_0100 : val <= 4'hE;
        8'b1000_1000 : val <= 4'hD;      
      endcase
      

       
endmodule
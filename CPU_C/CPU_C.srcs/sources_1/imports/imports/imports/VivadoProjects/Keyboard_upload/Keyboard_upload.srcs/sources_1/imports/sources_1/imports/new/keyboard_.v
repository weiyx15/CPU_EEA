`timescale 1ns/1ps
module keyboard_(
  input            clk,
  input            rst,
  input      [3:0] col,                  // ������� ��
  output reg [3:0] row,                 // ������� ��
  output reg [3:0] val,                 // ����ֵ
  output reg key_pressed_flag           //����������µ��źŸ���λģ�飬����һ����һλ
);
 
parameter SCAN_ROW0      = 3'b000;  // ɨ���0�� 
parameter SCAN_ROW1      = 3'b001;  // ɨ���1�� 
parameter SCAN_ROW2      = 3'b010;  // ɨ���2�� 
parameter SCAN_ROW3      = 3'b011;  // ɨ���3�� 
parameter KEY_PRESSED    = 3'b100;  // �а�������
 
reg [5:0] current_state, next_state;
 
always @ (posedge clk, posedge rst)
  if (rst)
    current_state <= SCAN_ROW0;
  else
    current_state <= next_state;
 
always @ (current_state or col)
  case (current_state)
    SCAN_ROW0 :                         // ɨ���0�� 
        if (col != 4'h0)
          next_state = KEY_PRESSED;
        else
          next_state = SCAN_ROW1;
    SCAN_ROW1 :                         // ɨ���1�� 
        if (col != 4'h0)
          next_state = KEY_PRESSED;
        else
          next_state = SCAN_ROW2;    
    SCAN_ROW2 :                         // ɨ���2��
        if (col != 4'h0)
          next_state = KEY_PRESSED;
        else
          next_state = SCAN_ROW3;
    SCAN_ROW3 :                         // ɨ���3��
        if (col != 4'h0)
          next_state = KEY_PRESSED;
        else
          next_state = SCAN_ROW0;
    KEY_PRESSED :                       // �а�������
        if (col != 4'h0)
          next_state = KEY_PRESSED;
        else
          next_state = SCAN_ROW0;                      
  endcase

reg [3:0] col_val, row_val;             // ��ֵ����ֵ

reg flag1,flag2;                       //�м���������ڽ�key_pressed_flag�ߵ�ƽ��ȸĳ�һ��ʱ�ӿ��

initial begin
    flag1=0;
    flag2=0;
end

// ���ݴ�̬���Ĵ�����ֵ���Խ����Ϻ�ʱ��ͬ��������
always @ (posedge clk, posedge rst)
  if (rst)
  begin
    row              <= 4'h0;
    key_pressed_flag <=    0;
  end
  else
    case (next_state)                //Original: next_state
      SCAN_ROW0 :                       // ɨ���0��
      begin
        row <= 4'b0001;
        flag1 <= 0;
        flag2 <= 0;
        key_pressed_flag <= 0;
       end
      SCAN_ROW1 :                       // ɨ���1��
        row <= 4'b0010;
      SCAN_ROW2 :                       // ɨ���2��
        row <= 4'b0100;
      SCAN_ROW3 :                       // ɨ���3��
        row <= 4'b1000;
      KEY_PRESSED :                     // �а�������
      begin
        col_val          <= col;        // ������ֵ
        row_val          <= row;        // ������ֵ
        //��key_pressed_flag�źſ�ȴ���Ϊһ��ʱ�ӿ��
        flag1 <= 1;
        flag2 <= flag1;                 //�ӳٸ�ֵ
        key_pressed_flag <= flag1&(~flag2);
      end
    endcase
 
//����������val
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
`timescale 1ns / 1ps
//键盘读取状态机，读取keyboard_.v的键值将其赋值到相应的端口寄存器

module keyboardRead(
    input clk,          //与keyboard_.v时钟相同，选取50Hz
    input rst,          //清零复位信号
    input [3:0] val,          //从keyboard_.v读取的按键值
    input key_pressed_flag,//从key_board_.v读取的判断按键是否按下的信号
    output reg[7:0] SRCH,                 //第一个数据SRC的高8位
    output reg[7:0] SRCL,                 //第一个数据SRC的低8位
    output reg[7:0] DSTH,                 //第二个数据DST的高8位
    output reg[7:0] DSTL,                 //第二个数据DST的低8位
    output reg[7:0] ALU_OP,               //运算符编码
    output reg finish,                     //接收到运算符或等号，开始运算
    output reg [1:0] state,                //用于汇编指令控制的状态信号
    output reg disp
    );
    
    //状态机状态参数
    parameter SRC_S=4'b0000;             //SRC写入的前置符号位
    parameter SRC_0=4'b0001;             //写入SRC的0~3位
    parameter SRC_1=4'b0010;             //写入SRC的4~7位
    parameter SRC_2=4'b0011;             //写入SRC的8~11位
    parameter DST_S=4'b0100;             //DST写入的前置符号位
    parameter DST_0=4'b0101;             //写入DST的0~3位
    parameter DST_1=4'b0110;             //写入DST的4~7位
    parameter DST_2=4'b0111;             //写入DST的8~11位
    parameter FINISH=4'b1000;           //按下等号后的状态
    parameter SRC_N=4'b1001;            //SRC已经输满3个数又输入一个无效的数
    parameter DST_N=4'b1010;            //DST已经输满3个数又输入一个无效的数
    parameter CONTINUE=4'b1011;         //连续输入输入运算符，该运算符不直接输出
    parameter CON_S=4'b1100;            //接受CONTINUE状态输入的运算符或用新运算符覆盖之
    
    //运算符编码参数
    parameter NO_OP = 3'b000;
    parameter PLUS  = 3'b001;
    parameter MINUS = 3'b010;
    parameter AND   = 3'b011;
    parameter OR    = 3'b100;
    parameter CMP   = 3'b101;
    parameter EQ    = 3'b110;
    
    initial ALU_OP=NO_OP;                   //上电后将符号初始化为PLUS
    //状态变量
    reg[3:0] current_state,next_state;
    
    integer tmp;                            //中间变量，用于保存三位输入然后分割到SRCH[3:0]/DSTH[3:0]和SRCL/DSTL
    reg [7:0] tmpOP;                        //用于CONTINUE状态中间存储运算符
    
    //状态方程
    always @ (posedge clk or posedge rst)
    if(rst)
        current_state <= SRC_S;             //如果清零复位信号按下，则进入SRC写入的前置状态
    else if(key_pressed_flag)
        current_state <= next_state;
    else if(current_state==CONTINUE)        //CONTINUE状态向CON_S状态的转变不需要按键按下
        current_state <= next_state;
        
    //输出方程（SRC和DST直接用二进制表示）
    always @ (posedge clk or posedge rst)
    if (rst) begin
        SRCL=8'h00;
        SRCH=8'h80;                         //清零后让SRC显示，此时SRC=0，且在该状态下LED不亮
        DSTL=8'h00;
        DSTH=8'h00;
        finish=0;                           //配合SRC[7]让SRC显示
        ALU_OP=PLUS;                        //和刚上电一样，此时运算符为缺省值"+"
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
                DSTH[7]=1'b0;                       //同时将DST最高位置零表示不再写入DST
                finish=0;                           //新一轮计算过程，不让结果显示，让SRC显示
           end
            SRC_1: begin
                state = 0;
                //SRCL={SRCL[3:0],val};             //-----------BCD码方式---------
                if(key_pressed_flag)
                    SRCL=SRCL[3:0]*10+val;              //-----------二进制方式--------
                end
            SRC_2: begin
           state = 0;
           if(key_pressed_flag) begin
                tmp=SRCL*10+val;                            //tmp临时三位输入存储，与255比较，决定是否要向SRCH[3:0]/DSTH[3:0]进位
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
                        default: ALU_OP= NO_OP;      //缺省状态的运算符和初始状态一样，是加号
                    endcase
            end
            DST_0: begin
                state = 2;
                disp=0;
                if(key_pressed_flag) begin
                    DSTL={4'h0,val};
                    DSTH=8'b0000_0000;                  
                    SRCH[7]=1'b0;                       //同时将SRCH最高位置零表示不再写入SRC
                end
           end
            DST_1: begin
                state = 2;
                  if(key_pressed_flag)
                    DSTL=DSTL[3:0]*10+val;              //-----------二进制方式--------
                end
              DST_2: begin
              state = 2;
              if(key_pressed_flag) begin             //如果已经输满3个数就不能再输了
                  tmp=DSTL*10+val;                            //tmp临时三位输入存储，与255比较，决定是否要向SRCH[3:0]/DSTH[3:0]进位
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
    
    //驱动方程
    always @ (current_state or val)
        case(current_state)
            CONTINUE:
                next_state=CON_S;           //不管有没有输入、输入什么，都转到CON_S状态
            CON_S:
                if(val==4'h0 || val==4'h1 || val==4'h2 || val==4'h3 || val==4'h4 || val==4'h5 || val==4'h6 || val==4'h7 || val==4'h8 || val==4'h9)
                    next_state=DST_0;
                else
                    next_state=CON_S;
            FINISH:
                if(val==4'h0 || val==4'h1 || val==4'h2 || val==4'h3 || val==4'h4 || val==4'h5 || val==4'h6 || val==4'h7 || val==4'h8 || val==4'h9)
                    next_state=SRC_0;       //FINISH时如果输入数字，则再输入的就是SRC
                else if(val==4'hF)
                    next_state=FINISH;
                else                        //FINISH时如果输入符号，则再输入的就是DST
                    next_state=DST_S;
            SRC_S:
                if(val==4'h0 || val==4'h1 || val==4'h2 || val==4'h3 || val==4'h4 || val==4'h5 || val==4'h6 || val==4'h7 || val==4'h8 || val==4'h9)
                    next_state=SRC_0;
                else
                    next_state=SRC_S;
            SRC_0:
                if(val==4'hA || val==4'hB || val==4'hC || val==4'hD || val==4'hE)
                    next_state=DST_S;           //按下运算符，进入第二个数据输入准备
                else if(val==4'hF)
                    next_state=FINISH;           //按下"="，开始计算
                else
                    next_state=SRC_1;
             SRC_1:
                   if(val==4'hA || val==4'hB || val==4'hC || val==4'hD || val==4'hE)
                       next_state=DST_S;           //按下运算符，进入第二个数据输入准备
                   else if(val==4'hF)
                       next_state=FINISH;           //按下"="，开始计算
                   else
                       next_state=SRC_2;
            SRC_2:
                  if(val==4'hA || val==4'hB || val==4'hC || val==4'hD || val==4'hE)
                      next_state=DST_S;           //按下运算符，进入第二个数据输入准备
                  else if(val==4'hF)
                      next_state=FINISH;           //按下"="，开始计算
                  else
                      next_state=SRC_N;
              SRC_N:
                if(val==4'hA || val==4'hB || val==4'hC || val==4'hD || val==4'hE)
                    next_state=DST_S;           //按下运算符，进入第二个数据输入准备
                else if(val==4'hF)
                    next_state=FINISH;           //按下"="，开始计算
                else
                    next_state=SRC_N;
              DST_S:
                  if(val==4'h0 || val==4'h1 || val==4'h2 || val==4'h3 || val==4'h4 || val==4'h5 || val==4'h6 || val==4'h7 || val==4'h8 || val==4'h9)
                      next_state=DST_0;
                  else
                      next_state=DST_S;
              DST_0:
                  if(val==4'hA || val==4'hB || val==4'hC || val==4'hD || val==4'hE)
                      next_state=CONTINUE;           //按下运算符，直接计算
                  else if(val==4'hF)
                      next_state=FINISH;           //按下"="，开始计算
                  else
                      next_state=DST_1;
              DST_1:
                  if(val==4'hA || val==4'hB || val==4'hC || val==4'hD || val==4'hE)
                      next_state=CONTINUE;           //按下运算符，直接计算
                  else if(val==4'hF)
                      next_state=FINISH;           //按下"="，开始计算
                  else
                      next_state=DST_2;
              DST_2:
                    if(val==4'hA || val==4'hB || val==4'hC || val==4'hD || val==4'hE)
                        next_state=CONTINUE;           //按下运算符，直接计算
                    else if(val==4'hF)
                        next_state=FINISH;           //按下"="，回到初始状态（第一个数据输入准备）
                    else
                        next_state=DST_N;
                DST_N:
                    if(val==4'hA || val==4'hB || val==4'hC || val==4'hD || val==4'hE)
                        next_state=CONTINUE;           //按下运算符，直接计算
                    else if(val==4'hF)
                        next_state=FINISH;           //按下"="，开始计算
                    else
                        next_state=DST_N;
        endcase
                    
        
endmodule

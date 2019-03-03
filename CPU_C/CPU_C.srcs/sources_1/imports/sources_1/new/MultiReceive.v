//`timescale 1ns / 1ps
////接收多位数据


//module MultiReceive(
//    input clk,          //波特率时钟clk_baud而不是clk_sample
//    input rst,          //将dataout清零
//    input IN,           //UART数据输入
//    output reg[23:0] comand,     //接收数据输出，6位BCD码
//    output reg multi_rdsig     //多位接受完毕的握手信号
//    );
    
//    wire [7:0] dataout;         //单位接收的1位ASCII码
//    wire [3:0] dataoutBCD;      //单位接收的1位BCD码
//    wire rdsig;                 //单个字符接收的握手信号
////    integer cnt;                //计数器，让multi_rdsig持续16个时钟周期
    
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
    
//    parameter IDLE  =2'b00;     //没有信号输入
//    parameter SAVE  =2'b01;     //将单位字符接收的字符寄存
//    parameter FINISH=2'b10;     //接收完毕
    
//    reg [1:0] current_state,next_state;
    
//    reg INbuf,INfall;       //INfall：IN的下降沿时INfall给出一个时钟周期宽度的高电平
//    always @(posedge clk)   //检测IN的下降沿
//    begin
//        INbuf <= IN;
//        INfall <= INbuf & (~IN);
//    end
//    reg rdsig_buf,rdsig_fall;   //rdsig_fall：rdsig的下降沿时rdsig_fall给出一个时钟周期的高电平
//    always @(posedge clk) begin //检测rdsig的下降沿
//        rdsig_buf<=rdsig;
//        rdsig_fall<=rdsig_buf&(~rdsig);
//    end
    
//    initial current_state=IDLE;
//    initial comand=0;
    
//    //计数器计数
////    always @(posedge clk)
////        if(current_state==IDLE || current_state==SAVE)
////            cnt<=0;
////        else
////            cnt<=cnt+1;             //FINISH状态进行计数，计到15状态跳转
    
//    //状态方程
//    always @(posedge clk)
//        current_state<=next_state;
    
//    //输出方程    
//    always @(posedge clk)           //移位寄存每个INfall只能存一次，因此用clk触发
//        case(next_state)            //next_state判断，解决状态跳转和输出依赖同一个信号的问题
//            IDLE: 
//                multi_rdsig=1'b0;
//            SAVE:
//            if(INfall)
//                comand={dataoutBCD,comand[19:0]};   
//            //最高位是AUTO/KEY，然后空格（用0代表），然后IF_PARA，然后空格，最低2位是PARA
//            FINISH:
//                multi_rdsig=1'b1;
//        endcase
        
//    //驱动方程
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
//                next_state=IDLE;            //FINISH持续一个时钟周期自动跳回IDLE
//        endcase
                    
    
//endmodule

`timescale 1ns / 1ps
//接收多位数据


module MultiReceive(
input clk,          //采样时钟clk_sample
input rst,          //将dataout清零
input IN,           //UART数据输入
output reg[23:0] command,     //接收数据输出，6位BCD码(N=24)；1位BCD码(N=4)
output reg rdsig,       //单个数据接收完成的握手信号
output reg rdsig_all    //多位数据全部接收完成的握手信号
);

initial command=0;

parameter cnt_END=183;    //cnt计数到cnt_END，单位数据接收完成
//175=11×16-1+8


integer cnt;
reg [7:0] dataout;      //单位数据ASCII码的输出
wire [3:0] dataoutBCD;   //单位数据BCD码输出
ASCII2BCD U0(
    .in(dataout),
    .out(dataoutBCD)
    );

reg INbuf, INfall, receive;
reg idle;               //线路是否占用
always @(posedge clk)   //检测线路的下降沿
begin
    INbuf <= IN;
    INfall <= INbuf & (~IN);
end

always @(posedge clk)
if (INfall && (~idle))  //检测到线路的下降沿并且原先线路为空闲，启动接收数据进程
        receive <= 1'b1;
else if(cnt == cnt_END)  //接收数据完成
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
                command<=0;//第一次进入cnt=0状态将命令清零，之后的循环从cnt=8开始，不会执行清零
                rdsig_all<=1'b0;
                idle <= 1'b1;
                cnt <= cnt + 8'd1;
                rdsig <= 1'b0;
            end
            8'd24:  //接收第0位数据
            begin
                rdsig_all<=1'b0;
                idle <= 1'b1;
                dataout[0] <= IN;
                cnt <= cnt + 8'd1;
                rdsig <= 1'b0;
            end
            8'd40: //接收第1位数据
            begin
                rdsig_all<=1'b0;
                idle <= 1'b1;
                dataout[1] <= IN;
                cnt <= cnt + 8'd1;
                rdsig <= 1'b0;
            end
            8'd56: //接收第2位数据
            begin
                rdsig_all<=1'b0;
                idle <= 1'b1;
                dataout[2] <= IN;
                cnt <= cnt + 8'd1;
                rdsig <= 1'b0;
                end
            8'd72: //接收第3位数据
            begin
                rdsig_all<=1'b0;
                idle <= 1'b1;
                dataout[3] <= IN;
                cnt <= cnt + 8'd1;
                rdsig <= 1'b0;
            end
            8'd88: //接收第4位数据
            begin
                rdsig_all<=1'b0;
                idle <= 1'b1;
                dataout[4] <= IN;
                cnt <= cnt + 8'd1;
                rdsig <= 1'b0;
            end
            8'd104: //接收第5位数据
            begin
                rdsig_all<=1'b0;
                idle <= 1'b1;
                dataout[5] <= IN;
                cnt <= cnt + 8'd1;
                rdsig <= 1'b0;
            end
            8'd120:     //接收第6位数据
            begin
                rdsig_all<=1'b0;
                idle <= 1'b1;
                dataout[6] <= IN;
                cnt <= cnt + 8'd1;
                rdsig <= 1'b0;
            end
            8'd136:     //接收第7位数据
            begin
                rdsig_all<=1'b0;
                idle <= 1'b1;
                dataout[7] <= IN;
                cnt <= cnt + 8'd1;
                rdsig <= 1'b1;//rdsig给出"握手信号",单个字符串接收完毕后，给出下降沿。
            end
            8'd152:     //接收停止位
            begin
                rdsig_all<=1'b0;
                idle <= 1'b1;
                cnt <= cnt + 8'd1;
                rdsig <= 1'b1;
                command<={command[19:0],dataoutBCD};    //移位寄存
            end
            8'd168:      //接收下一个数据的起始位
            begin
                rdsig<=1'b0;
                if(IN==0) begin      //有下一个数据
                    cnt<=8'd9;

                    idle<=1'b1;
                    rdsig_all<=1'b0;
                end
                else begin                    //无下一个数据
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
//UART发送模块deliver
module deliver(
input clk,          //UART时钟
input [7:0] datain, //需要发送的数据
input enable,        //发送命令，上升沿有效
output reg idle,        //线路状态指示，高为线路忙，低为线路空闲
output reg tx          //串行数据发送
);

reg send;
reg enablebuf, enablerise;
reg presult;
reg[7:0] cnt;       //计数器
parameter paritymode = 1'b0;

//检测发送命令enable的上升沿
always @(posedge clk) begin
    enablebuf <= enable;
    enablerise <= (~enablebuf) & enable;
end

always @(posedge clk) begin
if (enablerise &&  (~idle))  //当发送命令有效且线路为空闲时，启动新的数据发送进程
    send <= 1'b1;
else if(cnt == 8'd10)      //一帧资料发送结束
    send <= 1'b0;
end

always @(posedge clk) begin
if(send == 1'b1) begin
    case(cnt)       //产生起始位
    8'd0:
    begin
        tx <= 1'b0;
        idle <= 1'b1;
        cnt <= cnt + 8'd1;
    end
    8'd1:
    begin
        tx <= datain[0];    //发送数据0位
        presult <= datain[0]^paritymode;
        idle <= 1'b1;
        cnt <= cnt + 8'd1;
    end
    8'd2:
    begin
        tx <= datain[1];    //发送数据1位
        presult <= datain[1]^presult;
        idle <= 1'b1;
        cnt <= cnt + 8'd1;
    end
    8'd3:
    begin
        tx <= datain[2];    //发送数据2位
        presult <= datain[2]^presult;
        idle <= 1'b1;
        cnt <= cnt + 8'd1;
        end
    8'd4:
    begin
        tx <= datain[3];    //发送数据3位
        presult <= datain[3]^presult;
        idle <= 1'b1;
        cnt <= cnt + 8'd1;
    end
    8'd5:
    begin
        tx <= datain[4];    //发送数据4位
        presult <= datain[4]^presult;
        idle <= 1'b1;
        cnt <= cnt + 8'd1;
    end
    8'd6:
    begin
        tx <= datain[5];    //发送数据5位
        presult <= datain[5]^presult;
        idle <= 1'b1;
        cnt <= cnt + 8'd1;
    end
    8'd7:
    begin
        tx <= datain[6];    //发送数据6位
        presult <= datain[6]^presult;
        idle <= 1'b1;
        cnt <= cnt + 8'd1;
    end
    8'd8:
    begin
        tx <= datain[7];    //发送数据7位
        presult <= datain[7]^presult;
        idle <= 1'b1;
        cnt <= cnt + 8'd1;
    end
    8'd9:
    begin
        tx <= 1'b1;     //发送停止位             
        idle <= 1'b1;
        cnt <= cnt + 8'd1;
    end
    8'd10:
    begin
        tx <= 1'b1;             
        idle <= 1'b0;   //一帧资料发送结束
    //idle：握手信号，单个字符串发送完毕后，给出下降沿。
    cnt <= cnt + 8'd1;
    end
    default:
        cnt <= cnt + 8'd1;
    endcase
end
else begin
    tx <= 1'b1;
    cnt <= 8'd0;
    idle <= 1'b0;       //线路空
end
end
endmodule

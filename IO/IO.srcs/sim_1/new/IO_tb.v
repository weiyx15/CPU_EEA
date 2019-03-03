`timescale 1ns / 1ns

module IO_tb;
    reg [7:0] addr,Din;
    wire [7:0]Dout;
    reg CLK,RE,WE;
    wire [7:0] IO0,IO1, IO2,IO3,IO4, IO5, IO6,IO7;
    wire io_read,io_write;
    
//    assign IO0 = IO_reg[0];
//    assign IO1 = IO_reg[1];
//    assign IO2 = IO_reg[2];
//    assign IO3 = IO_reg[3];
//    assign IO4 = IO_reg[4];
//    assign IO5 = IO_reg[5];
//    assign IO6 = IO_reg[6];
//    assign IO7 = IO_reg[7];

    assign IO0 = (RE&&addr==0)? 0:8'bz;
    assign IO1 = (RE&&addr==1)? 1:8'bz;
    assign IO2 = (RE&&addr==2)? 2:8'bz;
    assign IO3 = (RE&&addr==3)? 3:8'bz;
    assign IO4 = (RE&&addr==4)? 4:8'bz;
    assign IO5 = (RE&&addr==5)? 5:8'bz;
    assign IO6 = (RE&&addr==6)? 6:8'bz;
    assign IO7 = (RE&&addr==7)? 7:8'bz;

    
    IO_2 U0(
    .addr(addr),
    .Din(Din),
    .RE(RE),
    .WE(WE),
    .Dout(Dout),
    .io_read(io_read),
    .io_write(io_write),
    .IO0(IO0),
    .IO1(IO1),
    .IO2(IO2),
    .IO3(IO3),
    .IO4(IO4),
    .IO5(IO5),
    .IO6(IO6),
    .IO7(IO7)
    );
         
    initial begin
        RE<=0;
        WE<=0;
        addr<=8'h00;  
        CLK<=0;
        Din<=8'h00;
        #2 WE<=1;
        fork
            forever #40 RE<=~RE;
            forever #40 WE<=~WE;
            forever #80 addr[2:0]<=addr[2:0]+1;
            forever #80 Din<=Din+1;
        join 
    end  
    
//    initial begin
//        IO_reg[0] = RE? 0:8'bz;
//        IO_reg[1] = RE? 1:8'bz;
//        IO_reg[2] = RE? 2:8'bz;
//        IO_reg[3] = RE? 3:8'bz;
//        IO_reg[4] = RE? 4:8'bz;
//        IO_reg[5] = RE? 5:8'bz;
//        IO_reg[6] = RE? 6:8'bz;
//        IO_reg[7] = RE? 7:8'bz;
//    end
    
    always #1 CLK<=~CLK;

    
endmodule
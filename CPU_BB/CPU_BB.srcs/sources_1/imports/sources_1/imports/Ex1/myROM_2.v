module ROM_2(
input [7:0] addr,
input CLK,
output reg [15:0] data);


always@(*) begin
	case(addr)
	   // ADD	
//        0:data<=16'h8A00;
//        1:data<=16'h98A5;
//        2:data<=16'h9986;
//        3:data<=16'h21C0;
//        4:data<=16'hCB30;
//        5:data<=16'h9800;
//        6:data<=16'h9902;
//        7:data<=16'h61C0;
//        8:data<=16'hCB31;

        // SUB
//        0:data<=16'h8A00;
//        1:data<=16'h98A5;
//        2:data<=16'h9986;
//        3:data<=16'h31C0;
//        4:data<=16'hCB32;
//        5:data<=16'h9800;
//        6:data<=16'h9902;
//        7:data<=16'h51C0;
//        8:data<=16'hCB33;

        // AND
//        0:data<=16'h8A00;
//        1:data<=16'h98A5;
//        2:data<=16'h9986;
//        3:data<=16'h01C0;
//        4:data<=16'hCB34;
//        5:data<=16'h9800;
//        6:data<=16'h9902;
//        7:data<=16'h01C0;
//        8:data<=16'hCB35;
        
        // OR
//        0:data<=16'h8A00;
//        1:data<=16'h98A5;
//        2:data<=16'h9986;
//        3:data<=16'h11C0;
//        4:data<=16'hCB36;
//        5:data<=16'h9800;
//        6:data<=16'h9902;
//        7:data<=16'h11C0;
//        8:data<=16'hCB37;
        
        // COMPARE
//        0:data<=16'h8A00;
//        1:data<=16'h9800;
//        2:data<=16'h9902;
//        3:data<=16'h41C0;
//        4:data<=16'hDE03;
//        5:data<=16'hCB38;
//        6:data<=16'hCA39;
//        7:data<=16'h7000;
//        8:data<=16'h44C0;
//        9:data<=16'hDE03;
//        10:data<=16'hCA38;
//        11:data<=16'hCB39;
//        12:data<=16'h7000;
//        13:data<=16'h98A5;
//        14:data<=16'h9986;
//        15:data<=16'h41C0;
//        16:data<=16'hDE03;
//        17:data<=16'hCB38;
//        18:data<=16'hCA39;
//        19:data<=16'h7000;
//        20:data<=16'h44C0;
//        21:data<=16'hDE03;
//        22:data<=16'hCA38;
//        23:data<=16'hCB39;
//        24:data<=16'h7000;
//        25:data<=16'hCA38;
//        26:data<=16'hCA39;
//        27:data<=16'h7000;

        
        // ADD display trial 1
//        0:data<=16'h8A00;
//        1:data<=16'h98A5;
//        2:data<=16'h9986;
//        3:data<=16'h21C0;
//        4:data<=16'hCB00;
//        5:data<=16'h9800;
//        6:data<=16'h9902;
//        7:data<=16'h61C0;
//        8:data<=16'hCB01;

        // ADD & SUB with display
        0:data<=16'h8A00;
        1:data<=16'h98A5;
        2:data<=16'h9986;
        3:data<=16'h21C0;
        4:data<=16'hCB00;
        5:data<=16'h9800;
        6:data<=16'h9902;
        7:data<=16'h61C0;
        8:data<=16'hCB01;
        9:data<=16'h8000;
        10:data<=16'h8500;
        11:data<=16'hA001;
        12:data<=16'hD201;
        13:data<=16'h700B;
        14:data<=16'hA501;
        15:data<=16'hD601;
        16:data<=16'h700B;
        17:data<=16'h98A5;
        18:data<=16'h9986;
        19:data<=16'h31C0;
        20:data<=16'hCB00;
        21:data<=16'h9800;
        22:data<=16'h9902;
        23:data<=16'h51C0;
        24:data<=16'hCB01;
        25:data<=16'h8000;
        26:data<=16'h8500;
        27:data<=16'hA001;
        28:data<=16'hD201;
        29:data<=16'h701B;
        30:data<=16'hA501;
        31:data<=16'hD601;
        32:data<=16'h701B;
        33:data<=16'h7000;

       default:data<=16'h7000;	         // default: JMP 0
	endcase
end

endmodule
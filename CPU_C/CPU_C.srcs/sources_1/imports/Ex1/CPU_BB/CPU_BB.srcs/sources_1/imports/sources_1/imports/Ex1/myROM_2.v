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
//        0:data<=16'h8A00;
//        1:data<=16'h98A5;
//        2:data<=16'h9986;
//        3:data<=16'h21C0;
//        4:data<=16'hCB00;
//        5:data<=16'h9800;
//        6:data<=16'h9902;
//        7:data<=16'h61C0;
//        8:data<=16'hCB01;
//        9:data<=16'h8000;
//        10:data<=16'h8500;
//        11:data<=16'hA001;
//        12:data<=16'hD201;
//        13:data<=16'h700B;
//        14:data<=16'hA501;
//        15:data<=16'hD601;
//        16:data<=16'h700B;
//        17:data<=16'h98A5;
//        18:data<=16'h9986;
//        19:data<=16'h31C0;
//        20:data<=16'hCB00;
//        21:data<=16'h9800;
//        22:data<=16'h9902;
//        23:data<=16'h51C0;
//        24:data<=16'hCB01;
//        25:data<=16'h8000;
//        26:data<=16'h8500;
//        27:data<=16'hA001;
//        28:data<=16'hD201;
//        29:data<=16'h701B;
//        30:data<=16'hA501;
//        31:data<=16'hD601;
//        32:data<=16'h701B;
//        33:data<=16'h7000;

        // display SRC
//        0:data<=16'h8A00;
//        1:data<=16'hB803;
//        2:data<=16'hB904;
//        3:data<=16'hC800;
//        4:data<=16'hC901;
//        5:data<=16'h7000;

        // display SRC,ALU_OP,DST
//        0:data<=16'h8A00;
//        1:data<=16'hBB02;
//        2:data<=16'hEE08;
//        3:data<=16'h8A00;
//        4:data<=16'hB803;
//        5:data<=16'hB904;
//        6:data<=16'hC800;
//        7:data<=16'hC901;
//        8:data<=16'hC810;
//        9:data<=16'hC911;
//        10:data<=16'h7000;
//        11:data<=16'h8A00;
//        12:data<=16'h9A01;
//        13:data<=16'hEE04;
//        14:data<=16'h8A00;
//        15:data<=16'hBB07;
//        16:data<=16'hCB12;
//        17:data<=16'h7000;
//        18:data<=16'h8A00;
//        19:data<=16'h9A02;
//        20:data<=16'hEE08;
//        21:data<=16'h8A00;
//        22:data<=16'hB805;
//        23:data<=16'hB906;
//        24:data<=16'hC800;
//        25:data<=16'hC901;
//        26:data<=16'hC813;
//        27:data<=16'hC914;
//        28:data<=16'h7000;


        // Calculator
        0:data<=16'h8000;
        1:data<=16'hB302;
        2:data<=16'hEC08;
        3:data<=16'h8A00;
        4:data<=16'hB803;
        5:data<=16'hB904;
        6:data<=16'hC800;
        7:data<=16'hC901;
        8:data<=16'hC810;
        9:data<=16'hC911;
        10:data<=16'h7000;
        11:data<=16'h8000;
        12:data<=16'h9001;
        13:data<=16'hEC04;
        14:data<=16'h8A00;
        15:data<=16'hB807;
        16:data<=16'hC812;
        17:data<=16'h7000;
        18:data<=16'h8000;
        19:data<=16'h9002;
        20:data<=16'hEC08;
        21:data<=16'h8A00;
        22:data<=16'hB805;
        23:data<=16'hB906;
        24:data<=16'hC800;
        25:data<=16'hC901;
        26:data<=16'hC813;
        27:data<=16'hC914;
        28:data<=16'h7000;
        29:data<=16'h8000;
        30:data<=16'h9001;
        31:data<=16'hE808;
        32:data<=16'h8A00;
        33:data<=16'hB810;
        34:data<=16'hB911;
        35:data<=16'hC800;
        36:data<=16'hC901;
        37:data<=16'h8A00;
        38:data<=16'h9A01;
        39:data<=16'h7000;
        40:data<=16'h8A00;
        41:data<=16'hBB12;
        42:data<=16'h9A01;
        43:data<=16'hEE0B;
        44:data<=16'h8A00;
        45:data<=16'hB810;
        46:data<=16'hB913;
        47:data<=16'h21C0;
        48:data<=16'hCB10;
        49:data<=16'hB811;
        50:data<=16'hB914;
        51:data<=16'h61C0;
        52:data<=16'hCB11;
        53:data<=16'h9A01;
        54:data<=16'h7000;
        55:data<=16'h8A00;
        56:data<=16'h9A02;
        57:data<=16'hEE0B;
        58:data<=16'h8A00;
        59:data<=16'hB810;
        60:data<=16'hB913;
        61:data<=16'h31C0;
        62:data<=16'hCB10;
        63:data<=16'hB811;
        64:data<=16'hB914;
        65:data<=16'h51C0;
        66:data<=16'hCB11;
        67:data<=16'h9A01;
        68:data<=16'h7000;
        69:data<=16'h8A00;
        70:data<=16'h9A03;
        71:data<=16'hEE0B;
        72:data<=16'h8A00;
        73:data<=16'hB810;
        74:data<=16'hB913;
        75:data<=16'h01C0;
        76:data<=16'hCB10;
        77:data<=16'hB811;
        78:data<=16'hB914;
        79:data<=16'h01C0;
        80:data<=16'hCB35;
        81:data<=16'h9A01;
        82:data<=16'h7000;
        83:data<=16'h8A00;
        84:data<=16'h9A04;
        85:data<=16'hEE0B;
        86:data<=16'h8A00;
        87:data<=16'hB810;
        88:data<=16'hB913;
        89:data<=16'h11C0;
        90:data<=16'hCB10;
        91:data<=16'hB811;
        92:data<=16'hB914;
        93:data<=16'h11C0;
        94:data<=16'hCB11;
        95:data<=16'h9A01;
        96:data<=16'h7000;
        97:data<=16'h8A00;
        98:data<=16'h9A05;
        99:data<=16'hEE1F;
        100:data<=16'h8A00;
        101:data<=16'hB811;
        102:data<=16'hB914;
        103:data<=16'h41C0;
        104:data<=16'hDE03;
        105:data<=16'hCB10;
        106:data<=16'hCA11;
        107:data<=16'h7082;
        108:data<=16'h44C0;
        109:data<=16'hDE03;
        110:data<=16'hCA10;
        111:data<=16'hCA11;
        112:data<=16'h7082;
        113:data<=16'hB810;
        114:data<=16'hB913;
        115:data<=16'h41C0;
        116:data<=16'hDE03;
        117:data<=16'hCB10;
        118:data<=16'hCA11;
        119:data<=16'h7082;
        120:data<=16'h44C0;
        121:data<=16'hDE03;
        122:data<=16'hCA10;
        123:data<=16'hCA11;
        124:data<=16'h7082;
        125:data<=16'h8F00;
        126:data<=16'h9F02;
        127:data<=16'hCB10;
        128:data<=16'hCA11;
        129:data<=16'h7082;
        130:data<=16'h9A01;
        131:data<=16'h7000;










       default:data<=16'h7000;	         // default: JMP 0
	endcase
end

endmodule
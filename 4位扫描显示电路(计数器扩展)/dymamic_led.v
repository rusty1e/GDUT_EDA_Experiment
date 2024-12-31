`timescale 1ns/1ns
module dynamic_led(Seg, Sl, Clk, Reset, I);
    output [3:0] Seg;
    output [3:0] Sl;
    input I;
    input Clk, Reset;
    
    reg [3:0] Sl_reg, Disp_dat;
    reg [3:0] c1, c2, c3, c4;  // ?????
    reg [7:0] cnt;  // ???
    reg [1:0] count;  // ??????
    
    wire LT_N, BI_N, LE;
    assign LT_N = 1;  // ?????
    assign BI_N = 1;  // ????
    assign LE = 0;    // ?????

    // ???????
    always @(posedge Clk or posedge Reset) begin
        if (Reset) begin
            count <= 2'b00;  // ?????????
            cnt <= 0;        // ?????
            c1 <= 0;         // ????????
            c2 <= 0;
            c3 <= 0;
            c4 <= 0;
        end else begin
            // ???????????????
            count <= count + 1;  
            
            if (I == 1'b1) begin
                // ?I?1???????
                cnt <= cnt + 1;
                if (cnt >= 4) begin
                    cnt <= 0;
                    c1 <= c1 + 1;  // ?16??????c1??
                end
                if (c1 >= 10) begin
                    c2 <= c2 + 1;  // c1??10??c2??
                    c1 <= 0;
                end
                if (c2 >= 10) begin
                    c3 <= c3 + 1;  // c2??10??c3??
                    c2 <= 0;
                end
                if (c3 >= 10) begin
                    c4 <= c4 + 1;  // c3??10??c4??
                    c3 <= 0;
                end
                if (c4 >= 10) begin
                    // ????
                    c1 <= 0;
                    c2 <= 0;
                    c3 <= 0;
                    c4 <= 0;
                end
            end
        end
    end

    // ???????????
    always @(*) begin
        case (I)
            1'b0: begin
                // ?I?0?????????
                case (count)
                    2'b00: Disp_dat = 4'b0100;  // ??0
                    2'b01: Disp_dat = 4'b0111;  // ??1
                    2'b10: Disp_dat = 4'b0101;  // ??2
                    2'b11: Disp_dat = 4'b0000;  // ??3
                    default: Disp_dat = 4'b0000;
                endcase
                // ????????
                case (count)
                    2'b00: Sl_reg = 4'b1110;
                    2'b01: Sl_reg = 4'b1101;
                    2'b10: Sl_reg = 4'b1011;
                    2'b11: Sl_reg = 4'b0111;
                    default: Sl_reg = 4'b1111;
                endcase
            end
            1'b1: begin
                // ?I?1???????
                case (count)
                    2'b00: Disp_dat = c1;
                    2'b01: Disp_dat = c2;
                    2'b10: Disp_dat = c3;
                    2'b11: Disp_dat = c4;
                    default: Disp_dat = 4'b0000;
                endcase
                // ????????
                case (count)
                    2'b00: Sl_reg = 4'b1110;
                    2'b01: Sl_reg = 4'b1101;
                    2'b10: Sl_reg = 4'b1011;
                    2'b11: Sl_reg = 4'b0111;
                    default: Sl_reg = 4'b1111;
                endcase
            end
            default: begin
                Disp_dat = 4'b0000;
                Sl_reg = 4'b1111;
            end
        endcase
    end

    // ????????
    assign Seg = Disp_dat;
    assign Sl = Sl_reg;

endmodule

`timescale 1ns/1ns

module horse_race_lamp(input[1:0]S,input clk,input reset,output reg[7:0]Y,output reg clk_div);
reg [3:0] cnt;
//reg clk_div;
reg[3:0]state;
parameter 
S0=0,
S1=1,
S2=2,
S3=3,
S4=4,
S5=5,
S6=6,
S7=7,
S8=8,
S9=9,
S10=10,
S11=11,
S12=12,
S13=13,
S14=14,
S15=15;

reg [3:0] div_scale;

/*
always @(S) begin
   case (S)
         2'b00: div_threshold <= 2;
         2'b01: div_threshold <= 4;
         2'b10: div_threshold <= 8;
         default: div_threshold <= 1;
   endcase
end
*/

always @(posedge clk or posedge reset) begin
    if (reset) begin
        div_scale <= 16'd1; // reset ??? 1
    end else begin
        case (S)
            2'b01: div_scale <= 2;
            2'b10: div_scale <= 8;
            2'b11: div_scale <= 4;
            default: div_scale <= 4;
        endcase
    end
end


always @(posedge clk or posedge reset)
begin
    if (reset) begin
            cnt <= 4'd0;
            clk_div <= 1'b0;
    end else begin
	if(cnt >= (div_scale-1)/2)
			begin
				clk_div<=~clk_div;
				cnt<=4'd0;
			end
	else begin
			cnt<=cnt+1;
    end
  end
end

always@(posedge clk_div or posedge reset)
begin
	if(reset)
		begin
			Y[7:0]<=8'b0000_0000;
			state<=S0;
		end
	else
	case({S[1],S[0]})
    2'b01:
	begin
		case(state)//11110000
		S0: begin Y[7:0]<= 8'b1010_1010; state <= S1; end
        S1: begin Y[7:0]<= 8'b0000_0000; state <= S2; end
        S2: begin Y[7:0]<= 8'b0101_0101; state <= S3; end
        S3: begin Y[7:0]<= 8'b0000_0000; state <= S0; end
        default: begin Y[7:0]<= 8'b0000_0000; state <= S0; end
		endcase
	end
	2'b10:
	begin
		case(state)
		S0: begin Y[7:0]<= 8'b1000_0000; state <= S1; end
        S1: begin Y[7:0]<= 8'b1100_0000; state <= S2; end
        S2: begin Y[7:0]<= 8'b1110_0000; state <= S3; end
        S3: begin Y[7:0]<= 8'b1111_0000; state <= S4; end
        S4: begin Y[7:0]<= 8'b1111_1000; state <= S5; end
        S5: begin Y[7:0]<= 8'b1111_1100; state <= S6; end
        S6: begin Y[7:0]<= 8'b1111_1110; state <= S7; end
        S7: begin Y[7:0]<= 8'b1111_1111; state <= S8; end
        S8: begin Y[7:0]<= 8'b0111_1111; state <= S9; end
        S9: begin Y[7:0]<= 8'b0011_1111; state <= S10; end
        S10: begin Y[7:0]<= 8'b0001_1111; state <= S11; end
        S11: begin Y[7:0]<= 8'b0000_1111; state <= S12; end
        S12: begin Y[7:0]<= 8'b0000_0111; state <= S13; end
        S13: begin Y[7:0]<= 8'b0000_0011; state <= S14; end
        S14: begin Y[7:0]<= 8'b0000_0001; state <= S15; end
        S15: begin Y[7:0]<= 8'b0000_0000; state <= S0; end
        default: begin Y[7:0]<= 8'b0000_0000; state <= S0; end
		endcase
	end
	2'b11:
	begin
		case(state)
		S0: begin Y[7:0]<= 8'b1000_0001; state <= S1; end
        S1: begin Y[7:0]<= 8'b1100_0011; state <= S2; end
        S2: begin Y[7:0]<= 8'b1110_0111; state <= S3; end
        S3: begin Y[7:0]<= 8'b1111_1111; state <= S4; end
        S4: begin Y[7:0]<= 8'b0111_1110; state <= S5; end
        S5: begin Y[7:0]<= 8'b0011_1100; state <= S6; end
        S6: begin Y[7:0]<= 8'b0001_1000; state <= S7; end
        S7: begin Y[7:0]<= 8'b0000_0000; state <= S0; end
        default: begin Y[7:0]<= 8'b0000_0000; state <= S0; end
		endcase
	end
	2'b00:
	begin
		case(state)
		S0:begin Y[7:0]<=8'b0001_1000;state<=S1;end
		S1:begin Y[7:0]<=8'b0010_0100;state<=S2;end
		S2:begin Y[7:0]<=8'b0100_0010;state<=S3;end
		S3:begin Y[7:0]<=8'b1000_0001;state<=S4;end
		S4:begin Y[7:0]<=8'b0100_0010;state<=S5;end
		S5:begin Y[7:0]<=8'b0010_0100;state<=S6;end
		S6:begin Y[7:0]<=8'b0001_1000;state<=S0;end
		default begin Y[7:0]<=8'b0000_0000;state<=S0;end
		endcase
	end
	default
		Y[7:0]<=8'b0000_0000;
	endcase
end
endmodule
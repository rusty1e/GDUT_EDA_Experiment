
`timescale 1ns/1ns

module tb_led;

reg clk,reset,i;
wire [3:0]seg;
wire [3:0]sl;

dynamic_led tb(.Seg(seg),.Sl(sl),.Clk(clk),.Reset(reset),.I(i));



parameter DELY=20;
always #(DELY/2)clk=~clk;

initial
begin
clk=0;reset=0;
i=0;
#(DELY*2) reset=1;
#DELY reset=0;
#500 i=1;
#(DELY*100) $finish;
end

endmodule

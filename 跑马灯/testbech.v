`timescale 1ns / 1ns
 
module tb_horse_race_lamp;


    reg [1:0] S;   
    reg clk;  
    reg reset;      

  
    wire [7:0] Y;  

 
    horse_race_lamp uut (
        .S(S),
        .clk(clk),
        .reset(reset),
        .Y(Y)
    );

    initial begin
        clk = 0;  
        forever #5 clk = ~clk; 
    end

 
    initial begin
        $display("Running testbench");

        
        reset = 1; 
        S = 2'b00;  
        #10 reset = 0;  
        #400;        

 
        reset = 1; 
        #5 reset = 0;  
        S = 2'b01;     
        #200;        

        reset = 1;
        #5 reset = 0;
        S = 2'b10;  
        #200;          

        reset = 1;
        #5 reset = 0;
        S = 2'b11;   
        #100;         

        $stop;     
    end

endmodule

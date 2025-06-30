`timescale 1ps/1ps

module top_module ();
    
    reg clk, reset,t;
    wire q;
    
    tff DUT(clk, reset, t,q);
    
    initial clk = 1'b0;
    
    initial begin
    reset = 1'b0;
        t = 1'b0;
        #10;
        reset = 1'b1;
        t = 1'b0;
        #10;
        reset = 1'b0;
        t = 1'b0;
        #10;
        reset = 1'b0;
        t = 1'b1;
        #10;
        reset = 1'b0;
        t = 1'b0;
        
    end
    
    always begin
    #5 clk = ~ clk;
    end
    

endmodule
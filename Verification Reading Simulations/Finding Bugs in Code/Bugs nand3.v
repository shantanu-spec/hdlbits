module top_module (input a, input b, input c, output out);//

    wire outneg;
    andgate inst1 ( outneg, a, b, c, 1'b1,1'b1 );
    
    assign out = ~outneg;

endmodule
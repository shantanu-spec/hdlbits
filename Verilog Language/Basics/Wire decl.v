`default_nettype none
module top_module(
    input a,
    input b,
    input c,
    input d,
    output out,
    output out_n   ); 
    
   wire imm1,imm2;
    
    assign imm1 = (a&b);
    assign imm2 = (c&d);
    assign out = (imm1|imm2);
    assign out_n = ~(imm1|imm2);

endmodule

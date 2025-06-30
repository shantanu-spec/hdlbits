module top_module ( 
    input p1a, p1b, p1c, p1d, p1e, p1f,
    output p1y,
    input p2a, p2b, p2c, p2d,
    output p2y );
    
wire imm1,imm2,imm3,imm4;
    assign imm1 = (p2a & p2b);
    assign imm2 = (p2c & p2d);
    assign p2y = (imm1 | imm2);
    
    assign imm3 = (p1a & p1b & p1c);
    assign imm4 = (p1d & p1e & p1f);
    assign p1y = (imm3 | imm4);

endmodule

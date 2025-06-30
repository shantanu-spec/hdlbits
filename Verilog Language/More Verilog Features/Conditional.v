module top_module (
    input [7:0] a, b, c, d,
    output [7:0] min);//

    
    wire [7:0] imm1,imm2;
    assign imm1 = (a<b) ? a : b; 
    assign imm2 = (imm1<c) ? imm1 : c;
    assign min = (imm2<d) ? imm2 : d;
     // assign intermediate_result1 = compare? true: false;

endmodule

module top_module(
    input [31:0] a,
    input [31:0] b,
    input sub,
    output [31:0] sum
);
    wire[15:0] sumout1,sumout2;
    wire temp,temp2;
    
    add16 adder(a[15:0],(b[15:0]^{16{sub}}),sub,sumout1,temp);
    add16 subtracter(a[31:16],(b[31:16]^{16{sub}}),temp,sumout2,temp2);
    
    assign sum = {sumout2,sumout1};
endmodule

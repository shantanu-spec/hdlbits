module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
    wire [15:0] sumout1,sumout2;
    wire temp,temp2;
    
    add16 adder1(a[15:0],b[15:0],0,sumout1,temp);
    add16 adder2(a[31:16],b[31:16],temp,sumout2,temp2);
    
    assign sum = {sumout2,sumout1};

endmodule

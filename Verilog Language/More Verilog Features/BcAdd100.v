module top_module( 
    input [399:0] a, b,
    input cin,
    output cout,
    output [399:0] sum );

    wire[99:0] cout_outs;
    
    genvar i;
    
    generate
        bcd_fadd(a[3:0],b[3:0],cin,cout_outs[0],sum[3:0]);
        for(i = 4;i<=399;i = i+4) 
            begin : bdc_add100
            bcd_fadd u0(a[3+i:i],b[3+i:i],cout_outs[i/4-1],cout_outs[i/4],sum[3+i:i]);
            end
    endgenerate
    
    assign cout = cout_outs[99];
endmodule

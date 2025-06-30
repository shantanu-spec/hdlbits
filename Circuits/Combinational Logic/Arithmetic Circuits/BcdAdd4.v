module top_module ( 
    input [15:0] a, b,
    input cin,
    output cout,
    output [15:0] sum );

    wire [3:0] inter_cout;
    
    bcd_fadd bc1(.a(a[3:0]),
                 .b(b[3:0]),
                 .cin(cin),
                 .cout(inter_cout[0]),
                 .sum(sum[3:0]) );
    
    genvar i;
    generate
        for (i = 1;i<4;i++)
            begin:bcdadders
                
                bcd_fadd bcdaddervar(.a(a[4*(i+1)-1:4*i]),
                                     .b(b[4*(i+1)-1:4*i]),
                                     .cin(inter_cout[i-1]),
                                     .cout(inter_cout[i]),
                                     .sum(sum[4*(i+1)-1:4*i]) );
            end
        
    endgenerate
    assign cout = inter_cout[3];
endmodule

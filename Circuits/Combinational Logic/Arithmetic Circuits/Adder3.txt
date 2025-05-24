module top_module( 
    input [2:0] a, b,
    input cin,
    output [2:0] cout,
    output [2:0] sum );
    
    wire[2:0] inter_cout;

    fadder finst0 (.a(a[0]),.b(b[0]),.cin(cin),.cout(inter_cout[0]),.sum(sum[0]));
    
    genvar i;
    
    generate
        for(i = 1;i<3;i++)
            begin:adders
                fadder finst0 (.a(a[i]),.b(b[i]),.cin(inter_cout[i-1]),.cout(inter_cout[i]),.sum(sum[i]));
            end        
    endgenerate
      assign cout = inter_cout;
    
    
    
    
endmodule

module fadder( 
    input a, b, cin,
    output cout, sum );

    assign sum = a^b^cin;
    assign cout = (a&b)|(b&cin)|(a&cin);
    
endmodule

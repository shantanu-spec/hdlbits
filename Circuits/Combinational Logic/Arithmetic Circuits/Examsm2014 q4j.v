module top_module (
    input [3:0] x,
    input [3:0] y, 
    output [4:0] sum);
    
    wire[3:0] inter_cout;
    
    FA finst0(.a(x[0]),.b(y[0]),.cin(1'b0),.cout(inter_cout[0]),.sum(sum[0]));

    genvar i;
    
    generate
        for(i = 1;i<4;i++)
            begin: addrs
                FA finstadd(.a(x[i]),.b(y[i]),.cin(inter_cout[i-1]),.cout(inter_cout[i]),.sum(sum[i]));
            end
        
    endgenerate
    
    assign sum[4] = inter_cout[3];
endmodule


module FA( 
    input a, b, cin,
    output cout, sum );

    assign sum = a^b^cin;
    assign cout = (a&b)|(b&cin)|(a&cin);
    
endmodule

module top_module ( input clk, input d, output q );
    wire in1,in2;
    my_dff dff1(clk, d, in1);
    my_dff dff2(clk, in1, in2);
    my_dff dff3(clk, in2 ,q);
endmodule

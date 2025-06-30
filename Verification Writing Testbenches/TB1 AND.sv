module top_module();

    
    logic [1:0] in;
    wire out;
    
    andgate test(in,out);
     initial begin
         {in[0],in[1]} = 2'd00;
         #10;
         {in[0],in[1]} = 2'd10;
         #10;
         {in[0],in[1]} = 2'd01;
         #10;
         {in[0],in[1]} = 2'd11;
         
     end
    
    
endmodule
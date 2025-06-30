module top_module (
    input clk,
    input d,
    output q
);
    reg temp_pos, temp_neg;
    
    
    always@(posedge clk)
        begin
   			temp_pos <= d;     	
        end
    always@(negedge clk)
        begin 
           	temp_neg <= d; 
        end
    
    assign q = clk ? temp_pos :temp_neg;
    
    

endmodule

module top_module (
    input clk,
    input reset,
    output [3:0] q);


    always@(posedge clk)
        begin
            if(reset)
                begin
                	q <= 1;
                end
            else
                begin
                    if(q>9)
                    q<=1;
                    else
                        q <=q+1;
                        
                end
                end
endmodule

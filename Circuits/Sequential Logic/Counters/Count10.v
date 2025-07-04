module top_module (
    input clk,
    input reset,        // Synchronous active-high reset
    output [3:0] q);

    always@(posedge clk)
        begin
            if(reset)
                begin
                	q <= 0;
                end
            else
                begin
                    if(q>8)
                    q<=0;
                    else
                        q <=q+1;
                        
                end
                end
endmodule
